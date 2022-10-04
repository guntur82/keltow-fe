import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
