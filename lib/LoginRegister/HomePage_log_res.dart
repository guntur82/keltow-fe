import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/LoginRegister/Register_page.dart';
import 'package:flutter_project/view/Splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Login extends StatefulWidget {
  static const String routeName = '/auth-screen';
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  final _formKey = GlobalKey<FormState>();
  var textControllerTypeUser = new TextEditingController();
  var textControllerNama = new TextEditingController();
  var textControllerNomorHP = new TextEditingController();
  var textControllerPassword = new TextEditingController();
  var textControllerConfirmPassword = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Column(
              children: [
                Image.asset(
                  "assets/welcome.png",
                  fit: BoxFit.cover,
                ),
                const SizedBox(
                  height: 29,
                ),
                Image.asset(
                  "assets/image 1.png",
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 32,
          ),
          Container(
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                        child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(142, 55),
                                primary: Colors.red,
                                side: BorderSide(width: 1.5, color: Colors.red),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => RegisterPage()));
                            },
                            child: Text("Register")),
                        SizedBox(
                          width: 32,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(142, 55),
                                primary: Colors.green,
                                side:
                                    BorderSide(width: 1.5, color: Colors.green),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(32))),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()));
                            },
                            child: Text("Login")),
                      ],
                    ))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
