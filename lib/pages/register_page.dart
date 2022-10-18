import 'package:chat_app/helpers/show_alerts.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/boton_login.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/label.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 247, 247),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height * 0.99,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Logo(
                    title: 'Crea una cuenta',
                  ),
                  const _Form(),
                  const Labels(
                      title: '¿Ya posees una cuenta?',
                      pushtitle: 'Inicia Sesión',
                      route: 'login'),
                  Text(
                    'Términos y condiciones de uso',
                    style: TextStyle(
                        color: Colors.red.withOpacity(0.6),
                        fontSize: 14,
                        fontWeight: FontWeight.w300),
                  )
                ]),
          ),
        )));
  }
}

class _Form extends StatefulWidget {
  const _Form({super.key});

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final emailCtrl = TextEditingController();
  final passwordCtrl = TextEditingController();
  final userCtrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Form(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
            CustomInput(
              icon: Icons.person_outline,
              color: Colors.red.withOpacity(0.3),
              placeholder: 'Username',
              keyboardType: TextInputType.text,
              textController: userCtrl,
            ),
            CustomInput(
              icon: Icons.mail_outline,
              color: Colors.red.withOpacity(0.3),
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              textController: emailCtrl,
            ),
            CustomInput(
              icon: Icons.lock_outline,
              color: Colors.red.withOpacity(0.3),
              placeholder: 'Password',
              isPassword: true,
              textController: passwordCtrl,
            ),
            ButtonLogin(
              bgcolor: Colors.red.shade700,
              text: 'Registrate ahora',
              onPressed: () async {
                final registerOk = await authService.register(
                    userCtrl.text.trim(),
                    emailCtrl.text.trim(),
                    passwordCtrl.text.trim());
                if (registerOk != false) {
                  //TODO:CONECTAR SOCKET SERVER
                  Navigator.pushReplacementNamed(context, 'usuarios');
                } else {}
              },
            )
          ],
        ),
      ),
    );
  }
}
