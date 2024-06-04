import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/constants.dart';

class HeaderLabel extends StatelessWidget {
  final String? headerText;
  const HeaderLabel({
    Key? key, this.headerText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(Constants.kDefaultPadding),
      child: Text(
        headerText!,
        style: const TextStyle(color: Constants.kPrimaryLightColor, fontSize: 28.0),
      ),
    );
  }
}