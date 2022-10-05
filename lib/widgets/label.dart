import 'package:flutter/material.dart';

class Labels extends StatelessWidget {
  const Labels(
      {super.key,
      required this.route,
      required this.title,
      required this.pushtitle});

  final String route;
  final String title;
  final String pushtitle;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      child: Column(children: <Widget>[
        GestureDetector(
          child: Text(
            title,
            style: TextStyle(
                color: Colors.red.withOpacity(0.6),
                fontSize: 14,
                fontWeight: FontWeight.w300),
          ),
        ),
        SizedBox(height: size.height * 0.012),
        GestureDetector(
          onTap: () {
            Navigator.pushReplacementNamed(context, route);
          },
          child: Text(
            pushtitle,
            style: TextStyle(
                color: Colors.orange.shade600,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        ),
      ]),
    );
  }
}
