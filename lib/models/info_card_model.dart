import 'package:flutter_application_1/config/config.dart';

class InfoCardModel {
  final int square;
  final int price;
  final int previousPrice;
  final String image;
  final String currency;
  InfoCardModel({
    required this.square,
    required this.price,
    required this.previousPrice,
    required this.image,
    this.currency = AppConfig.currencySymbol,
  });
}
