// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:chat_app/models/usuario.dart';

class UsuariosPage extends StatefulWidget {
  UsuariosPage({super.key});

  @override
  State<UsuariosPage> createState() => _UsuariosPageState();
}

class _UsuariosPageState extends State<UsuariosPage> {
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  final usuarios = [
    Usuario(uid: '1', nombre: 'Dally', email: 'lafidu@test.com', online: true),
    Usuario(
        uid: '2', nombre: 'Yhonattan', email: 'elfidu@test.com', online: false),
    Usuario(
        uid: '3', nombre: 'Luis', email: 'elluisillo@test.com', online: true)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Usuarios'),
          centerTitle: true,
          leading: Icon(
            Icons.search_outlined,
            color: Colors.white,
          ),
          elevation: 0,
          backgroundColor: Colors.red.withOpacity(0.8),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(
                Icons.check_circle,
                color: Colors.green.shade300,
                // child: Icon(Icons.offline_bolt, color: Colors.red.shade700)
              ),
            ),
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _cargarUsuarios,
          header: WaterDropHeader(
            complete:
                Icon(Icons.check_circle_outline, color: Colors.green[400]),
            waterDropColor: Colors.orange[400] as Color,
          ),
          child: listViewUsuarios(),
        ));
  }

  ListView listViewUsuarios() {
    return ListView.separated(
      physics: BouncingScrollPhysics(),
      itemBuilder: (_, i) => _ListTileUsuario(usuarios[i]),
      separatorBuilder: (_, i) => Divider(),
      itemCount: usuarios.length,
    );
  }

  ListTile _ListTileUsuario(Usuario usuario) {
    return ListTile(
      title: Text(usuario.nombre.toString()),
      subtitle: Text(usuario.email.toString()),
      leading: CircleAvatar(
        backgroundColor: Colors.red[100],
        child: Text(
          usuario.nombre!.substring(0, 2),
          style: TextStyle(color: Colors.white),
        ),
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color:
                usuario.online != false ? Colors.green[300] : Colors.red[700],
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _cargarUsuarios() async {
    await Future.delayed(Duration(milliseconds: 1000));

    _refreshController.refreshCompleted();
  }
}
