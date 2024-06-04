import 'package:flutter/material.dart';

class ProgDialog extends StatelessWidget{
  late String message;
  ProgDialog({required this.message});
  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.white,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(width: 6.0,),
              const CircularProgressIndicator(valueColor: AlwaysStoppedAnimation<Color>(Color.fromRGBO(47, 11, 118, 1)),),
              const SizedBox(width: 26.0,),
              Text(
                message,
                style: const TextStyle(color: Colors.black, fontFamily: "Brand Bold"),
              ),

            ],
          ),
        ),
      ),
    );
  }
}