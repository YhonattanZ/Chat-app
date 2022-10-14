import 'dart:convert';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:http/http.dart' as http;

class AuthService with ChangeNotifier {
  Usuario? usuario;

  Future login(String email, String password) async {
    final data = {email: email, password: password};

    final res = await http.post(Uri.parse('${Environment.apiUrl}/login'),
        body: jsonEncode(data));

    print(res.body);

    if (res.statusCode == 200) {
      final loginresponse = loginResponseFromJson(res.body);
      usuario = loginresponse.usuario;
    }
  }
}
