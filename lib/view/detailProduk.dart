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
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:flutter_project/view/Payment.dart';
import 'package:flutter_project/view/whislist.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:provider/provider.dart';

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
  int jumlah = 1;
  double? harga;
  bool _isWish = false;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchWishStatus();
    // fetchAllKodeColor();
  }

  fetchWishStatus() async {
    _isWish = await productService.wishListDetail(
        context: context, itemId: widget.product.id.toString());
    setState(() {});
  }

  void _toggleWishList(String id_barang) {
    setState(() {
      _isWish = !_isWish;
    });
    productService.wishList(
      context: context,
      itemId: id_barang,
      status: _isWish,
    );
  }

  void addToCart() {
    productService.addToCart(
      context: context,
      product: widget.product,
      jumlah: jumlah,
    );
  }

  void navigateToSeachScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
  }

  void increaseQuantity(int result) {
    jumlah = result + 1;
    // harga
    setState(() {});
  }

  void decreaseQuantity(int result) {
    if (jumlah != 0) {
      jumlah = result - 1;
    }
    setState(() {});
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
    harga == null
        ? harga = widget.product.harga
        : harga = widget.product.harga * jumlah;
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
                              // icon
                              // Icon(
                              //   Icons.favorite_outline,
                              //   color: Colors.black,
                              //   size: 25,
                              // ),
                              GestureDetector(
                                onTap: () {
                                  _toggleWishList(widget.product.id.toString());
                                },
                                child: Icon(
                                  _isWish
                                      ? Icons.favorite
                                      : Icons.favorite_outline,
                                  color: _isWish ? Colors.red : Colors.black,
                                ),
                              )
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
                                    "Jumlah",
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

                                      Row(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: Colors.black12,
                                                width: 1.5,
                                              ),
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.black12,
                                            ),
                                            child: Row(
                                              children: [
                                                InkWell(
                                                  onTap: () =>
                                                      decreaseQuantity(jumlah),
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
                                                    border: Border.all(
                                                        color: Colors.black12,
                                                        width: 1.5),
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            0),
                                                  ),
                                                  child: Container(
                                                    width: 35,
                                                    height: 32,
                                                    alignment: Alignment.center,
                                                    child: Text(
                                                      jumlah.toString(),
                                                    ),
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () =>
                                                      increaseQuantity(jumlah),
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
                                          // original
                                          // Container(
                                          //   height: 30,
                                          //   width: 40,
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.grey,
                                          //       borderRadius:
                                          //           BorderRadius.circular(10)),
                                          //   child: Center(
                                          //     child: Text(
                                          //       "-",
                                          //       style: TextStyle(
                                          //           color: Colors.black,
                                          //           fontSize: 15,
                                          //           fontWeight:
                                          //               FontWeight.bold),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   height: 30,
                                          //   width: 40,
                                          //   child: Center(
                                          //     child: Text(
                                          //       "1",
                                          //       style: TextStyle(
                                          //           color: Colors.black,
                                          //           fontSize: 15,
                                          //           fontWeight:
                                          //               FontWeight.bold),
                                          //     ),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   height: 30,
                                          //   width: 40,
                                          //   decoration: BoxDecoration(
                                          //       color: Colors.grey,
                                          //       borderRadius:
                                          //           BorderRadius.circular(10)),
                                          //   child: Center(
                                          //     child: Text(
                                          //       "+",
                                          //       style: TextStyle(
                                          //           color: Colors.black,
                                          //           fontSize: 15,
                                          //           fontWeight:
                                          //               FontWeight.bold),
                                          //     ),
                                          //   ),
                                          // )
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
                                convertToIdr(harga, 2).toString(),
                                // convertToIdr(widget.product.harga, 2)
                                //     .toString(),
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
                              primary: Colors.yellow[700],
                              side: BorderSide(
                                  width: 1.5, color: Colors.yellow[400]!),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10))),
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
                                  borderRadius: BorderRadius.circular(10))),
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
