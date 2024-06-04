import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/models/services.dart';
import '../animation/fade_animation.dart';
import '../../config/constants.dart';
import '../utils/components/rounded_button.dart';
import '../utils/components/rounded_login_button.dart';
import 'login_screen.dart';
import 'signup_screen.dart';

class WelcomeScreen extends StatefulWidget{

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}
class _WelcomeScreenState extends State<WelcomeScreen> {

  List<Service> services = [
    Service('Уборка', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-cleaning-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Паяльщик', 'https://img.icons8.com/external-vitaliy-gorbachev-flat-vitaly-gorbachev/2x/external-plumber-labour-day-vitaliy-gorbachev-flat-vitaly-gorbachev.png'),
    Service('Электрик', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-multimeter-car-service-wanicon-flat-wanicon.png'),
    Service('Маляр', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-painter-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Столяр', 'https://img.icons8.com/fluency/2x/drill.png'),
    Service('Садовник', 'https://img.icons8.com/external-itim2101-flat-itim2101/2x/external-gardener-male-occupation-avatar-itim2101-flat-itim2101.png'),
    Service('Портной', 'https://img.icons8.com/fluency/2x/sewing-machine.png'),
    Service('Служанка', 'https://img.icons8.com/color/2x/housekeeper-female.png'),
    Service('Водитель', 'https://img.icons8.com/external-sbts2018-lineal-color-sbts2018/2x/external-driver-women-profession-sbts2018-lineal-color-sbts2018.png'),
  ];

  int selectedService = 4;

  @override
  void initState() {
    Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        selectedService = Random().nextInt(services.length);
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            /*Container(
              width: 100,
              height: 20,
              margin: const EdgeInsets.only(top: 40),
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/homevio.png')
                  )
              ),
            ),*/
            const SizedBox(height: 45,),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              height: MediaQuery.of(context).size.height * 0.45,
              width: MediaQuery.of(context).size.width,
              child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.0,
                    crossAxisSpacing: 8.0,
                    mainAxisSpacing: 8.0,
                  ),
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: services.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FadeAnimation((1.0 + index) / 4, serviceContainer(services[index].imageURL, services[index].name, index));
                  }
              ),
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(80),
                      topRight: Radius.circular(80),
                    )
                ),
                child: Column(
                  children: [
                    const SizedBox(height: 40,),
                    FadeAnimation(1.5, Container(
                      padding: const EdgeInsets.symmetric(horizontal: 40),
                      child: Center(
                        child: Text(
                          'Простой и надежный способ \nзаботиться о доме',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: "Brand Bold",
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade900,
                          ),
                        ),
                      ),
                    )),
                    const SizedBox(height: 20,),
                    FadeAnimation(1.5, Container(
                      padding: const EdgeInsets.symmetric(horizontal: 60),
                      child: Center(
                        child: Text(
                          'Мы предоставим вам лучших людей, которые помогут позаботиться о вашем доме.',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 10,
                            fontFamily: "Brand-Regular",
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ),
                    )),
                    RoundedLoginButton(
                      text: "ВОЙТИ",
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return LoginScreen();
                            },
                          ),
                        );
                      },
                    ),
                    RoundedButton(
                      text: "РЕГИСТРАЦИЯ",
                      color: Constants.kPrimaryLightColor,
                      textColor: Colors.black,
                      press: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignUpScreen();
                            },
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        )
    );
  }
  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 500),
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.white : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.blue.shade100 : Colors.grey.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 30),
              const SizedBox(height: 10,),
              Text(name, style: const TextStyle(fontSize: 10, fontFamily: "Brand-Regular"),)
            ]
        ),
      ),
    );
  }
}
