import 'dart:math';
import 'dart:ui';
import 'dart:convert';
import "package:flutter/material.dart";
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/search/search_screen.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/kodewarna.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:flutter_project/view/Payment.dart';
import 'package:flutter_project/view/whislist.dart';
import 'package:flutter_project/constants/global_variables.dart';

class detail extends StatefulWidget {
  static const String routeName = '/product-details';
  final Product product;
  const detail({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  State<detail> createState() => _detailState();
}

class _detailState extends State<detail> {
  List<KodeWarna>? kodeColor;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();

  void navigateToSeachScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void addToCart() {
    productService.addToCart(
      context: context,
      product: widget.product,
      jumlah: 1,
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // fetchAllKodeColor();
  }

  //// belum kapake
  // fetchAllKodeColor() async {
  //   kodeColor = await authService.fetchAllKodeColor(context);
  //   setState(() {});
  // }

  @override
  Widget build(BuildContext context) {
    // var data = jsonDecode(jsonEncode(kodeColor)); // blm terpake karna blm ada relasi
    // print(data);
    return Scaffold(
      backgroundColor: Colors.white,
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
                //margin: EdgeInsets.only(top: 60),
                child: IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shopping_cart_rounded),
                    color: Colors.black54),
              ),
            )
          ],
        ),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // height: 250,
                // width: 165,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * .5,

                decoration: BoxDecoration(
                    image: DecorationImage(
                        // image: AssetImage(
                        //   "assets/samsung.jfif",
                        // ),
                        image: NetworkImage(uriGambar + widget.product.gambar),
                        scale: 0.8,
                        alignment: Alignment.center
                        //fit: BoxFit.cover
                        )),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  // height: MediaQuery.of(context).size.height,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(40),
                        topRight: Radius.circular(40),
                      ),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(.2),
                            offset: Offset(0, -4),
                            blurRadius: 8),
                      ]),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // "Samsung Z-Flip 8/128Gb 183g, 7.2mm thickness Android 10, up to Android 12,One UI 4 256GB storage, no card slot",
                                  widget.product.deskripsi,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  // "Rp.12.000.000",
                                  convertToIdr(widget.product.harga, 2)
                                      .toString(),
                                  style: TextStyle(
                                      color: Colors.orange,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Icon(
                                Icons.favorite_outline,
                                color: Colors.black,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: Colors.yellow,
                                size: 20,
                              ),
                              SizedBox(width: 2),
                              Text(
                                "5 (100 rating)",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                              SizedBox(width: 120),
                              Expanded(
                                child: Text(
                                  "SEE REVIEW",
                                  style: TextStyle(
                                    color: Colors.purple,
                                    fontSize: 15,
                                    //fontWeight: FontWeight.bold
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 0),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Column(
                                children: [
                                  Text(
                                    "Choose Color",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      /// start (blm jalan blm ada relasinya ternayta hehe :3)
                                      // kodeColor == null
                                      //     ? const Loader()
                                      //     : ListView.builder(
                                      //         itemCount: kodeColor!.length,
                                      //         itemBuilder: (context, index) {
                                      //           final color = kodeColor![index];
                                      //           print(color);
                                      //           return Text('test');
                                      //           // Container(
                                      //           //   height: 20,
                                      //           //   width: 30,
                                      //           //   decoration: BoxDecoration(
                                      //           //     color: Colors.red,
                                      //           //     borderRadius:
                                      //           //         BorderRadius.circular(
                                      //           //             10),
                                      //           //   ),
                                      //           // );
                                      //         },
                                      //         scrollDirection: Axis.horizontal,
                                      //       ),
                                      /// end
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.green,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Container(
                                        height: 20,
                                        width: 30,
                                        decoration: BoxDecoration(
                                          color: Colors.black,
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 65,
                                      ),
                                      Row(
                                        children: [
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "-",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 40,
                                            child: Center(
                                              child: Text(
                                                "1",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                          Container(
                                            height: 30,
                                            width: 40,
                                            decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius:
                                                    BorderRadius.circular(10)),
                                            child: Center(
                                              child: Text(
                                                "+",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 15,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 15,
                            left: 20,
                            right: 20,
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "Total",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                // "Rp.12.000.000",
                                convertToIdr(widget.product.harga, 2)
                                    .toString(),
                                style: TextStyle(
                                  color: Colors.orange,
                                  fontSize: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ]),
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: new Stack(
        alignment: new FractionalOffset(.5, 1.0),
        children: [
          new Container(
            height: 0,
            color: Colors.white,
          ),
          new Padding(
              padding: const EdgeInsets.only(bottom: 12.0),
              child: Row(
                children: [
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(140, 50),
                              primary: Colors.yellow,
                              side: BorderSide(
                                  width: 1.5, color: Colors.yellow[400]!),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0))),
                          onPressed: () {
                            setState(() {
                              addToCart();
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      BottomNavigationScreen(),
                                ),
                              );
                            });
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //         builder: (context) => Whislist()));
                          },
                          child: Text("ADD TO CARD")),
                      SizedBox(
                        width: 32,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              minimumSize: const Size(140, 50),
                              primary: Colors.blue,
                              side: BorderSide(width: 1.5, color: Colors.blue),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(0))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Payment()));
                          },
                          child: Text("BUY NOW")),
                    ],
                  ))
                ],
              )),
        ],
      ),
    );
  }
}
