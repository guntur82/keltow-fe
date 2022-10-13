import 'dart:ui';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:flutter_project/constants/global_variables.dart';
import 'package:flutter_project/constants/ultils.dart';
import 'package:flutter_project/features/services/auth_service.dart';
import 'package:flutter_project/providers/user_provider.dart';
import 'package:flutter_project/view/Profil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

class DetailProfil extends StatefulWidget {
  // const DetailProfil({super.key});
  const DetailProfil({Key? key}) : super(key: key);

  @override
  State<DetailProfil> createState() => _DetailProfilState();
}

class _DetailProfilState extends State<DetailProfil> {
  final AuthService authService = AuthService();
  String? textControllerId;
  String? textControllerEmail;
  final TextEditingController textControllerNama = TextEditingController();
  final TextEditingController textControllerNomorHP = TextEditingController();
  final TextEditingController textControllerAlamat = TextEditingController();
  final TextEditingController textControllerPassword = TextEditingController();
  final TextEditingController textControllerConfirmPassword =
      TextEditingController();
  bool showPasswords = true;
  // upload
  // List<File> images = [];
  File? images;
  // end upload
  void update() {
    if (textControllerNama.text.isNotEmpty &&
        textControllerNomorHP.text.isNotEmpty) {
      if (textControllerPassword.text.isNotEmpty) {
        if (textControllerPassword.text != textControllerConfirmPassword.text) {
          showSnackBar(context, "password tidak sama!");
        } else {
          submit();
        }
      } else {
        submit();
      }
    } else {
      Fluttertoast.showToast(
          msg: 'Harap isi semua data dengan lengkap!',
          toastLength: Toast.LENGTH_LONG);
    }
  }

  void submit() {
    // print("nama = " + textControllerNama.text);
    // print("passowrd = " + textControllerPassword.text);
    // print("confirm passowrd = " + textControllerPassword.text);
    // print("no hp = " + textControllerNomorHP.text);
    // print("alamat = " + textControllerAlamat.text);
    // print(textControllerPassword.text == ''
    //     ? 'kosong'
    //     : textControllerPassword.text);
    authService.update(
      context: context,
      userId: textControllerId.toString(),
      email: textControllerEmail.toString(),
      password: textControllerPassword.text == ''
          ? 'kosong'
          : textControllerPassword.text,
      name: textControllerNama.text,
      phone: textControllerNomorHP.text,
      address: textControllerAlamat.text,
      images: images,
    );
    // Navigator.push(context, MaterialPageRoute(builder: (context) => Profile()));
  }

  // void selectImages() async {
  //   var res = await pickImages();
  //   setState(() {
  //     images = res;
  //   });
  // }

  void selectImages() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['jpg', 'png', 'jpeg'],
    );
    if (result != null) {
      // file = File(result.files.single.path.toString());
      // print('file');
      // print(file); //use
      // PlatformFile data = result.files.first;

      // print('data');
      // print(data.name); //use
      // print(data.bytes);
      // print(data.size);
      // print(data.extension);
      // print(data.path); //use
      setState(() {
        images = File(result.files.single.path.toString());
      });
    } else {
      // User canceled the picker
      print('gagal');
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    textControllerId = user.id;
    textControllerEmail = user.email;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profil",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      backgroundColor: Colors.blue[100],
      body: Container(
        padding: EdgeInsets.only(
          left: 16,
          right: 16,
          top: 25,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text("Edit Profil",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                      color: Colors.black)),
              SizedBox(height: 20),
              Center(
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: selectImages,
                      child: Container(
                        width: 120,
                        height: 130,
                        decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            // image: AssetImage("assets/nokia.jfif"),
                            image: NetworkImage(user.gambar == null
                                ? uriGambar + user.gambar
                                : 'https://cdn.pixabay.com/photo/2014/04/12/14/59/portrait-322470__340.jpg'),
                          ),
                          boxShadow: [
                            BoxShadow(
                              spreadRadius: 2,
                              blurRadius: 10,
                              color: Colors.black.withOpacity(0.1),
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          height: 40,
                          width: 40,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                                width: 4,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            color: Colors.green,
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ))
                  ],
                ),
              ),
              SizedBox(height: 20),
              Form(
                child: Container(
                  child: Column(
                    children: [
                      buildTextFielfd(
                          "Nama", user.name, false, textControllerNama),
                      buildTextFielfd(
                          "Password", "", true, textControllerPassword),
                      buildTextFielfd("Confirm Password", "", true,
                          textControllerConfirmPassword),
                      buildTextFielfd(
                          "No Hp", user.no_hp, false, textControllerNomorHP),
                      buildTextFielfd(
                          "Alamat", user.alamat, false, textControllerAlamat),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(120, 40),
                        primary: Colors.green,
                        side: BorderSide(width: 1.5, color: Colors.grey),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5))),
                    onPressed: () {
                      update();
                    },
                    child: Text(
                      "SAVE",
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextFielfd(String labelText, String? placeholder,
      bool isPasswordTextField, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15),
      child: TextFormField(
        controller: controller..text = placeholder.toString(),
        // initialValue: 'test',
        obscureText: isPasswordTextField ? showPasswords : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPasswords = !showPasswords;
                    });
                  },
                  icon: Icon(Icons.remove_red_eye, color: Colors.grey))
              : null,
          contentPadding: EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          // hintText: labelText,
          hintStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        onChanged: (text) => {},
      ),
    );
  }
}
