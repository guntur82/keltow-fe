import 'package:flutter/gestures.dart';
import 'package:flutter_project/LoginRegister/HomePage_log_res.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_project/constants/ultils.dart';

class RegisterPage extends StatefulWidget {
  static const String routeName = '/register';
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

  // get textControllerEmail => null;
  final AuthService authService = AuthService();

  // get textControllerPassword => null;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textControllerTypeUser = TextEditingController();
  final TextEditingController textControllerNama = TextEditingController();
  final TextEditingController textControllerNomorHP = TextEditingController();
  final TextEditingController textControllerEmail = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();
  final TextEditingController textControllerConfirmPassword =
      TextEditingController();

  void register() {
    if (_formKey.currentState!.validate()) {
      if (textControllerPassword.text == textControllerConfirmPassword.text) {
        // print("email = " + textControllerEmail.text);
        // print("passowrd = " + textControllerPassword.text);
        // print("confirm passowrd = " + textControllerPassword.text);
        // print("nama = " + textControllerNama.text);
        // print("no hp = " + textControllerNomorHP.text);
        authService.register(
          context: context,
          email: textControllerEmail.text,
          password: textControllerPassword.text,
          name: textControllerNama.text,
          phone: textControllerNomorHP.text,
        );
      } else {
        showSnackBar(context, "password tidak sama!");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register"),
      ),
      // body: Container(
      //   decoration: BoxDecoration(
      //     image: DecorationImage(
      //         image: ExactAssetImage("assets/Register.png"), fit: BoxFit.cover),
      //   ),
      // ),

      body: SingleChildScrollView(
        child: Form(
            key: _formKey,
            child: Container(
              margin: EdgeInsets.all(16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/image 1.png",
                    width: 150,
                    height: 120,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Hello",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 12),
                  ),
                  const Text(
                    "Register",
                    style:
                        TextStyle(fontWeight: FontWeight.normal, fontSize: 24),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Email address",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: textControllerEmail,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      hintText: "name@mail.com",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white10,
                      filled: true,
                      suffixIcon: Icon(Icons.email, color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Nama",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    controller: textControllerNama,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      hintText: "name",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white10,
                      filled: true,
                      suffixIcon: Icon(Icons.account_circle_rounded,
                          color: Colors.black),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "nama tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Password",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    obscureText: _isObscure,
                    controller: textControllerPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      hintText: "password",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white10,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglePasswordVisibility();
                        },
                        child: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: _isObscure ? Colors.black : Colors.black,
                        ),
                      ),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Konfirmasi Password",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  SizedBox(height: 4),
                  TextFormField(
                    style: TextStyle(color: Colors.black),
                    obscureText: _isObscure,
                    controller: textControllerConfirmPassword,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 0,
                        horizontal: 10,
                      ),
                      hintText: "confirm password",
                      hintStyle: TextStyle(color: Colors.grey),
                      fillColor: Colors.white10,
                      filled: true,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                        borderSide: BorderSide(
                          color: Colors.black,
                        ),
                      ),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          _togglePasswordVisibility();
                        },
                        child: Icon(
                          _isObscure ? Icons.visibility_off : Icons.visibility,
                          color: _isObscure ? Colors.black : Colors.black,
                        ),
                      ),
                      isDense: true,
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password tidak boleh kosong";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(145, 50),
                        primary: Colors.blue,
                        side: BorderSide(width: 1.5, color: Colors.blueAccent),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10))),
                    child: Text("Register"),
                    onPressed: () {
                      setState(() {
                        register();
                        // if (_formKey.currentState!.validate()) {
                        //   String type_user =
                        //       textControllerTypeUser.text.toString();
                        //   String name = textControllerNama.text.toString();
                        //   String mobile = textControllerNomorHP.text.toString();
                        //   String password =
                        //       textControllerPassword.text.toString();
                        //   String confirm_password =
                        //       textControllerConfirmPassword.text.toString();

                        //   // viewModel.register(textControllerTypeUser.text,textControllerNama.text,textControllerNomorHP.text, textControllerPassword.text, textControllerConfirmPassword.text, context);

                        //   print("Email => " + textControllerEmail.text);
                        //   print("Nama Lengkap => " + textControllerNama.text);
                        //   print("No Hp => " + textControllerNomorHP.text);
                        //   print("Password => " + textControllerPassword.text);
                        //   print("confirm_password => " +
                        //       textControllerConfirmPassword.text);
                        // } else {
                        //   print("Nama Lengkap => " + textControllerNama.text);
                        //   print("No Hp => " + textControllerNomorHP.text);
                        //   print("Password => " + textControllerPassword.text);
                        //   print("confirm_password => " +
                        //       textControllerConfirmPassword.text);
                        //   showDialog(
                        //       context: context,
                        //       builder: (_) => AlertDialog(
                        //             title: Text("Informasi"),
                        //             content:
                        //                 Text("Silahkan lengkapi data anda"),
                        //             actions: [
                        //               TextButton(
                        //                 child: Text("ok"),
                        //                 onPressed: () {
                        //                   Navigator.pop(context);
                        //                 },
                        //               )
                        //             ],
                        //           ));
                        // }
                      });
                    },
                  ),
                  const SizedBox(
                    height: 0,
                  ),
                  Row(
                    children: <Widget>[
                      const Text(
                        'Already have account ?',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextButton(
                        child: const Text(
                          'Login',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        onPressed: () {
                          //signup screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginPage()));
                        },
                      )
                    ],
                    mainAxisAlignment: MainAxisAlignment.center,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   crossAxisAlignment: CrossAxisAlignment.center,
                  //   children: [
                  //     Text(
                  //       "Already have account ? ",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold, fontSize: 14),
                  //     ),
                  //     Text(
                  //       "Login",
                  //       style: TextStyle(
                  //           fontWeight: FontWeight.bold,
                  //           fontSize: 14,
                  //           color: Colors.blue),
                  //     ),
                  //   ],
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
