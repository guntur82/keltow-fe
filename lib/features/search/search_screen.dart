import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/loader.dart';
import 'package:flutter_project/features/search/search_service.dart';
import 'package:flutter_project/models/product.dart';
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
  final SearchServices searchServices = SearchServices();

  @override
  void initState() {
    super.initState();
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

  @override
  Widget build(BuildContext context) {
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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Container(
                          width: MediaQuery.of(context).size.width,
                          constraints: const BoxConstraints(
                            minHeight: 30,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => detail()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: Container(
                                height: 130,
                                width: 95,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  // border: Border.all(color: Colors.black,width: 2),
                                  borderRadius: BorderRadius.circular(18),
                                  image: DecorationImage(
                                      // image: AssetImage("assets/samsung.jfif"),
                                      image: NetworkImage(picture),
                                      // colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.darken),
                                      scale: 1.6,
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
                              ),
                            ),
                          ),
                        ),
                        Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                            Text(
                              convertToIdr(productData.harga, 2).toString(),
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(
                              // width: 8,
                              width: 15,
                              height: 15,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
          );
  }
}
