import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/pages/home/home_screen.dart';
// import 'package:flutter_application_1/pages/plans_page_view/general.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/pages/home/home.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controllers/general_controller.dart';


Future<void> main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light.copyWith(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final GeneralController controller = GeneralController();

  @override
  Widget build(BuildContext context) {
    return Provider<GeneralController>(
      create: (_) => controller,
      child: MaterialApp(
        color: AppConfig.whiteColor,
        theme: ThemeData(fontFamily: AppConfig.fontFamilyInter),
        debugShowCheckedModeBanner: false,
        home: WelcomeScreen(),
        // home: const General(),
      ),
    );
  }
}
