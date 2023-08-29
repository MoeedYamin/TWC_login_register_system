import 'package:flutter/material.dart';
import 'package:transworld_cargo_app/login.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';
import 'Splash.dart';
import 'mainpage.dart';
late SharedPreferences prefs;
bool connected=false;

void main() {

  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: 'login',
    routes: {
      // 'login':(context)=>MyMainPage()
      // 'login':(context)=>Mylogin()
      'login':(context)=>Splash()
    },
  ));
}
void checkConnectivity() {
  Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
    if (result == ConnectivityResult.none) {
      // No internet connection
      print("No internet connection.");
      connected=false;
      // Handle the absence of internet connection here.
    } else if (result == ConnectivityResult.mobile || result == ConnectivityResult.wifi) {
      // Connected to either mobile data or Wi-Fi
      print("Connected to the internet.");
      connected=true;
      // Handle internet connectivity here.
    }
  });
}


