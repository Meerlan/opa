import 'package:flutter_application_1/pages/animation/fade_animation.dart';
import 'package:flutter_application_1/models/services.dart';
import 'package:flutter_application_1/pages/home/room_selection_screen.dart';
import 'package:flutter/material.dart';

class SelectService extends StatefulWidget {
  const SelectService({ Key? key }) : super(key: key);

  @override
  _SelectServiceState createState() => _SelectServiceState();
}

class _SelectServiceState extends State<SelectService> {
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
    Service('Повар', 'https://img.icons8.com/external-wanicon-flat-wanicon/2x/external-cooking-daily-routine-wanicon-flat-wanicon.png'),
  ];

  int selectedService = -1;
  String? serviceName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: selectedService >= 0 ? FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectRoomScreen(serviceName),
              ),
            );
          },
          child: const Icon(Icons.arrow_forward_ios, size: 20,),
          backgroundColor: Colors.blue,
        ) : null,
        body: NestedScrollView(
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverToBoxAdapter(
                  child: FadeAnimation(1.2, Padding(
                    padding: const EdgeInsets.only(top: 120.0, right: 20.0, left: 20.0),
                    child: Text(
                      'Какая услуга \nвам нужна?',
                      style: TextStyle(
                        fontSize: 40,
                        color: Colors.grey.shade900,
                        fontFamily: "Brand Bold",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ))
            ];
          },
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: GridView.builder(
                        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 1.0,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 20.0,
                        ),
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: services.length,
                        itemBuilder: (BuildContext context, int index) {
                          return FadeAnimation((1.0 + index) / 4, serviceContainer(services[index].imageURL, services[index].name, index));
                        }
                    ),
                  ),
                ]
            ),
          ),
        )
    );
  }

  serviceContainer(String image, String name, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          if (selectedService == index) {
            selectedService = -1;
            serviceName = name;
          } else {
            selectedService = index;
            serviceName = name;
          }
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          color: selectedService == index ? Colors.blue.shade50 : Colors.grey.shade100,
          border: Border.all(
            color: selectedService == index ? Colors.blue : Colors.blue.withOpacity(0),
            width: 2.0,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.network(image, height: 80),
              const SizedBox(height: 20,),
              Text(name, style: const TextStyle(fontSize: 15, fontFamily: "ubuntu"),)
            ]
        ),
      ),
    );
  }
}