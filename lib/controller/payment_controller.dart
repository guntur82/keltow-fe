import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_project/features/services/product_service.dart';
import 'package:flutter_project/view/NavigasiBar.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class PaymentController extends GetxController {
  Map<String, dynamic>? paymentIntentData;
  final ProductService productService = ProductService();

  Future<void> makePayment({
    required BuildContext context,
    required String amount,
    required String currency,
    required List listItem,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              // applePay: true,
              // googlePay: true,
              // testEnv: true,
              // merchantCountryCode: 'US',
              applePay: const PaymentSheetApplePay(
                merchantCountryCode: '+62',
              ),
              googlePay: const PaymentSheetGooglePay(
                testEnv: true,
                merchantCountryCode: '+62',
              ),
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ))
            .then((value) {});
        // ));
        displayPaymentSheet(context: context, listItem: listItem);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  Future<void> makePaymentNow({
    required BuildContext context,
    required String amount,
    required String currency,
    required List listItem,
    required int jumlahTotal,
  }) async {
    try {
      paymentIntentData = await createPaymentIntent(amount, currency);
      if (paymentIntentData != null) {
        await Stripe.instance
            .initPaymentSheet(
                paymentSheetParameters: SetupPaymentSheetParameters(
              // applePay: true,
              // googlePay: true,
              // testEnv: true,
              // merchantCountryCode: 'US',
              applePay: const PaymentSheetApplePay(
                merchantCountryCode: '+62',
              ),
              googlePay: const PaymentSheetGooglePay(
                testEnv: true,
                merchantCountryCode: '+62',
              ),
              paymentIntentClientSecret: paymentIntentData!['client_secret'],
              merchantDisplayName: 'Prospects',
              customerId: paymentIntentData!['customer'],
              customerEphemeralKeySecret: paymentIntentData!['ephemeralKey'],
            ))
            .then((value) {});
        // ));
        displayPaymentSheetNow(
            context: context, listItem: listItem, jumlah: jumlahTotal);
      }
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(
      {required BuildContext context, required List listItem}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      productService.transaction(
        context: context,
        itemId: listItem,
        status_barang: 1,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  displayPaymentSheetNow(
      {required BuildContext context,
      required List listItem,
      required int jumlah}) async {
    try {
      await Stripe.instance.presentPaymentSheet();
      Get.snackbar('Payment', 'Payment Successful',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
          margin: const EdgeInsets.all(10),
          duration: const Duration(seconds: 2));
      productService.transactionNow(
        context: context,
        itemId: listItem,
        status_barang: 1,
        jumlah: jumlah,
      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => BottomNavigationScreen()));
    } on Exception catch (e) {
      if (e is StripeException) {
        print("Error from Stripe: ${e.error.localizedMessage}");
      } else {
        print("Unforeseen error: ${e}");
      }
    } catch (e) {
      print("exception:$e");
    }
  }

  //  Future<Map<String, dynamic>>
  createPaymentIntent(String amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': calculateAmount(amount),
        'currency': currency,
        'payment_method_types[]': 'card'
      };
      var response = await http.post(
          Uri.parse('https://api.stripe.com/v1/payment_intents'),
          body: body,
          headers: {
            'Authorization':
                'Bearer sk_test_51LsL4zEkTGFSMNV4kU8346msy8CJhs6uTmCUJEc5J149NgNTwkabfjdUWFgM1aGjsaytgq2Ukal0EY7dfjvwp3LP00nkH2qqCU',
            'Content-Type': 'application/x-www-form-urlencoded'
          });
      return jsonDecode(response.body);
    } catch (err) {
      print('err charging user: ${err.toString()}');
    }
  }

  calculateAmount(String amount) {
    final a = (int.parse(amount)) * 100;
    return a.toString();
  }
}
