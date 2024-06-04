import 'package:flutter/material.dart';
import 'package:flutter_application_1/controllers/order_controller.dart';

class GeneralController {
  final navigatorKeyOrder = GlobalKey<NavigatorState>();

  /// ORDER
  late OrderController orderController;

  GeneralController() {
    orderController = OrderController(navigatorKeyOrder: navigatorKeyOrder);
  }
}
