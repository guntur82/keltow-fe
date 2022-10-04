import 'package:flutter/material.dart';
import 'package:flutter_project/LoginRegister/HomePage_log_res.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/router.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:flutter_project/view/Splash.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/LoginRegister/Register_page.dart';
import 'package:flutter_project/view/Home.dart';
import 'package:provider/provider.dart';

void main() {
  // runApp(const MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    )
  ], child: const MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    super.initState();
    authService.getUserData(context);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: Provider.of<UserProvider>(context).user.access_token.isNotEmpty
          ? const BottomNavigationScreen()
          : const Login(),
      // ? const Login()
      // : const BottomNavigationScreen(),
      // home: Login(),
    );
  }
}
