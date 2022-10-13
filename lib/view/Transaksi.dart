import 'package:flutter/material.dart';

class Transaksi extends StatefulWidget {
  const Transaksi({Key? key}) : super(key: key);

  @override
  State<Transaksi> createState() => _TransaksiState();
}

class _TransaksiState extends State<Transaksi> {
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
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.lightBlueAccent,
      //   title: Row(
      //     children: [
      //       Expanded(
      //         flex: 5,
      //         child: Container(
      //           child: TextField(
      //             decoration: InputDecoration(
      //               border: OutlineInputBorder(
      //                 borderRadius: BorderRadius.circular(16),
      //               ),
      //               contentPadding: EdgeInsets.symmetric(
      //                 vertical: 0,
      //                 horizontal: 10,
      //               ),
      //               hintText: "Search Product....",
      //               hintStyle: TextStyle(color: Colors.black54),
      //               fillColor: Colors.white54,
      //               filled: true,
      //               prefixIcon: Icon(Icons.search),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: Container(
      //           //margin: EdgeInsets.only(top: 60),
      //           child: IconButton(
      //             onPressed: () {},
      //             icon: Icon(Icons.notifications_none),
      //             color: Colors.black54,
      //           ),
      //         ),
      //       ),
      //       Expanded(
      //         flex: 1,
      //         child: Container(
      //           //margin: EdgeInsets.only(top: 60),
      //           child: IconButton(
      //               onPressed: () {},
      //               icon: const Icon(Icons.shopping_cart_rounded),
      //               color: Colors.black54),
      //         ),
      //       )
      //     ],
      //   ),
      // ),
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
          itemBuilder: (context, index) {
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
                      Image.asset(
                        "assets/samsung.jfif",
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
                              Text("Kode Pembayaran : 078-ASDEQ-07-08",
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
                            "Samsung Note 8",
                            style: TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Color",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      fontStyle: FontStyle.italic)),
                              const SizedBox(
                                width: 10,
                              ),
                              Icon(
                                Icons.panorama_wide_angle_select_outlined,
                                color: Colors.brown,
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 0,
                          ),
                          Text(
                            "Item   : 1",
                            style: TextStyle(fontSize: 16, color: Colors.black),
                          ),
                          SizedBox(
                            height: 0,
                          ),
                          Text(
                            "Total  : Rp.12.000.000",
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
          itemCount: menu.length,
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
