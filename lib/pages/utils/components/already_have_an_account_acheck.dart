import 'package:flutter/material.dart';

import '../../../../../config/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login ? "У вас нет аккаунт ? " : "Уже есть аккаунт? ",
          style: const TextStyle(color: Constants.kPrimaryColor, fontFamily: "Brand-Regular"),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "РЕГИСТРАЦИЯ" : "ВОЙТИ",
            style: const TextStyle(
              color: Constants.kPrimaryColor,
              fontWeight: FontWeight.bold,
                fontFamily: "Brand Bold"
            ),
          ),
        )
      ],
    );
  }
}