import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/pages/filling_data/widgets/container_with_star.dart';

class Input extends StatefulWidget {
  final TextEditingController controller;
  final TextInputAction? textInputAction;
  final String? hintText;
  final double? width;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? textFormatters;
  final EdgeInsets scrollPadding;
  final ScrollController? scrollCOntroller;

  const Input({
    Key? key,
    required this.controller,
    this.textInputAction,
    this.width,
    this.hintText,
    this.keyboardType,
    this.textFormatters,
    this.scrollPadding = EdgeInsets.zero,
    this.scrollCOntroller,
  }) : super(key: key);

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: widget.width,
          height: 42,
          child: TextField(
            inputFormatters: widget.textFormatters,
            controller: widget.controller,
            textInputAction: widget.textInputAction,
            scrollController: widget.scrollCOntroller,
            scrollPadding: widget.scrollPadding,
            cursorColor: AppConfig.blueColor,
            keyboardType: widget.keyboardType,
            onChanged: (_) {
              setState(() {});
            },
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(bottom: 5.0),
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontSize: 13,
                color: AppConfig.blackColor.withOpacity(0.15),
                fontWeight: FontWeight.w500,
              ),
            ),
            style: const TextStyle(
              fontSize: 13,
              color: AppConfig.blueColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
        ContainerWithStar(
          isActive: widget.controller.text.isEmpty ? false : true,
        ),
      ],
    );
  }
}
