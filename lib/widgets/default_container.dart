import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';

class DefaultContainer extends StatefulWidget {
  final Widget? child;
  final double? borderRadius;
  final double? width;
  const DefaultContainer({
    Key? key,
    this.child,
    this.borderRadius,
    this.width,
  }) : super(key: key);

  @override
  _DefaultContainerState createState() => _DefaultContainerState();
}

class _DefaultContainerState extends State<DefaultContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width,
      decoration: BoxDecoration(
        color: AppConfig.whiteColor,
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 34),
        boxShadow: [
          BoxShadow(
            color: AppConfig.blackColor.withOpacity(0.07),
            blurRadius: 15,
          ),
        ],
      ),
      child: widget.child,
    );
  }
}
