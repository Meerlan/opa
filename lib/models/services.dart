import 'package:flutter_application_1/config/config.dart';

class ServicesModel {
  final String name;
  final int price;
  final String currency;
  int count;

  ServicesModel({
    required this.name,
    required this.price,
    this.currency = AppConfig.currency,
    this.count = 0,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['quantity'] = count;
    data['cost'] = price;
    return data;
  }
}

class Service {
  final String name;
  final String imageURL;

  Service(this.name, this.imageURL);
}
