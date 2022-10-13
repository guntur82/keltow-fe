import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_project/LoginRegister/HomePage_log_res.dart';
import 'package:flutter_project/LoginRegister/Login_page.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/view/DetailProfil.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("Profile"),
          backgroundColor: Colors.lightBlueAccent,
        ),
        body: Container(
          padding: EdgeInsets.only(
            top: 5,
          ),
          margin: EdgeInsets.only(left: 10, right: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Ink(
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        margin: EdgeInsets.zero,
                        width: 60,
                        height: 100,
                        decoration: BoxDecoration(
                          border: Border.all(width: 2, color: Colors.white),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: NetworkImage(user.gambar == null
                                ? uriGambar + user.gambar
                                : 'https://cdn.pixabay.com/photo/2014/04/12/14/59/portrait-322470__340.jpg'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Text(
                          user.name,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 50,
                      ),
                      Container(
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              minimumSize: const Size(60, 50),
                              maximumSize: const Size(60, 50),
                              primary: Colors.grey,
                              onSurface: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProfil()));
                            },
                            child: Text("  >  ",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20))),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 400,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          minimumSize: const Size(142, 55),
                          primary: Colors.blue,
                          side:
                              BorderSide(width: 1.5, color: Colors.blueAccent),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Login()));
                      },
                      child: Text("LOGOUT"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ));
  }
}
