import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/pages/home/location_screen.dart';
import 'package:flutter_application_1/pages/home/service_provider_screen.dart';
import 'package:flutter_application_1/config/constants.dart';
import '../plans_page_view/widgets/rounded_bordered_container.dart';
import 'cart_screen.dart';

class CheckoutOnePage extends StatefulWidget {
  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? selectedHour;

  const CheckoutOnePage(this.service, this.room, this.roomTot, this.date,
      this.addService, this.selectedHour);

  @override
  _checkoutPageState createState ()=> _checkoutPageState();
}

class _checkoutPageState extends State<CheckoutOnePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            const Text(
              "Ваш план",
              style: TextStyle(
                fontFamily: "Brand Bold",
                fontSize: 24.0,
              ),
            ),
            const SizedBox(height: 20.0),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Тип обслуживания",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.service!,
                          style: const TextStyle(
                            fontSize: 12.0,
                            fontFamily: "ubuntu",
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Тип номера",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.room!,
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Количество комнат",
                          style: TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 13.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.roomTot.toString(),
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: RoundedContainer(
                    color: Constants.kAccentColor,
                    margin: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 8.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        const Text(
                          "Дата выбора",
                          style: TextStyle(
                              fontFamily: "ubuntu",
                              fontSize: 13.0,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                        const SizedBox(height: 5.0),
                        Text(
                          widget.date.toString(),
                          style: const TextStyle(
                            fontFamily: "ubuntu",
                            fontSize: 12.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 30.0),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                vertical: 16.0,
                horizontal: 32.0,
              ),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Constants.kSecondaryColor,
                  elevation: 5,
                  padding: const EdgeInsets.all(24.0),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0)),
                ),
                child: const Text("Продолжать", style: TextStyle(fontFamily: "Brand Bold", fontSize: 18),),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => ClientLocation(widget.service,widget.room,widget.roomTot,widget.date,widget.addService,widget.selectedHour)));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}