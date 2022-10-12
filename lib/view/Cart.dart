import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/search/search_screen.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/features/widgets/cart_product.dart';
import 'package:flutter_project/features/widgets/cart_subtotal.dart';
import 'package:flutter_project/features/widgets/custom_button.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/Address.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<Product>? products;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  @override
  void initState() {
    super.initState();
    fetchCartList();
    fetchAllProduct();
  }

  void navigateToSeachScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void navigateToAddress(int sum) {
    Navigator.pushNamed(context, AddressScreen.routeName,
        arguments: sum.toString());
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
    int count = 0;
    if (products != null && cart != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if (Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId) {
            count++;
            countItem += Cart.fromJson(dataCart[j]).jumlah;
            sum += Product.fromJson(dataProduct[i]).harga.toInt() *
                Cart.fromJson(dataCart[j]).jumlah;
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
        title: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                child: TextFormField(
                  onFieldSubmitted: navigateToSeachScreen,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 10,
                    ),
                    hintText: "Search Product....",
                    hintStyle: TextStyle(color: Colors.black54),
                    fillColor: Colors.white54,
                    filled: true,
                    prefixIcon: Icon(Icons.search),
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                //margin: EdgeInsets.only(top: 60),
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.notifications_none),
                  color: Colors.black54,
                ),
              ),
            ),
            Expanded(
                flex: 1,
                child: Container(
                  child: IconButton(
                    onPressed: () {},
                    color: Colors.black54,
                    icon: new Stack(
                      children: <Widget>[
                        new Icon(Icons.shopping_cart_rounded),
                        // if (countCart != 0)
                        //   new Positioned(
                        //     right: 0,
                        //     child: new Container(
                        //       padding: EdgeInsets.all(1),
                        //       decoration: new BoxDecoration(
                        //         color: Colors.red,
                        //         borderRadius: BorderRadius.circular(6),
                        //       ),
                        //       constraints: BoxConstraints(
                        //         minWidth: 12,
                        //         minHeight: 12,
                        //       ),
                        //       child: new Text(
                        //         countCart.toString(),
                        //         style: new TextStyle(
                        //           color: Colors.white70,
                        //           fontSize: 8,
                        //         ),
                        //         textAlign: TextAlign.center,
                        //       ),
                        //     ),
                        //   )
                      ],
                    ),
                  ),
                )
                // child: IconButton(
                //     onPressed: () {},
                //     icon: const Icon(Icons.shopping_cart_rounded),
                //     color: Colors.black54),
                )
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 5),
              cart == null
                  ? const Loader()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: count,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return CartProduct(
                          index: index,
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
      // start
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(
                text: 'Jumlah barang yang dibeli (${countItem})',
                onTap: () => navigateToAddress(sum),
                color: Colors.blue[600],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
