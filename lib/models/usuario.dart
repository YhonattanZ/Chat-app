// To parse this JSON data, do
//
//     final usuario = usuarioFromJson(jsonString);

import 'dart:convert';

Usuario usuarioFromJson(String str) => Usuario.fromJson(json.decode(str));

String usuarioToJson(Usuario data) => json.encode(data.toJson());

class Usuario {
  Usuario({
    this.nombre,
    this.email,
    this.online,
    this.uid,
  });

  String? nombre;
  String? email;
  bool? online;
  String? uid;

  factory Usuario.fromJson(Map<String, dynamic> json) => Usuario(
        nombre: json["nombre"] == null ? null : json["nombre"],
        email: json["email"] == null ? null : json["email"],
        online: json["online"] == null ? null : json["online"],
        uid: json["uid"] == null ? null : json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "nombre": nombre == null ? null : nombre,
        "email": email == null ? null : email,
        "online": online == null ? null : online,
        "uid": uid == null ? null : uid,
      };
}
