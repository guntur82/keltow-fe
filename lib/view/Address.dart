import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:provider/provider.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/constants/global_variables.dart';

class AddressScreen extends StatefulWidget {
  static const String routeName = '/address';
  const AddressScreen({Key? key}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlueAccent,
      ),
    );
  }
}
