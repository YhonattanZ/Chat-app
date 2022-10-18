import 'package:chat_app/services/auth_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: checkLoginState(context),
        builder: (context, snapshot) {
          return Center(
            child: Text('Loading Page'),
          );
        },
      ),
    );
  }

  Future checkLoginState(context) async {
    final authServide = Provider.of<AuthService>(context, listen: false);
    final autenticado = await authServide.isLoggedIn();

    if (autenticado) {
      //TODO: conectar al socket server
      Navigator.pushReplacementNamed(context, 'usuarios');
    } else {
      Navigator.pushReplacementNamed(context, 'login');
    }
  }
}
