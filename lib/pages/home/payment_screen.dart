import 'package:flutter/material.dart';
import 'package:flutter_application_1/pages/home/confirmation_screen.dart';
import 'package:flutter_application_1/pages/home/success_screen.dart';
import 'package:flutter_application_1/config/constants.dart';
import '../widgets/default_app_bar.dart';
import '../widgets/default_back_button.dart';
import '../widgets/default_button.dart';
import '../widgets/header_label.dart';

class Payment extends StatefulWidget {
  Payment({Key? key}) : super(key: key);

  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  int value = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Constants.kPrimaryLightColor,
      appBar: const DefaultAppBar(
        title: 'Оплата',
        child: DefaultBackButton(),
      ),
      body: Column(
        children: [
          const HeaderLabel(
            headerText: 'Выберите метод оплаты',
          ),
          Expanded(
            child: ListView.separated(
              itemCount: Constants.paymentLabels.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Radio(
                    activeColor: Constants.kPrimaryColor,
                    value: index,
                    groupValue: value,
                    onChanged: (i) => setState(() => value = i as int),
                  ),
                  title: Text(
                    Constants.paymentLabels[index],
                    style: const TextStyle(color: Constants.kDarkColor),
                  ),
                  trailing: Icon(Constants.paymentIcons[index], color:Constants.kPrimaryColor),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            ),
          ),
          DefaultButton(
            btnText: 'Заплатить позже',
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => ConfirmationScreen())),
          )
        ],
      ),
    );
  }
}