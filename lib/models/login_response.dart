// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

// ignore_for_file: unnecessary_null_in_if_null_operators, prefer_null_aware_operators

import 'dart:convert';

import 'package:chat_app/models/usuario.dart';

LoginResponse loginResponseFromJson(String str) =>
    LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    this.ok,
    this.usuario,
    this.token,
  });

  bool? ok;
  Usuario? usuario;
  String? token;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
        ok: json["ok"] ?? null,
        usuario:
            json["usuario"] == null ? null : Usuario.fromJson(json["usuario"]),
        token: json["token"] ?? null,
      );

  Map<String, dynamic> toJson() => {
        "ok": ok ?? null,
        "usuario": usuario == null ? null : usuario?.toJson(),
        "token": token ?? null,
      };
}
