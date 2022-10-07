import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/models/kodewarna.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/models/user.dart';
import 'package:flutter_project/constants/error_handpling.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/ultils.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AuthService {
  void register({
    required BuildContext context,
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        no_hp: phone,
        level: 'User',
        alamat: '',
        access_token: '',
        gambar: '',
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/user'),
        body: user.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      // ini register belum ada notif kalo gagal daftar
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(
            context,
            'User berhasil dibuat',
          );
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  void login({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/user/login'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      ).timeout(const Duration(seconds: 5));
      print(res.body); //kalo mau lihat isi respon yang didapat
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          await prefs.setString('auth', jsonDecode(res.body)['access_token']);
          Navigator.pushNamedAndRemoveUntil(
            context,
            // BottomBar.routeName,
            // MaterialPageRoute(builder: (context) => HomePage()),
            BottomNavigationScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  // get user data header
  void getUserData(
    BuildContext context,
  ) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('auth');

      if (token == null) {
        prefs.setString('auth', '');
      }
      var tokenRes = await http.get(
        Uri.parse('$uri/api/user/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': token!
        },
      );

      // print('respon = ' + tokenRes.body);
      var response = jsonDecode(tokenRes.body);
      if (response == true) {
        // get user data
        http.Response userRes = await http.get(
          Uri.parse('$uri/api/user/user'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'auth': token
          },
        );
        print(userRes.body);
        print('masukin data ke userProvider');
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        // print('set di body');
        userProvider.setUser(userRes.body);
      }
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }

  Future<List<Product>> fetchAllProducts(BuildContext context) async {
    // void fetchAllProducts(BuildContext context) async {
    List<Product> productList = [];
    try {
      http.Response res = await http.get(Uri.parse('$uri/api/item'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
      });
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          for (int i = 0; i < jsonDecode(res.body).length; i++) {
            productList.add(
              Product.fromJson(
                jsonEncode(
                  jsonDecode(res.body)[i],
                ),
              ),
            );
            // print(jsonDecode(jsonEncode(productList)));
          }
        },
      );
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
    return productList;
  }

  //// belum kepake
  // Future<List<KodeWarna>> fetchAllKodeColor(BuildContext context) async {
  //   List<KodeWarna> kodeWarnaList = [];
  //   try {
  //     http.Response res =
  //         await http.get(Uri.parse('$uri/api/kodewarna'), headers: {
  //       'Content-Type': 'application/json; charset=UTF-8',
  //     });
  //     print('body');
  //     print(res.body);
  //     httpErrorHandle(
  //       response: res,
  //       context: context,
  //       onSuccess: () {
  //         for (int i = 0; i < jsonDecode(res.body).length; i++) {
  //           kodeWarnaList.add(
  //             KodeWarna.fromJson(
  //               jsonEncode(
  //                 jsonDecode(res.body)[i],
  //               ),
  //             ),
  //           );
  //           print('loop');
  //           // print(jsonEncode(
  //           //   jsonDecode(res.body)[i],
  //           // ));
  //           // print(jsonDecode(jsonEncode(kodeWarnaList)));
  //         }
  //         print((jsonEncode(kodeWarnaList)).split("|"));
  //         final data = jsonDecode(jsonEncode(kodeWarnaList));
  //         print(KodeWarna.fromJson(data));
  //       },
  //     );
  //   } catch (e) {
  //     // showSnackBar(context, e.toString());
  //     Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
  //   }
  //   return kodeWarnaList;
  // }
}
