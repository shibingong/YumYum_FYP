import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final onPressed;
  const CustomButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  side: BorderSide(color: Colors.transparent))),
          backgroundColor: MaterialStateProperty.all<Color>(
              Color.fromRGBO(255, 178, 102, 1))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      onPressed: onPressed,
    );
  }
}
