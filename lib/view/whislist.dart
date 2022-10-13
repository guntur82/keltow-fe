import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/models/wishlist.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/view/NavigasiBar.dart';

class Whislist extends StatefulWidget {
  const Whislist({Key? key}) : super(key: key);

  @override
  State<Whislist> createState() => _WhislistState();
}

class _WhislistState extends State<Whislist> {
  List<WishList>? wishlist;
  List<Product>? products;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  @override
  void initState() {
    fetchWishList();
    fetchAllProduct();
    super.initState();
  }

  fetchWishList() async {
    wishlist = await productService.fetchWishList(context);
    setState(() {});
  }

  // tinggal munculin aja
  fetchAllProduct() async {
    products = await authService.fetchAllProducts(context);
    setState(() {});
  }

  void _toggleWishList(String id_barang) async {
    productService.wishList(
      context: context,
      itemId: id_barang,
      status: false,
    );
    wishlist = await productService.fetchWishList(context);
    var dataWish = await jsonDecode(jsonEncode(wishlist)) ?? null;
    print(dataWish);
    setState(() {
      dataWish.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    var dataWish = jsonDecode(jsonEncode(wishlist)) ?? null;
    var dataProduct = jsonDecode(jsonEncode(products)) ?? null;
    return dataWish == null || dataProduct == null
        ? Scaffold(
            backgroundColor: Colors.blue[200],
            body: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
            ))
        : Scaffold(
            appBar: AppBar(
              title: Text(
                "Whislist",
                style: TextStyle(color: Colors.black),
              ),
              backgroundColor: Colors.blue[200],
            ),
            backgroundColor: Colors.blue[200],
            body: Container(
              margin: EdgeInsets.only(top: 15, left: 8, right: 8),
              child: ListView.builder(
                itemCount: dataWish.length,
                itemBuilder: (context, index) {
                  var id = WishList.fromJson(dataWish[index]).itemId;
                  var data;
                  for (int i = 0; i < dataProduct.length; i++) {
                    if (Product.fromJson(dataProduct[i]).id == id) {
                      data = dataProduct[i];
                    }
                  }
                  return Card(
                    shadowColor: Colors.black,
                    elevation: 20,
                    shape: RoundedRectangleBorder(
                      side: BorderSide(
                        color: Theme.of(context).colorScheme.outline,
                      ),
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                    ),
                    child: Padding(
                        padding: EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Image.network(
                              uriGambar + Product.fromJson(data).gambar,
                              fit: BoxFit.contain,
                              height: 100,
                              width: 100,
                            ),
                            // Image.asset(
                            //   "assets/samsung.jfif",
                            //   width: 100,
                            //   height: 100,
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  Product.fromJson(data).name,
                                  style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Text(
                                  convertToIdr(Product.fromJson(data).harga, 2)
                                      .toString(),
                                  style: TextStyle(
                                      fontSize: 12, color: Colors.amber),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      size: 18,
                                      color: Colors.yellow,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text("5 (100 Rating)",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontStyle: FontStyle.italic)),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                            minimumSize: const Size(80, 32),
                                            primary: Colors.blue,
                                            side: BorderSide(
                                                color: Colors.blue, width: 1.5),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(25))),
                                        onPressed: () {},
                                        child: Text(
                                          'Buy Now',
                                          style: TextStyle(
                                              fontSize: 12,
                                              color: Colors.white),
                                        )),
                                    SizedBox(
                                      width: 60,
                                    ),
                                    IconButton(
                                        onPressed: () {
                                          _toggleWishList(Product.fromJson(data)
                                              .id
                                              .toString());
                                          setState(() {});
                                        },
                                        icon: const Icon(
                                          Icons.restore_from_trash,
                                          size: 30,
                                          color: Colors.red,
                                        )),
                                  ],
                                ),
                              ],
                            )
                          ],
                        )),
                  );
                },
              ),
            ),
          );
  }
}
