import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  const Logo({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Center(
      child: Container(
        margin: EdgeInsets.only(top: size.height * 0.05),
        width: size.width * 0.6,
        child: Column(
          children: <Widget>[
            ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: const Image(
                    image: AssetImage('assets/images/chibirengoku.png'))),
            SizedBox(height: size.height * 0.02),
            Text(
              title,
              style: TextStyle(fontSize: 20, color: Colors.red[800]),
            )
          ],
        ),
      ),
    );
  }
}
