import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/error_handpling.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class SearchServices {
  Future<List<Product>> fetchSearchProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<Product> productList = [];
    try {
      http.Response res = await http
          .get(Uri.parse('$uri/api/item/search/$searchQuery'), headers: {
        'Content-Type': 'application/json; charset=UTF-8',
        'auth': userProvider.user.access_token
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
            }
          });
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
    return productList;
  }
}
