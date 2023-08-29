import 'dart:io';

import 'package:flutter/material.dart';
import 'package:transworld_cargo_app/login.dart';
import 'package:transworld_cargo_app/main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity/connectivity.dart';


import 'mainpage.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  final Connectivity _connectivity = Connectivity();
  bool _isConnected = true;


  bool load=true;
  bool login=true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkConnectivity();
     _checkInternetConnectivity();
    getShare();
  }

  Future<void> _checkInternetConnectivity() async {
    var connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      setState(() {
        _isConnected = false;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    if (!_isConnected) {
      // If there's no internet, show an error message and close the app.
      return Scaffold(
        backgroundColor: Color.fromRGBO(245, 245, 245, 1),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 10.0),
                    child: Icon(Icons.signal_cellular_connected_no_internet_0_bar_sharp,size: 30),
                  ),

                  Text(
                    'Internet not available!',
                    style: TextStyle(fontSize: 24),
                  ),
                ],
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () => exit(0),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Exit',style: TextStyle(fontSize: 20),),
                ),

              ),
            ],
          ),
        ),

      );
    }
    else
      {
        return  Scaffold(
          body: (load)?Center(child: CircularProgressIndicator()):Center(child:(login)? Mylogin():MyMainPage(url: prefs.getString("URL")!,name: prefs.getString("name")!,)),
        );
      }

  }

  Future<void> getShare() async {

    prefs=await SharedPreferences.getInstance();
    if(prefs.getBool("Login")!=null)
    {
      if(prefs.getBool("Login")!)
      {
        login=false;
      }
    }
    setState(() {
      load=false;
    });
  }


}



