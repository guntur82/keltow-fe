// import 'package:flutter_project/LoginRegister/HomePage_log_res.dart';
// import 'package:flutter/material.dart';
// import 'dart:async';

// class SplashScreen extends StatefulWidget {
//   const SplashScreen({Key? key}) : super(key: key);

//   @override
//   State<SplashScreen> createState() => _SplashScreenState();
// }

// class _SplashScreenState extends State<SplashScreen> {
//   @override
//   void initState() {
//     super.initState();
//     startSplashScreen();
//   }

//   startSplashScreen() async {
//     var duration = const Duration(seconds: 5);
//     return Timer(duration, () {
//       Navigator.of(context).pushReplacement(
//         MaterialPageRoute(builder: (_) {
//           return Login();
//         }),
//       );
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Center(
//         child: Image.asset(
//           "assets/image 1.png",
//           width: 200,
//           height: 100,
//         ),
//       ),
//     );
//   }
// }
