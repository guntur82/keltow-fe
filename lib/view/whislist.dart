import 'package:flutter/material.dart';

class Whislist extends StatefulWidget {
  const Whislist({Key? key}) : super(key: key);

  @override
  State<Whislist> createState() => _WhislistState();
}

class _WhislistState extends State<Whislist> {
  final List menu = [
    "Samsung Z Flip",
    "Vivo",
    "Oppo",
    "nokia",
    "nokia",
    "nokia",
    "Vivo",
    "Vivo",
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
      backgroundColor: Colors.lightBlueAccent,
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
                          Text(
                            "Samsung Note 8",
                            style: TextStyle(
                                fontSize: 15, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(
                            height: 4,
                          ),
                          Text(
                            "Rp.12.000.000",
                            style: TextStyle(fontSize: 12, color: Colors.amber),
                          ),
                          SizedBox(
                            height: 6,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                        fontSize: 12, color: Colors.white),
                                  )),
                              SizedBox(
                                width: 60,
                              ),
                              IconButton(
                                  onPressed: () {},
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
          itemCount: menu.length,
        ),
      ),
    );
  }
}
