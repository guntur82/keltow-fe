import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/detailProduk.dart';
import 'package:flutter_project/providers/user_provider.dart';
// import 'package:flutter_project/view/single_product.dart'; //buat list hp yang kebeli
import 'package:provider/provider.dart';

final List<String> imgList = [
  'https://images.unsplash.com/photo-1520342868574-5fa3804e551c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=6ff92caffcdd63681a35134a6770ed3b&auto=format&fit=crop&w=1951&q=80',
  'https://images.unsplash.com/photo-1522205408450-add114ad53fe?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=368f45b0888aeb0b7b08e3a1084d3ede&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1519125323398-675f0ddb6308?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=94a1e718d89ca60a6337a6008341ca50&auto=format&fit=crop&w=1950&q=80',
  'https://images.unsplash.com/photo-1523205771623-e0faa4d2813d?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=89719a0d55dd05e2deae4120227e6efc&auto=format&fit=crop&w=1953&q=80',
  'https://images.unsplash.com/photo-1508704019882-f9cf40e475b4?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=8c6e5e3aba713b17aa1fe71ab4f0ae5b&auto=format&fit=crop&w=1352&q=80',
  'https://images.unsplash.com/photo-1519985176271-adb1088fa94c?ixlib=rb-0.3.5&ixid=eyJhcHBfaWQiOjEyMDd9&s=a0c8d632e977f94e5d312d9893258f59&auto=format&fit=crop&w=1355&q=80'
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
                    Image.network(item, fit: BoxFit.cover, width: 9000.0),
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
                        child: Text(
                          'No. ${imgList.indexOf(item)} image',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ))
    .toList();

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  // temporary list

  List<Product>? products;
  final AuthService authService = AuthService();
  late TabController _tabController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(
      vsync: this,
      length: 0,
    );
    fetchAllProduct();
  }

  fetchAllProduct() async {
    products = await authService.fetchAllProducts(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    products == null ? print('ga ada') : print('ada');
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
                      child: TextField(
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
            backgroundColor: Colors.lightBlueAccent,
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
                    height: 300,
                    child: GridView.builder(
                      itemCount: products!.length,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2),
                      itemBuilder: (context, index) {
                        final productData = products![index];
                        var picture = uriGambar + productData.gambar;
                        return Column(
                          children: [
                            Column(
                              children: [
                                Container(
                                  child: Material(
                                    color: Colors.transparent,
                                    child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    detail()));
                                      },
                                      child: Container(
                                        height: 250,
                                        width: 165,
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          // border: Border.all(color: Colors.black,width: 2),
                                          borderRadius:
                                              BorderRadius.circular(18),
                                          image: DecorationImage(
                                              // image: AssetImage("assets/samsung.jfif"),
                                              image: NetworkImage(picture),
                                              // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                                              scale: 1.6,
                                              alignment: Alignment.center),
                                          boxShadow: [
                                            BoxShadow(
                                              color:
                                                  Colors.black.withOpacity(0.5),
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
                                                  left: 6, top: 210),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    productData.name,
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(width: 8),
                                                  Icon(
                                                    Icons.star,
                                                    color: Colors.yellow,
                                                    size: 14,
                                                  ),
                                                  SizedBox(width: 2),
                                                  Text(
                                                    "5 (100 rating)",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Container(
                                              padding: EdgeInsets.only(left: 8),
                                              child: Row(
                                                children: [
                                                  Text(
                                                    convertToIdr(
                                                            productData.harga,
                                                            2)
                                                        .toString(),
                                                    style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  SizedBox(
                                                    width: 8,
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
