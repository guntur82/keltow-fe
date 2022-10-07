import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/cart_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/Cart.dart';

class CartProduct extends StatefulWidget {
  final int index;
  const CartProduct({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {
  List<Product>? products;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  final CartService cartService = CartService();
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

  void increaseQuantity(Product product) {
    productService.addToCart(
      context: context,
      product: product,
      jumlah: 1,
    );
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => CartScreen(),
      ),
    );
  }

  void decreaseQuantity(Product product) {
    cartService.removeFromCart(
      context: context,
      product: product,
      jumlah: 1,
    );
  }

  @override
  Widget build(BuildContext context) {
    final cartItem = (jsonDecode(jsonEncode(cart?[widget.index])));
    final itemId = cartItem == null ? '' : Cart.fromJson(cartItem).itemId;
    final item = (jsonDecode(jsonEncode(products)));
    var data;
    if (item != null) {
      for (int i = 0; i < item.length; i++) {
        if (Product.fromJson(item?[i]).id == itemId) {
          data = item?[i];
        }
      }
    }
    // print('test');
    // print(data);
    // print(cartItem);
    return (data == null || cartItem == null)
        ? const Loader()
        : Column(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10,
                ),
                child: Row(
                  children: [
                    Image.network(
                      uriGambar + Product.fromJson(data).gambar,
                      fit: BoxFit.contain,
                      height: 135,
                      width: 135,
                    ),
                    Column(
                      children: [
                        Container(
                          width: 235,
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(
                            Product.fromJson(data).name,
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            convertToIdr(Product.fromJson(data).harga, 2)
                                .toString(),
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10),
                          child: Text(Product.fromJson(data).deskripsi),
                        ),
                        Container(
                          width: 235,
                          padding: const EdgeInsets.only(left: 10, top: 5),
                          child: Text(
                            'In Stock : ' +
                                (Product.fromJson(data).stok).toString(),
                            style: TextStyle(
                              color: Colors.teal,
                            ),
                            maxLines: 2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black12,
                          width: 1.5,
                        ),
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.black12,
                      ),
                      child: Row(
                        children: [
                          InkWell(
                            onTap: () =>
                                decreaseQuantity(Product.fromJson(data)),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.remove,
                                size: 18,
                              ),
                            ),
                          ),
                          DecoratedBox(
                            decoration: BoxDecoration(
                              border:
                                  Border.all(color: Colors.black12, width: 1.5),
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(0),
                            ),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: Text(
                                Cart.fromJson(cartItem).jumlah.toString(),
                              ),
                            ),
                          ),
                          InkWell(
                            onTap: () =>
                                increaseQuantity(Product.fromJson(data)),
                            child: Container(
                              width: 35,
                              height: 32,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.add,
                                size: 18,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
  }
}
