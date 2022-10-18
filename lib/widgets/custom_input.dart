import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  CustomInput(
      {Key? key,
      required this.color,
      required this.icon,
      required this.placeholder,
      required this.textController,
      this.keyboardType = TextInputType.text,
      this.isPassword = false})
      : super(key: key);

  final Color color;
  final IconData icon;
  final String placeholder;
  final TextEditingController textController;
  final TextInputType keyboardType;
  final bool isPassword;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.only(top: 5, left: 5, bottom: 5, right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.red.withOpacity(0.08),
                  offset: const Offset(0, 7),
                  blurRadius: 5),
            ]),
        child: TextFormField(
          controller: textController,
          autocorrect: false,
          keyboardType: keyboardType,
          obscureText: isPassword,
          decoration: InputDecoration(
              hintText: placeholder,
              hintStyle: const TextStyle(color: Colors.black38),
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              prefixIcon: Icon(
                icon,
                color: color,
              )),
        ));
  }
}
