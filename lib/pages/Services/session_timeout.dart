import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/login_screen.dart';

class SessionTimeout {
  late Timer timer;
  final navigatorKey = GlobalKey<NavigatorState>();

  void startTimer() {
    timer = Timer.periodic(const Duration(minutes: 1), (_) {
      timedOut();
    });
  }

  void userActivityDeleted() {
    if (timer != null || !timer.isActive) {
      timer.cancel();
      startTimer();
    }
    return;
  }

  Future<void> timedOut() async {
    timer.cancel();
    final context = navigatorKey.currentState?.overlay?.context;
    await showDialog(
      context: context!,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: const Text('Alert', style: TextStyle(fontFamily: "ubuntu", fontWeight: FontWeight.bold),),
        content:
        const Text('Извините, но вы вышли из системы из-за неактивности...', style: TextStyle(fontFamily: "ubuntu"),),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => LoginScreen(),
                ),
                    (route) =>
                false,
              );
            },
            child: const Text('OK', style: TextStyle(fontFamily: "ubuntu"),),
          ),
        ],
      ),
    );
  }
}
