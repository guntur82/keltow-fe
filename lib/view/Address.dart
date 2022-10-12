import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pay/pay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/features/widgets/cart_subtotal.dart';
import 'package:flutter_project/features/widgets/custom_button.dart';
import 'package:flutter_project/models/cart.dart';
import 'package:flutter_project/models/product.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  final String totalAmount;
  const AddressScreen({Key? key, required this.totalAmount}) : super(key: key);
  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  String addressToBeUsed = "";
  List<Product>? products;
  List<Cart>? cart;
  final AuthService authService = AuthService();
  final ProductService productService = ProductService();

  List<PaymentItem> paymentItems = [];
  @override
  void initState() {
    super.initState();
    paymentItems.add(PaymentItem(
        amount: widget.totalAmount,
        label: 'Total biaya',
        status: PaymentItemStatus.final_price));
    fetchCartList();
    fetchAllProduct();
  }

  fetchCartList() async {
    cart = await productService.fetchCartList(context);
    setState(() {});
  }

  fetchAllProduct() async {
    products = await authService.fetchAllProducts(context);
    setState(() {});
  }

  void onGooglePayResult(res) {}
  void payPressed(String addressFromProvider) {
    addressToBeUsed = "";

    bool isForm = addressFromProvider.isNotEmpty;

    if (isForm) {
      addressToBeUsed = addressFromProvider;
    } else {
      Fluttertoast.showToast(msg: 'ERROR', toastLength: Toast.LENGTH_LONG);
    }
    print(addressToBeUsed);
  }

  @override
  Widget build(BuildContext context) {
    int countItem = 0;
    int sum = 0;
    int count = 0;
    if (products != null && cart != null) {
      for (int i = 0; i < jsonDecode(jsonEncode(products)).length; i++) {
        var dataProduct = jsonDecode(jsonEncode(products));
        for (int j = 0; j < jsonDecode(jsonEncode(cart)).length; j++) {
          var dataCart = jsonDecode(jsonEncode(cart));
          if (Product.fromJson(dataProduct[i]).id ==
              Cart.fromJson(dataCart[j]).itemId) {
            count++;
            countItem += Cart.fromJson(dataCart[j]).jumlah;
            sum += Product.fromJson(dataProduct[i]).harga.toInt() *
                Cart.fromJson(dataCart[j]).jumlah;
          }
        }
      }
    }
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.name,
                style: const TextStyle(
                  fontSize: 25,
                  color: Colors.blue,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.no_hp,
                style: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          Container(
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                user.alamat,
                style: const TextStyle(
                  fontSize: 15,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.black12,
              ),
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
      bottomNavigationBar: SizedBox(
        height: MediaQuery.of(context).size.height * 0.2,
        child: Column(
          children: [
            Divider(
              thickness: 1,
            ),
            CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GooglePayButton(
                onPressed: () => payPressed(user.alamat),
                paymentConfigurationAsset: 'gpay.json',
                width: double.infinity,
                paymentItems: paymentItems,
                type: GooglePayButtonType.pay,
                // margin: const EdgeInsets.only(top: 10.0),
                onPaymentResult: onGooglePayResult,
                loadingIndicator: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              //   CustomButton(
              // text: 'Bayar',
              // onTap: () {},
              // color: Colors.blue[600],
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
