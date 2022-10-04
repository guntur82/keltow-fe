// import 'package:flutter/material.dart';
// import 'package:flutter_project/Model/ModelGetUser.dart';

// import '../Service/RegisterApi.dart';
// import '../Service/Sharedpref.dart';

// class RegisterViewModel extends ChangeNotifier{
//   final registerApi = RegisterApi();
//   final sharedPref = SharedPreferenceService();
//   ModelGetUser dataLogin = new ModelGetUser();

//   RegisterViewModel(BuildContext){}

//   void register(String name, String email,String password, String no_hp, 
//       String level, String alamat, BuildContext context) async{
//     final response = await registerApi.register(name, email, password, no_hp, level, alamat, context);
//     if (response == null){
//       dataLogin = response.data as ModelGetUser;
//         sharedPref.setStringSharedPref("token", dataLogin.token.toString());
//         sharedPref.setStringSharedPref("petani_id", dataLogin.detail!.petaniId.toString());
//         sharedPref.setStringSharedPref("user_id", dataLogin.userId.toString());
//         print(jsonEncode(dataLogin));
//     }else{
//       print(response.error.toString());
//     }
//     notifyListeners();
//   }