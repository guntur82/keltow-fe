import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/transaksi.dart';
import 'package:flutter_project/models/product.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
  List<Product>? products;
  List<Transaction>? transaksi;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  @override
  void initState() {
    super.initState();
    fetchCartList();
    fetchAllProduct();
    fetchAllTransaksi();
  }

  fetchCartList() async {
    cart = await productService.fetchCartListDone(context);
    setState(() {});
  }

  fetchAllProduct() async {
    products = await authService.fetchAllProducts(context);
    setState(() {});
  }

  fetchAllTransaksi() async {
    transaksi = await productService.fetchTransaksiList(context);
    setState(() {});
  }

  final List menu = [
    "Samsung Z Flip",
    "Vivo",
    "Oppo",
    "Vivo",
    "Vivo",
    "Vivo",
    "Vivo"
  ];
  @override
  Widget build(BuildContext context) {
    List detailProduct = [];
    List detailCart = [];
    List detailTransaction = [];
    if (products != null && cart != null && transaksi != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if ((Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId)) {
            for (int k = 0; k < jsonDecode(jsonEncode(transaksi)).length; k++) {
              var dataTransaksi = jsonDecode(jsonEncode(transaksi));
              if ((Transaction.fromJson(dataTransaksi[k]).cartId ==
                  Cart.fromJson(dataCart[j]).id)) {
                detailTransaction.add(dataTransaksi[k]);
                detailProduct.add(dataProduct[i]);
                detailCart.add(dataCart[j]);
              }
            }
          }
        }
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Transaksi",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.blue[200],
      ),
      backgroundColor: Colors.blue[200],
      body: Container(
        margin: EdgeInsets.only(top: 15, left: 8, right: 8),
        child: ListView.builder(
          itemCount: detailTransaction.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            var status = Cart.fromJson(detailCart[index]).status_pengiriman == 0
                ? 'Dikemas'
                : 'Selesai';
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
                        uriGambar +
                            Product.fromJson(detailProduct[index]).gambar,
                        // Image.asset(
                        //   "assets/samsung.jfif",
                        width: 100,
                        height: 100,
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Kode : " +
                                      Transaction.fromJson(
                                              detailTransaction[index])
                                          .kode_transaksi,
                                  style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic)),
                              const SizedBox(
                                height: 8,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            Product.fromJson(detailProduct[index]).name,
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Status Pesanan : " + status,
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic)),
                              const SizedBox(
                                width: 10,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Text(
                            "Item   : " +
                                Cart.fromJson(detailCart[index])
                                    .jumlah
                                    .toString(),
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Text(
                            "Total  : " +
                                Transaction.fromJson(detailTransaction[index])
                                    .totalHarga
                                    .toString(),
                            style: TextStyle(
                                fontSize: 16, color: Color(0xffFA6400)),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                        ],
                      )
                    ],
                  )),
            );
          },
        ),
      ),
      // Card(
      //   color: Colors.lightBlueAccent,
      //   child: ListView.builder(
      //     itemBuilder: (context, index) {
      //       return Card(
      //         shadowColor: Colors.black,
      //         elevation: 20,
      //         shape: RoundedRectangleBorder(
      //           side: BorderSide(
      //             color: Theme.of(context).colorScheme.outline,
      //           ),
      //           borderRadius: const BorderRadius.only(
      //             topLeft: Radius.circular(15),
      //             topRight: Radius.circular(15),
      //             bottomLeft: Radius.circular(15),
      //             bottomRight: Radius.circular(15),
      //           ),
      //         ),
      //         child: Padding(
      //             padding: EdgeInsets.all(15),
      //             child: Row(
      //               children: [
      //                 Image.asset(
      //                   "assets/samsung.jfif",
      //                   width: 100,
      //                   height: 100,
      //                 ),
      //                 SizedBox(
      //                   width: 12,
      //                 ),
      //                 Column(
      //                   crossAxisAlignment: CrossAxisAlignment.start,
      //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                   children: [
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Text("Kode Pembayaran : 078-ASDEQ-07-08",
      //                             style: TextStyle(
      //                                 fontSize: 12,
      //                                 color: Colors.blue,
      //                                 fontStyle: FontStyle.italic)),
      //                         const SizedBox(
      //                           height: 10,
      //                         ),
      //                       ],
      //                     ),
      //                     const SizedBox(
      //                       height: 10,
      //                     ),
      //                     Text(
      //                       "Samsung Note 8",
      //                       style: TextStyle(fontSize: 20),
      //                     ),
      //                     SizedBox(
      //                       height: 4,
      //                     ),
      //                     Row(
      //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //                       children: [
      //                         Text("Color",
      //                             style: TextStyle(
      //                                 color: Colors.blue,
      //                                 fontStyle: FontStyle.italic)),
      //                         const SizedBox(
      //                           width: 10,
      //                         ),
      //                         Icon(
      //                           Icons.panorama_wide_angle_select_outlined,
      //                           color: Colors.brown,
      //                         )
      //                       ],
      //                     ),
      //                     const SizedBox(
      //                       height: 10,
      //                     ),
      //                     Text(
      //                       "Item   : 1",
      //                       style: TextStyle(fontSize: 16, color: Colors.black),
      //                     ),
      //                     SizedBox(
      //                       height: 6,
      //                     ),
      //                     Text(
      //                       "Total  : Rp.12.000.000",
      //                       style: TextStyle(fontSize: 16, color: Colors.black),
      //                     ),
      //                     SizedBox(
      //                       height: 10,
      //                     ),
      //                   ],
      //                 )
      //               ],
      //             )),
      //       );
      //     },
      //     itemCount: menu.length,
      //   ),
      // ),
    );
  }
}
