import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/search/search_screen.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/Cart.dart';
import 'package:flutter_project/view/detailProduk.dart';
import 'package:flutter_project/providers/user_provider.dart';
// import 'package:flutter_project/view/single_product.dart'; //buat list hp yang kebeli
import 'package:provider/provider.dart';
import 'package:badges/badges.dart';
import 'dart:convert';

final List<String> imgList = [
  'assets/oppo2.jfif',
  'assets/iphone2.jfif',
  'assets/realme.jfif',
  'assets/samsung1.jfif',
  'assets/vivo1.jfif',
  'assets/nokia1.jfif'
];

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

final List<Widget> imageSliders = imgList
    .map((item) => Container(
          child: Container(
            margin: EdgeInsets.all(5.0),
            child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              child: Stack(
                children: <Widget>[
                  Image.asset(item, fit: BoxFit.cover, width: 5000.0),
                  Positioned(
                    bottom: 0.0,
                    left: 0.0,
                    right: 0.0,
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(200, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      padding: EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 20.0),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ))
    .toList();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  List<Product>? products;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 0,
    );
    fetchCartList();
    fetchAllProduct();
  }

  void navigateToSeachScreen(String query) {
    Navigator.pushNamed(context, SearchScreen.routeName, arguments: query);
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
    final user = Provider.of<UserProvider>(context).user;
    int countCart = 0;
    if (products != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if (Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId) {
            countCart += Cart.fromJson(dataCart[j]).jumlah;
          }
        }
      }
    }

    return products == null
        ? const Loader()
        : Scaffold(
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
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CartScreen()));
                          },
                          color: Colors.black54,
                          icon: new Stack(
                            children: <Widget>[
                              new Icon(Icons.shopping_cart_rounded),
                              if (countCart != 0)
                                new Positioned(
                                  right: 0,
                                  child: new Container(
                                    padding: EdgeInsets.all(1),
                                    decoration: new BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                    ),
                                    constraints: BoxConstraints(
                                      minWidth: 12,
                                      minHeight: 12,
                                    ),
                                    child: new Text(
                                      countCart.toString(),
                                      style: new TextStyle(
                                        color: Colors.white70,
                                        fontSize: 8,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )
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
            backgroundColor: Colors.blue[100],
            body: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(
                children: [
                  SizedBox(
                    height: 8,
                  ),
                  Container(
                    child: CarouselSlider(
                      options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 2.0,
                        enlargeCenterPage: true,
                      ),
                      items: imageSliders,
                    ),
                  ),
                  SizedBox(
                    // height: 300,
                    height: MediaQuery.of(context).size.height,
                    child: GridView.builder(
                      itemCount: products!.length,
                      primary: false,
                      padding: const EdgeInsets.all(10),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 15,
                        mainAxisSpacing: 15,
                      ),
                      itemBuilder: (context, index) {
                        final productData = products![index];
                        var picture = uriGambar + productData.gambar;
                        return Column(
                          children: [
                            Container(
                              child: Material(
                                color: Colors.transparent,
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.pushNamed(
                                        context, detail.routeName,
                                        arguments: productData);
                                  },
                                  child: Container(
                                    height: 180,
                                    width: 160,
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      // border: Border.all(color: Colors.black,width: 2),
                                      borderRadius: BorderRadius.circular(18),
                                      image: DecorationImage(
                                          // image: AssetImage("assets/samsung.jfif"),
                                          image: NetworkImage(picture),
                                          // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                                          scale: 2.2,
                                          alignment: Alignment.center),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withOpacity(0.5),
                                          spreadRadius: 5,
                                          blurRadius: 3,
                                          offset: Offset(0,
                                              3), // changes position of shadow
                                        ),
                                      ],
                                    ),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: 6, top: 150),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  textAlign: TextAlign.center,
                                                  productData.name,
                                                  style: TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 9,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ),
                                              SizedBox(width: 8),
                                              Row(
                                                children: [
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 14,
                                                  ),
                                                  // SizedBox(width: 2),
                                                  Text(
                                                    "5 (100 rating)",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 9,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(left: 15),
                                          child: Row(
                                            children: [
                                              Text(
                                                convertToIdr(
                                                        productData.harga, 2)
                                                    .toString(),
                                                style: TextStyle(
                                                    color: Colors.red,
                                                    fontSize: 9,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
            // body: GridView.builder(
            //   itemCount: products!.length,
            //   gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            //       crossAxisCount: 2),
            //   itemBuilder: (context, index) {
            //     final productData = products![index];
            //     var picture = uriGambar + productData.gambar;
            //     return Column(
            //       children: [
            //         Column(
            //           children: [
            //             Container(
            //               child: Material(
            //                 color: Colors.transparent,
            //                 child: InkWell(
            //                   onTap: () {
            //                     Navigator.push(
            //                         context,
            //                         MaterialPageRoute(
            //                             builder: (context) => detail()));
            //                   },
            //                   child: Container(
            //                     height: 250,
            //                     width: 165,
            //                     decoration: BoxDecoration(
            //                       color: Colors.white,
            //                       // border: Border.all(color: Colors.black,width: 2),
            //                       borderRadius: BorderRadius.circular(18),
            //                       image: DecorationImage(
            //                           // image: AssetImage("assets/samsung.jfif"),
            //                           image: NetworkImage(picture),
            //                           // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
            //                           scale: 1.6,
            //                           alignment: Alignment.center),
            //                       boxShadow: [
            //                         BoxShadow(
            //                           color: Colors.black.withOpacity(0.5),
            //                           spreadRadius: 5,
            //                           blurRadius: 3,
            //                           offset: Offset(
            //                               0, 3), // changes position of shadow
            //                         ),
            //                       ],
            //                     ),
            //                     child: Column(
            //                       children: [
            //                         Container(
            //                           padding:
            //                               EdgeInsets.only(left: 6, top: 210),
            //                           child: Row(
            //                             children: [
            //                               Text(
            //                                 productData.name,
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 10,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               SizedBox(width: 8),
            //                               Icon(
            //                                 Icons.star,
            //                                 color: Colors.yellow,
            //                                 size: 14,
            //                               ),
            //                               SizedBox(width: 2),
            //                               Text(
            //                                 "5 (100 rating)",
            //                                 style: TextStyle(
            //                                     color: Colors.black,
            //                                     fontSize: 10,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                         Container(
            //                           padding: EdgeInsets.only(left: 8),
            //                           child: Row(
            //                             children: [
            //                               Text(
            //                                 convertToIdr(productData.harga, 2)
            //                                     .toString(),
            //                                 style: TextStyle(
            //                                     color: Colors.red,
            //                                     fontSize: 10,
            //                                     fontWeight: FontWeight.bold),
            //                               ),
            //                               SizedBox(
            //                                 width: 8,
            //                               ),
            //                             ],
            //                           ),
            //                         ),
            //                       ],
            //                     ),
            //                   ),
            //                 ),
            //               ),
            //             ),
            //           ],
            //         ),
            //       ],
            //     );
            //   },
            // ),
          );
  }
}
