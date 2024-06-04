import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/controllers/general_controller.dart';
import 'package:flutter_application_1/models/info_card_model.dart';
import 'package:flutter_application_1/models/point_row.dart';
import 'package:flutter_application_1/pages/choose_services/choose_services.dart';
import 'package:flutter_application_1/pages/plans_page_view/widgets/gradient_button.dart';
import 'package:flutter_application_1/pages/plans_page_view/widgets/plan_card.dart';
import 'package:flutter_application_1/pages/plans_page_view/widgets/plan_position.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_transition.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class General extends StatefulWidget {
  const General({Key? key}) : super(key: key);
  @override
  _GeneralState createState() => _GeneralState();
}

class _GeneralState extends State<General> {
  late int currentIndex;
  late PageController pageControllerPage;
  late ScrollController pageControllerBackground;
  late List<PointRowModel> pointsList;
  late List<InfoCardModel> cardsList;

  // Градиенты
  late Color pointGradientStart;
  late Color pointGradientEnd;
  late Color buttonGradientStart;
  late Color buttonGradientEnd;
  late Color stepsGradientStart;
  late Color stepsGradientEnd;

  @override
  void initState() {
    super.initState();
    currentIndex = 0;
    setconfigurationPage(currentIndex);
    pageControllerPage = PageController(initialPage: 0);
    pageControllerBackground = ScrollController(initialScrollOffset: 0.0);
    cardsList = [
      InfoCardModel(
        square: AppConfig.square50,
        price: AppConfig.price50,
        previousPrice: AppConfig.previousPrice50,
        image: 'lib/assets/images/first_step.png',
      ),
      InfoCardModel(
          square: AppConfig.square70,
          price: AppConfig.price70,
          previousPrice: AppConfig.previousPrice70,
          image: 'lib/assets/images/second_step.png'),
      InfoCardModel(
          square: AppConfig.square90,
          price: AppConfig.price90,
          previousPrice: AppConfig.previousPrice90,
          image: 'lib/assets/images/third_step.png'),
    ];
    pointsList = [
      PointRowModel(
        title: 'Все на своих местах',
        description: 'Гарантия сохранности',
        icon: 'lib/assets/images/pen.png',
      ),
      PointRowModel(
        title: 'Воскресим Порядок',
        description: 'Постель заправлена, чистоста',
        icon: 'lib/assets/images/butterfly.png',
        isDoubleColor: true,
      ),
      PointRowModel(
        title: 'Постираем одежду',
        description: 'Морозная свежесть белья',
        icon: 'lib/assets/images/sun.png',
      ),
      PointRowModel(
        title: 'Анигиляция пыли',
        description: 'Пыль в ничто – чистота во всем!',
        icon: 'lib/assets/images/bird.png',
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    var controller = Provider.of<GeneralController>(context);
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
        backgroundColor: AppConfig.whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomAppBar(isBackArrow: true),
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Карточки с площадью и ценой
                    SizedBox(
                      width: width,
                      height: width - 52,
                      child: PageView(
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index) {
                          setState(() {
                            currentIndex = index;
                            setconfigurationPage(index);
                          });
                        },
                        controller: pageControllerPage,
                        children: List.generate(
                          cardsList.length,
                          (index) => Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 36.0),
                            child: PlanCard(
                              item: cardsList[index],
                              onTap: () {
                                controller.orderController.init();
                                controller.orderController
                                    .setSquare(index: currentIndex);
                                controller.orderController
                                    .countTotal(cardsList[currentIndex].price);
                                Navigator.of(context).push(
                                    CustomPageRoute(const ChooseServices()));
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    /// Виджет позиции в PageView
                    Padding(
                      padding: const EdgeInsets.only(left: 139.0, right: 139.0),
                      child: PlanPosition(
                        width: (width - 290) / 3,
                        height: 7,
                        currentIndex: currentIndex,
                        colorStart: stepsGradientStart,
                        colorEnd: stepsGradientEnd,
                      ),
                    ),
                    const SizedBox(height: 23),

                    /// Белый контейнер с подробным описанием и кнопкой
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        width: width,
                        decoration: BoxDecoration(
                          color: AppConfig.whiteColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(50),
                            topRight: Radius.circular(50),
                          ),
                          boxShadow: [
                            BoxShadow(
                              blurRadius: 20,
                              color: AppConfig.blackColor.withOpacity(0.05),
                            )
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 22.0, vertical: 32),
                          child: Column(
                            children: [
                              // Пункты
                              Padding(
                                padding: const EdgeInsets.only(left: 14.0),
                                child: Column(
                                  children:
                                      List.generate(pointsList.length, (index) {
                                    return _buildRow(
                                      title: pointsList[index].title,
                                      description:
                                          pointsList[index].description,
                                      emodji: pointsList[index].icon,
                                      startColor: pointGradientStart,
                                      endColor: pointGradientEnd,
                                      isDoubleColor:
                                          pointsList[index].isDoubleColor,
                                    );
                                  }),
                                ),
                              ),
                              const SizedBox(height: 16),
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),

            /// Нижний блок [Градиент кнопка]
            Container(
              width: width,
              color: AppConfig.whiteColor,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 22.0, right: 22.0, bottom: 22, top: 12),
                child: GradientButton(
                  text: 'Продолжить',
                  onTap: () {
                    controller.orderController.init();

                    controller.orderController.setSquare(index: currentIndex);
                    controller.orderController
                        .countTotal(cardsList[currentIndex].price);
                    Navigator.of(context)
                        .push(CustomPageRoute(const ChooseServices()));
                  },
                  startColor: buttonGradientStart,
                  endColor: buttonGradientEnd,
                ),
              ),
            ),
          ],
        ));
  }

  void setconfigurationPage(int index) {
    switch (index) {
      case 0:
        setState(() {
          pointGradientStart = AppConfig.pointGradientStartFirst;
          pointGradientEnd = AppConfig.pointGradientEndFirst;
          buttonGradientStart = AppConfig.buttonGradientStartFirst;
          buttonGradientEnd = AppConfig.buttonGradientEndFirst;
          stepsGradientStart = AppConfig.stepsGradientStartFirst;
          stepsGradientEnd = AppConfig.stepsGradientEndFirst;
        });
        break;
      case 1:
        setState(() {
          pointGradientStart = AppConfig.pointGradientStartSecond;
          pointGradientEnd = AppConfig.pointGradientEndSecond;
          buttonGradientStart = AppConfig.buttonGradientStartSecond;
          buttonGradientEnd = AppConfig.buttonGradientEndSecond;
          stepsGradientStart = AppConfig.stepsGradientStartSecond;
          stepsGradientEnd = AppConfig.stepsGradientEndSecond;
        });
        break;
      case 2:
        setState(() {
          pointGradientStart = AppConfig.pointGradientStartThird;
          pointGradientEnd = AppConfig.pointGradientEndThird;
          buttonGradientStart = AppConfig.buttonGradientStartThird;
          buttonGradientEnd = AppConfig.buttonGradientEndThird;
          stepsGradientStart = AppConfig.stepsGradientStartThird;
          stepsGradientEnd = AppConfig.stepsGradientEndThird;
        });
        break;
      default:
        setState(() {
          pointGradientStart = AppConfig.pointGradientStartFirst;
          pointGradientEnd = AppConfig.pointGradientEndFirst;
          buttonGradientStart = AppConfig.buttonGradientStartFirst;
          buttonGradientEnd = AppConfig.buttonGradientEndFirst;
          stepsGradientStart = AppConfig.stepsGradientStartFirst;
          stepsGradientEnd = AppConfig.stepsGradientEndFirst;
        });
        break;
    }
  }

  Widget _buildRow({
    required String title,
    required String description,
    required String emodji,
    required Color startColor,
    required Color endColor,
    bool isDoubleColor = false,
  }) {
    var titleList = title.split(' ');
    return Padding(
      padding: const EdgeInsets.only(bottom: 11.0),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            height: 35,
            width: 35,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(90),
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      startColor,
                      endColor,
                    ]),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 20,
                    color: AppConfig.blackColor.withOpacity(0.05),
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: SvgPicture.asset(
                  'lib/assets/images/daw.svg',
                  width: 19,
                  height: 19,
                ),
              ),
            ),
          ),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  isDoubleColor
                      ? RichText(
                          text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: '${titleList[0]} ',
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppConfig.blackColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          TextSpan(
                            text: titleList[1],
                            style: const TextStyle(
                              fontSize: 14,
                              color: AppConfig.blueColor,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ]))
                      : Text(
                          title,
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                  const SizedBox(width: 4),
                  Image.asset(
                    emodji,
                    width: 14,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                description,
                style: TextStyle(
                    color: AppConfig.blackColor.withOpacity(0.25),
                    fontSize: 14,
                    fontWeight: FontWeight.w400),
              )
            ],
          )
        ],
      ),
    );
  }
}
