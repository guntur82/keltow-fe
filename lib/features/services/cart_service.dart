import 'package:flutter/material.dart';
import 'package:flutter_project/constants/error_handpling.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/ultils.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class CartService {
  void removeFromCart({
    required BuildContext context,
    required Product product,
    required int jumlah,
  }) async {
    try {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      var now = new DateTime.now();
      var formatter = new DateFormat('yyyy-MM-dd');
      String formattedDate = formatter.format(now);
      // khusus add to cart
      var status_barang = 0;
      Cart cart = Cart(
        id: 0,
        tanggal: formattedDate,
        itemId: product.id!,
        jumlah: jumlah,
        status_barang: status_barang,
        ratting: 0,
        status_pengiriman: 0,
        userId: 0,
      );

      http.Response res = await http.post(
        Uri.parse('$uri/api/cart'),
        body: cart.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'auth': userProvider.user.access_token,
        },
      );

      // sengaja diilangin soalnya masih bug view
      // httpErrorHandle(
      //   response: res,
      //   context: context,
      //   onSuccess: () {
      //     showSnackBar(
      //       context,
      //       'Barang berhasil ditambahkan kedalam cart',
      //     );
      //     // User user =
      //     //     userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
      //     // userProvider.setUserFromModel(user);
      //   },
      // );
    } catch (e) {
      // showSnackBar(context, e.toString());
      Fluttertoast.showToast(msg: e.toString(), toastLength: Toast.LENGTH_LONG);
    }
  }
}
