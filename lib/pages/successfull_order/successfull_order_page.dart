import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/pages/filling_data/widgets/container_with_star.dart';
import 'package:flutter_application_1/pages/plans_page_view/general.dart';
import 'package:flutter_application_1/pages/plans_page_view/widgets/gradient_button.dart';
import 'package:flutter_application_1/widgets/custom_app_bar.dart';
import 'package:flutter_application_1/widgets/custom_transition.dart';
import 'package:flutter_application_1/widgets/default_container.dart';
import 'package:swipe/swipe.dart';

class SuccessFullOrderPage extends StatefulWidget {
  const SuccessFullOrderPage({Key? key}) : super(key: key);

  @override
  _SuccessFullOrderPageState createState() => _SuccessFullOrderPageState();
}

class _SuccessFullOrderPageState extends State<SuccessFullOrderPage> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Swipe(
      onSwipeRight: () => Navigator.of(context)
          .pushAndRemoveUntil(CustomPageRoute(const General()), (r) => false),
      child: Scaffold(
        backgroundColor: AppConfig.whiteColor,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const CustomAppBar(isBackArrow: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    /// Анимация
                    Padding(
                      padding: const EdgeInsets.only(left: 67, right: 66),
                      child:
                          Image.asset('lib/assets/gif/order_was_created.gif'),
                    ),
                    const SizedBox(height: 37),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 22.0),
                      child: _text(),
                    ),
                    // Image.asset('lib/assets/images/unicorn.png')
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22.0),
              child: Column(
                children: [
                  /// Подарок
                  Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      DefaultContainer(
                        width: width,
                        child: const Padding(
                          padding:
                              EdgeInsets.only(left: 18, top: 13, bottom: 13),
                          child: Text(
                            'Обработка антисептиком в подарок',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w700,
                              color: AppConfig.blueColor,
                            ),
                          ),
                        ),
                      ),
                      const ContainerWithStar(
                        isActive: true,
                      ),
                    ],
                  ),
                  const SizedBox(height: 17),

                  ///Градиент кнопка
                  GradientButton(
                    text: 'Отлично',
                    startColor: AppConfig.stepsGradientStartThird,
                    endColor: AppConfig.stepsGradientEndThird,
                    onTap: () {
                      Navigator.of(context).pushAndRemoveUntil(
                          CustomPageRoute(const General()), (r) => false);
                    },
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _text() {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
            children: [
              TextSpan(
                text: 'Восхитительно! ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppConfig.blueColor,
                ),
              ),
              TextSpan(
                text:
                    'Мастер уже летит на помощь, в скором времени перезвонит, а команда ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppConfig.blackColor,
                ),
              ),
              TextSpan(
                text: 'OPA ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppConfig.blueColor,
                ),
              ),
              TextSpan(
                text: 'Clean ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: AppConfig.blackColor,
                ),
              ),
              TextSpan(
                text:
                    'благодарит за возможность сделать чистым каждый миллиметр ещё уютнее ',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppConfig.blackColor,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          right: 60,
          child: Image.asset(
            'lib/assets/images/unicorn.png',
            width: 18,
          ),
        )
      ],
    );
  }
}
