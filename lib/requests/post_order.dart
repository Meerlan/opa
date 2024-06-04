import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/models/services.dart';

Future<dynamic> postOrder({
  required String square,
  required String typeOfCleaning,
  required List<ServicesModel> extras,
  required String city,
  required String street,
  required String house,
  required String flat,
  required String comment,
  required String phone,
  required int totalPrice,
}) async {
  const String url = AppConfig.apiUrl;
  BaseOptions options = BaseOptions(
    contentType: 'application/json',
    baseUrl: AppConfig.apiUrl,
    connectTimeout: 10000,
    receiveTimeout: 10000,
  );
  const serviceId = 'service_7ohb3se';
  const tamplateId = 'template_fxdfhl9';
  const userId = 'KRO6UuOVYmmLc_4Ma';
  final massage = '''
Город: $city 
Телефон: $phone
Адрес:$street, $house, $flat,
Площадь уборки: $square
Тип:$typeOfCleaning
_______________________________
Дополнительно:${extras.map((v) => v.toJson()).toList()}
_______________________________
Коментарии:${comment != '' ? comment : null}
_______________________________
Итог:$totalPrice ''';

  final dioClient = Dio(options);
  log(url);
  final Map<String, dynamic> body = {
    'service_id': serviceId,
    'template_id': tamplateId,
    'user_id': userId,
    "accessToken": "ZS9H3CVcQ0jtvmr7dtcbq",
    'template_params': {
      'city': city,
      'phone': phone,
      'address': '$street, $house, $flat',
      'square': square,
      'type': typeOfCleaning,
      'extras': '${extras.map((v) => v.name).toList()}',
      'comments': '${comment != '' ? comment : null}',
      'summ': totalPrice,
    }
  };
  try {
    final response = await dioClient.post(
      url,
      data: body,
    );
    return response.statusCode;
  } catch (e) {
    // ignore: avoid_print
    print(e);
  }
}
