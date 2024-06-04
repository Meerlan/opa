import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/service_provider_screen.dart';
import 'package:flutter_application_1/config/constants.dart';
import 'package:http/http.dart' as http;

class ClientLocation extends StatefulWidget{
  static const String idScreen = "locationscreen";

  final String? service;
  final String? room;
  final int? roomTot;
  final String? date;
  final String? addService;
  final String? selectedHour;

  ClientLocation(this.service, this.room, this.roomTot, this.date,
      this.addService, this.selectedHour);

  @override
  LocationState createState() => LocationState();
}

class LocationState extends State<ClientLocation>{
  TextEditingController pickupTextEditingController = TextEditingController();

  String? district;
  String? locale;
  late String message;
  bool? error;
  List data = List<String>.empty();

  String? _mySelection;
  List<String> location = ["Октябрьский", "Первомайский", "Свердловский", "Ленинский", "посёлок"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ваше местоположение',
            style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontFamily: "ubuntu",
                fontSize: 20,
              ),
        ),
        backgroundColor: Constants.kPrimaryColor,
      ),
      body: Container(
        padding: const EdgeInsets.all(30),
        child: Column(
          children: <Widget>[
            Container(
              child: DropdownButton(
                isExpanded: true,
                value: district,
                hint: const Text("Выберите район",style: TextStyle(fontFamily: "ubuntu"),),
                items: location.map((clientLocation) {
                  return DropdownMenuItem(
                    child: Text(clientLocation, style: const TextStyle(fontFamily: "ubuntu"),),
                    value: clientLocation,
                  );
                }).toList(),
                onChanged: (value) {
                  district = value as String;
                  getLocationList(district.toString());
                  print(district);
                },
              ),
            ),
            const SizedBox(height: 20,),
            Expanded(
              //child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<String>(
                  isExpanded: true,
                  value: state,
                  iconSize: 30,
                  icon: (null),
                  style: const TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                  hint: const Text('Выберите местоположение', style: TextStyle(fontFamily: "ubuntu"),),
                  onChanged: (String? newValue) {
                    setState(() {
                      state = newValue!;
                      print(state);
                    });
                  },
                  items: locationList?.map((item) {
                    return DropdownMenuItem(
                      child: Text(item['name'], style: const TextStyle(fontFamily: "ubuntu"),),
                      value: item['id'].toString(),
                    );
                  }).toList() ??
                      [],
                ),
              ),
            ),
            const SizedBox(height: 30.0,),
            ElevatedButton(
              child: const Text(
                "Продолжать",
                style: TextStyle(color: Colors.white, fontFamily: "Brand Bold"),
              ),
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black,
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                  textStyle: const TextStyle(
                      color: Colors.white, fontSize: 14, fontFamily: "Brand Bold"),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(24.0)),
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=> ServiceProviderScreen(widget.service, widget.room, widget.roomTot, widget.date, widget.addService, widget.selectedHour,state.toString())));
              }
            )
          ],
        ),
      ),
    );
  }

  List? locationList;
  String? state;
  String getLocationList(String areaName) {
    List? constList;
    var locationData;

    if(areaName == "Октябрьский")
      {
        constList = [
          {'name': '10 мкр', 'id': "10 мкр, Октябрьский"},
          {'name': '9 мкр', 'id': "9 мкр, Октябрьский"},
          {'name': '8 мкр', 'id': "8 мкр, Октябрьский"},
          {'name': '7 мкр', 'id': "7 мкр, Октябрьский",},
          {'name': '6 мкр', 'id': "6 мкр, Октябрьский"},
          {'name': '5 мкр', 'id': "5 мкр, Октябрьский"},
          {'name': '4 мкр', 'id': "4 мкр, Октябрьский"},
          {'name': '3 мкр', 'id': "3 мкр, Октябрьский"},
          {'name': '11 мкр', 'id': "11 мкр, Октябрьский",},
          {'name': '12 мкр', 'id': "12 мкр, Октябрьский"},
          {'name': 'мкр Улан', 'id': "мкр Улан, Октябрьский"},
          {'name': 'мкр Улан-2', 'id': "мкр Улан, Октябрьский"},
          {'name': 'мкр Кок-Жар', 'id': "мкр Кок-Жар, Октябрьский",},
          {'name': 'мкр Тунгуч', 'id': "мкр Тунгуч, Октябрьский"},
        ];

        var jsonResponse = jsonEncode(constList);
        locationData = jsonDecode(jsonResponse);
      }
    else if(areaName == "Первомайский")
    {
      constList = [
        {'id': "Достук мкр, Первомайский", 'name': 'Достук'},
        {'id': "мкр ЮГ-2, Первомайский", 'name': 'ЮГ-2'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "Свердловский")
    {
      constList = [
        {'id': "Ак-Тилек, Свердловский", 'name': 'Ак-Тилек'},
        {'id': "Келечек, Свердловский", 'name': 'Келечек'},
        {'id': "Дордой-2, Свердловский", 'name': 'Дордой-2'},
        {'id': "Ак-Бата, Свердловский", 'name': 'Ак-Бата'},
        {'id': "Бакай-Ата, Свердловский", 'name': 'Бакай-Ата'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "Ленинский")
    {
      constList = [
        {'id': "Ала-Тоо, Ленинский", 'name': 'Ала-Тоо'},
        {'id': "Ак-Ордо, Ленинский", 'name': 'Ак-Ордо'},
        {'id': "Арча-Бешик, Ленинский", 'name': 'Арча-Бешик'},
        {'id': "Ак-Орго, Ленинский", 'name': 'Ак-Орго'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }
    else if(areaName == "посёлок")
    {
      constList = [
        {'id': "Чон-Арык, Dagoretti", 'name': 'Чон-Арык'},
      ];

      var jsonResponse = jsonEncode(constList);
      locationData = jsonDecode(jsonResponse);
    }

    setState(() {
      locationList = constList;
    });
    return locationData.toString();
  }
}

