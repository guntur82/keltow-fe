import 'package:flutter_project/LoginRegister/Register_page.dart';
import 'package:flutter_project/view/Home.dart';
import 'package:flutter_project/LoginRegister/HomePage_log_res.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:flutter_project/view/Splash.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/services/auth_service.dart';

class LoginPage extends StatefulWidget {
  static const String routeName = '/loginpage';
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  final AuthService authService = AuthService();
  bool _isObscure = true;
  void _togglePasswordVisibility() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  void dispose() {
    super.dispose();
    textControllerEmail.dispose();
    textControllerPassword.dispose();
  }

  void login() {
    if (_formKey.currentState!.validate()) {
      authService.login(
        context: context,
        email: textControllerEmail.text,
        password: textControllerPassword.text,
      );
    }
  }

  final _formKey = GlobalKey<FormState>();
  final TextEditingController textControllerEmail = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();
  // var textControlloerEmail = TextEditingController();
  // var textControlloerPassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 80),
                child: Image.asset(
                  "assets/image 1.png",
                  width: 250,
                  height: 250,
                ),
              ),
              SizedBox(height: 20),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Email address",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 6),
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
              SizedBox(height: 24),
              Container(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Password",
                  style: TextStyle(color: Colors.black),
                ),
              ),
              SizedBox(height: 6),
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
              SizedBox(height: 16),
              Container(
                alignment: Alignment.centerRight,
                child: RichText(
                  text: TextSpan(
                    text: "Forgot password?",
                    style: TextStyle(
                      color: Colors.blueAccent,
                      fontSize: 12,
                    ),
                    recognizer: new TapGestureRecognizer()
                      ..onTap = () => {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => Login()),
                            ),
                          },
                  ),
                ),
              ),
              SizedBox(height: 32),

              ElevatedButton(
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size(142, 55),
                    primary: Colors.blue,
                    side: BorderSide(width: 1.5, color: Colors.blueAccent),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  setState(() {
                    login();
                  });
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => BottomNavigationScreen()));
                },
                child: Text("Login"),

                // alignment: Alignment.center,
                // child: ElevatedButton(
                //     style: ElevatedButton.styleFrom(
                //       primary: Colors.blueAccent,
                //       minimumSize: const Size(200, 45),
                //       shape: RoundedRectangleBorder(
                //         borderRadius: BorderRadius.circular(32),
                //       ),
                //     ),
                //     onPressed: () {
                //       setState(() async {
                //         if (_formKey.currentState!.validate()) {
                //           Navigator.push(context,
                //               MaterialPageRoute(builder: (context) => Login()));
                //         }
                //       });
                //     },
                //     child: Text("Login")),
              ),
              SizedBox(height: 0),
              Row(
                children: <Widget>[
                  const Text(
                    'Don\'t have account ?',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  TextButton(
                    child: const Text(
                      'Register',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    onPressed: () {
                      //signup screen
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => RegisterPage()));
                    },
                  )
                ],
                mainAxisAlignment: MainAxisAlignment.center,
              ),
              // Center(
              //   child: RichText(
              //     text: TextSpan(
              //       text: "Dont't have an account? ", style: TextStyle(
              //       color: Colors.white70, fontSize: 14
              //     ),
              //       children: [
              //         TextSpan(
              //           text: "Sign up", style: TextStyle(
              //             color: Colors.blueAccent, fontSize: 14
              //         ),
              //           recognizer: new TapGestureRecognizer()
              //             ..onTap = () => {
              //               Navigator.push(
              //                 context, MaterialPageRoute(
              //                   builder: (context) => SignupView()),
              //               ),
              //             },
              //         ),
              //       ]
              //     ),
              //   ),
              // ),
              SizedBox(height: 6),
              // Center(
              //   child: RichText(
              //       text: TextSpan(
              //         text: "Skip", style: TextStyle(
              //           color: Colors.blueAccent, fontSize: 14
              //       ),
              //         recognizer: new TapGestureRecognizer()
              //           ..onTap = () => {
              //             Navigator.push(
              //               context, MaterialPageRoute(
              //                 builder: (context) => SplashScreen()),
              //             ),
              //           },
              //       )),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
