// ignore_for_file: prefer_const_constructors

import 'dart:io';

import 'package:chat_app/widgets/chat_messages.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> with TickerProviderStateMixin {
  final _textController = TextEditingController();
  final focusnode = FocusNode();

  List<ChatMessages> _messages = [];
  bool escribiendo = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          titleSpacing: 0,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.arrow_back)),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.call)),
            IconButton(onPressed: () {}, icon: Icon(Icons.videocam)),
            IconButton(onPressed: () {}, icon: Icon(Icons.more_vert))
          ],
          backgroundColor: Colors.red[300],
          title: Row(
            children: <Widget>[
              CircleAvatar(
                maxRadius: 18,
                backgroundColor: Colors.red[100],
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Dally',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
              )
            ],
          )),
      body: Container(
        child: Column(
          children: <Widget>[
            Flexible(
                child: ListView.builder(
              physics: BouncingScrollPhysics(),
              itemBuilder: (_, i) => _messages[i],
              itemCount: _messages.length,
              reverse: true,
            )),
            Container(
              child: _inputChat(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputChat() {
    return SafeArea(
        child: Container(
      decoration: BoxDecoration(
          color: Colors.red[100], borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.symmetric(horizontal: 8),
      child: Row(
        children: <Widget>[
          Flexible(
              child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              decoration: InputDecoration.collapsed(
                  floatingLabelAlignment: FloatingLabelAlignment.start,
                  hintText: 'Mensaje'),
              focusNode: focusnode,
              controller: _textController,
              onSubmitted: _handleSubmit,
              onChanged: (String text) {
                setState(() {
                  if (text.trim().length > 0) {
                    escribiendo = true;
                  } else {
                    escribiendo = false;
                  }
                });
              },
            ),
          )),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: Platform.isIOS
                  ? CupertinoButton(
                      child: Text('Enviar'),
                      onPressed: escribiendo
                          ? () => _handleSubmit(_textController.text.trim())
                          : null,
                    )
                  : Container(
                      margin: EdgeInsets.symmetric(horizontal: 4),
                      child: IconTheme(
                        data: IconThemeData(color: Colors.orange[400]),
                        child: IconButton(
                            highlightColor: Colors.transparent,
                            splashColor: Colors.transparent,
                            onPressed: escribiendo
                                ? () =>
                                    _handleSubmit(_textController.text.trim())
                                : null,
                            icon: Icon(
                              Icons.send,
                            )),
                      ),
                    )),
        ],
      ),
    ));
  }

  _handleSubmit(String text) {
    if (text.isEmpty) return;
    print(text);

    _textController.clear();
    focusnode.requestFocus();

    final newMessage = ChatMessages(
      uid: '123',
      texto: text,
      animationController: AnimationController(
          vsync: this, duration: Duration(milliseconds: 200)),
    );
    _messages.insert(0, newMessage);
    newMessage.animationController.forward();
    setState(() {
      escribiendo = false;
    });
  }

  @override
  void dispose() {
    // TODO: off del socket
    for (ChatMessages messages in _messages) {
      messages.animationController.dispose();
    }
    super.dispose();
  }
}
