import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/search/search_service.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:flutter_project/view/Cart.dart';
import 'package:flutter_project/view/detailProduk.dart';

class SearchScreen extends StatefulWidget {
  static const String routeName = '/search-screen';
  final String searchQuery;
  const SearchScreen({
    Key? key,
    required this.searchQuery,
  }) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<Product>? products;
  final AuthService authService = AuthService();
  final SearchServices searchServices = SearchServices();
  List<Cart>? cart;
  final ProductService productService = ProductService();

  @override
  void initState() {
    super.initState();
    fetchCartList();
    fetchAllProduct();
    fetchSearchProduct();
  }

  fetchSearchProduct() async {
    products = await searchServices.fetchSearchProduct(
        context: context, searchQuery: widget.searchQuery);
    setState(() {});
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
    int countCart = 0;
    if (products != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if (Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId) {
            countCart++;
            // print(Product.fromJson(dataProduct[i])
            //     .name); //dipake buat di cartnya aja
            // print(Cart.fromJson(dataCart[j])
            //     .itemId); //dipake buat di cartnyta aja
            // print(countCart); //bikin di notif cart biar ada number
          }
        }
      }
    }
    print(countCart);
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
                      ))
                ],
              ),
            ),
            backgroundColor: Colors.blue[100],
            body: GridView.builder(
              itemCount: products!.length,
              primary: false,
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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
                            Navigator.pushNamed(context, detail.routeName,
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
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Container(
                                  padding: EdgeInsets.only(left: 6, top: 150),
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
                                              fontWeight: FontWeight.bold),
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
                                                fontWeight: FontWeight.bold),
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
                                        convertToIdr(productData.harga, 2)
                                            .toString(),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 9,
                                            fontWeight: FontWeight.bold),
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
          );
  }
}
