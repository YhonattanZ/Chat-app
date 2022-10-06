import 'package:flutter/material.dart';

class ChatMessages extends StatelessWidget {
  final String uid;
  final String texto;
  final AnimationController animationController;

  const ChatMessages(
      {Key? key,
      required this.uid,
      required this.texto,
      required this.animationController})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: animationController,
      child: SizeTransition(
        sizeFactor:
            CurvedAnimation(parent: animationController, curve: Curves.easeOut),
        child: Container(
          child: uid == '123' ? _myMessages() : _notMyMessages(),
        ),
      ),
    );
  }

  Widget _myMessages() {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 50, right: 10),
        padding: const EdgeInsets.all(8),
        // ignore: sort_child_properties_last
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.orange[400],
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
    );
  }

  Widget _notMyMessages() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.only(bottom: 5, left: 10, right: 50),
        padding: const EdgeInsets.all(8),
        // ignore: sort_child_properties_last
        child: Text(
          texto,
          style: const TextStyle(color: Colors.white),
        ),
        decoration: BoxDecoration(
            color: Colors.red[400],
            borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomLeft: Radius.circular(20),
                bottomRight: Radius.circular(20))),
      ),
    );
  }
}
