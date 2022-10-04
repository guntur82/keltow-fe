// Stack(
//         children: [
//           Container(
//             // height: 250,
//             // width: 165,
//             width: MediaQuery.of(context).size.width,
//             height: MediaQuery.of(context).size.height * .5,

//             decoration: BoxDecoration(
//                 image: DecorationImage(
//                     image: AssetImage(
//                       "assets/samsung.jfif",
//                     ),
//                     scale: 0.8,
//                     alignment: Alignment.center
//                     //fit: BoxFit.cover
//                     )),
//           ),
//           Align(
//             alignment: Alignment.bottomCenter,
//             child: Container(
//               width: MediaQuery.of(context).size.width,
//               height: MediaQuery.of(context).size.height * .3,
//               decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                     topLeft: Radius.circular(40),
//                     topRight: Radius.circular(40),
//                   ),
//                   boxShadow: [
//                     BoxShadow(
//                         color: Colors.black.withOpacity(.2),
//                         offset: Offset(0, -4),
//                         blurRadius: 8),
//                   ]),
//               child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 15,
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "Samsung Z-Flip 8/128Gb 183g, 7.2mm thickness Android 10, up to Android 12,One UI 4 256GB storage, no card slot",
//                               style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 //fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 15,
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         children: [
//                           Expanded(
//                             child: Text(
//                               "Rp.12.000.000",
//                               style: TextStyle(
//                                   color: Colors.orange,
//                                   fontSize: 20,
//                                   fontWeight: FontWeight.bold),
//                             ),
//                           ),
//                           Icon(
//                             Icons.favorite_outline,
//                             color: Colors.black,
//                             size: 25,
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 15,
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         children: [
//                           Icon(
//                             Icons.star,
//                             color: Colors.yellow,
//                             size: 20,
//                           ),
//                           SizedBox(width: 2),
//                           Text(
//                             "5 (100 rating)",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(width: 120),
//                           Expanded(
//                             child: Text(
//                               "SEE REVIEW",
//                               style: TextStyle(
//                                 color: Colors.purple,
//                                 fontSize: 15,
//                                 //fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(
//                         top: 15,
//                         left: 20,
//                         right: 20,
//                       ),
//                       child: Row(
//                         children: [
//                           Text(
//                             "Choose Color",
//                             style: TextStyle(
//                                 color: Colors.black,
//                                 fontSize: 15,
//                                 fontWeight: FontWeight.bold),
//                           ),
//                           SizedBox(width: 120),
//                           Expanded(
//                             child: Text(
//                               "SEE REVIEW",
//                               style: TextStyle(
//                                 color: Colors.purple,
//                                 fontSize: 15,
//                                 //fontWeight: FontWeight.bold
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ]),
//             ),
//           )
//         ],
//       ),