import 'package:chat_app/helpers/show_alerts.dart';
import 'package:chat_app/services/auth_services.dart';
import 'package:chat_app/widgets/boton_login.dart';
import 'package:chat_app/widgets/custom_input.dart';
import 'package:chat_app/widgets/label.dart';
import 'package:chat_app/widgets/logo.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 248, 247, 247),
        body: SafeArea(
            child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            height: size.height * 0.95,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const Logo(title: 'Mysterious Messenger'),
                  const _Form(),
                  const Labels(
                      title: '¿No tienes cuenta?',
                      pushtitle: 'Regístrate',
                      route: 'register'),
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

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    final formKey = GlobalKey<FormState>();
    return Form(
      child: Container(
        margin: const EdgeInsets.only(top: 40),
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: <Widget>[
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
                text: 'Inicia Sesión',
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final loginOk = await authService.login(
                      emailCtrl.text.trim(), passwordCtrl.text.trim());
                  if (loginOk == true) {
                    //TODO: Navegar a la siguiente pantalla
                    //TODO:Conectar al socket server
                    Navigator.pushReplacementNamed(context, 'usuarios');
                  } else {
                    showAlert(
                        context, 'Login fallido', 'Credenciales incorrectas');
                  }
                }),
          ],
        ),
      ),
    );
  }
}
