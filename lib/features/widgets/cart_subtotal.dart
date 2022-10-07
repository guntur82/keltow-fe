import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatefulWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  State<CartSubtotal> createState() => _CartSubtotalState();
}

class _CartSubtotalState extends State<CartSubtotal> {
  List<Product>? products;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCartList();
    fetchAllProduct();
  }

  fetchCartList() async {
    cart = await productService.fetchCartList(context);
    setState(() {});
  }

  fetchAllProduct() async {
    products = await authService.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int countItem = 0;
    int sum = 0;
    if (products != null && cart != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if (Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId) {
            countItem += Cart.fromJson(dataCart[j]).jumlah;
            sum += (Product.fromJson(dataProduct[i]).harga).toInt() *
                Cart.fromJson(dataCart[j]).jumlah;
          }
        }
      }
    }
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: [
          const Text(
            'Subtotal ',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          Text(
            convertToIdr(sum, 2).toString(),
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
