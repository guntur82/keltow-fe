import 'package:flutter/material.dart';
import 'package:flutter_project/view/Home.dart';
import 'package:flutter_project/view/Profil.dart';
import 'package:flutter_project/view/Transaksi.dart';
import 'package:flutter_project/view/whislist.dart';

class BottomNavigationScreen extends StatefulWidget {
  static const String routeName = '/actual-home';
  const BottomNavigationScreen({Key? key}) : super(key: key);

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedNavbar = 0;
  final List _widgetOption = [
    const HomePage(),
    const Transaksi(),
    const Whislist(),
    const Profile(),
  ];
  void _changeSelectedNavBar(int index) {
    setState(() {
      _selectedNavbar = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOption.elementAt(_selectedNavbar),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Beranda',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_balance_wallet),
            label: 'Transaksi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Whislist',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Akun')
        ],
        currentIndex: _selectedNavbar,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.black,
        showUnselectedLabels: true,
        onTap: _changeSelectedNavBar,
      ),
    );
  }
}
