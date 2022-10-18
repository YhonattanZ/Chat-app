import 'dart:convert';
import 'package:chat_app/models/usuario.dart';
import 'package:flutter/material.dart';

import 'package:chat_app/global/environment.dart';
import 'package:chat_app/models/login_response.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthService with ChangeNotifier {
  Usuario? usuario;
  bool _autenticando = false;

  final _storage = const FlutterSecureStorage();

  bool get autenticando => _autenticando;
  set autenticando(bool value) {
    _autenticando = value;
    notifyListeners();
  }

  //Getters estáticos del token
  static Future<String?> getToken() async {
    const _storage = FlutterSecureStorage();
    final token = await _storage.read(key: 'token');
    return token;
  }

  static Future<void> deleteToken() async {
    const _storage = FlutterSecureStorage();
    await _storage.delete(key: 'token');
  }

  Future<bool> login(String email, String password) async {
    autenticando = true;

    final data = {'email': email, 'password': password};

    final res = await http.post(Uri.parse('${Environment.apiUrl}/login/'),
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    print(res.body);
    autenticando = false;

    if (res.statusCode == 200) {
      final loginresponse = loginResponseFromJson(res.body);
      usuario = loginresponse.usuario;

      await _savetoken(loginresponse.token.toString());

      return true;
    } else {
      final response = json.decode(res.body);
      return response['msg'];
    }
  }

  Future<bool> register(String nombre, String email, String password) async {
    autenticando = true;

    final data = {'nombre': nombre, 'email': email, 'password': password};

    final res = await http.post(Uri.parse('${Environment.apiUrl}/login/new'),
        body: json.encode(data), headers: {'Content-Type': 'application/json'});

    print(res.body);
    autenticando = false;

    if (res.statusCode == 200) {
      final loginresponse = loginResponseFromJson(res.body);
      usuario = loginresponse.usuario;

      await _savetoken(loginresponse.token.toString());

      return true;
    } else {
      return false;
    }
  }

//Verificar token
  Future isLoggedIn() async {
    final token = await _storage.read(key: 'token');
    print(token);
    final res = await http.get(Uri.parse('${Environment.apiUrl}/login/renew'),
        headers: {'Content-Type': 'application/json', 'x-token': token!});
    if (res.statusCode == 200) {
      final loginresponse = loginResponseFromJson(res.body);
      usuario = loginresponse.usuario;

      await _savetoken(loginresponse.token.toString());

      return true;
    } else {
      _logout();
      return false;
    }
  }

// Guardar token
  Future _savetoken(String token) async {
    return await _storage.write(key: 'token', value: token);
  }

// Eliminar token
  Future _logout() async {
    await _storage.delete(key: 'token');
  }
}
