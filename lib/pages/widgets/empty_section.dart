import 'package:flutter/material.dart';
import '../../config/constants.dart';

class EmptySection extends StatelessWidget {
  final String emptyImg, emptyMsg;
  const EmptySection({
    Key? key,
    required this.emptyImg,
    required this.emptyMsg,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image(
            image: AssetImage(emptyImg),
            height: 150.0,
          ),
          Padding(
            padding: const EdgeInsets.only(top: Constants.kLessPadding),
            child: Text(
              emptyMsg,
              style: Constants.kDarkTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}