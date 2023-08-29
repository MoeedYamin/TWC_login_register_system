import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


import 'main.dart';

class forget extends StatefulWidget {
  const forget({Key? key}) : super(key: key);

  @override
  State<forget> createState() => _forgetState();
}

class _forgetState extends State<forget> {
  bool loader = false;
  bool error = false;
  String errorMessage = "";
  TextEditingController forgot = TextEditingController();
  var _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (!connected) {
      errorTopinternet("No internet connection found.");
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(children: [
        SingleChildScrollView(
          child:
          Column(
            children: [

              // Padding(
              //   padding: const EdgeInsets.only(top: 100),
              //   child: Container(
              //     alignment: Alignment.center,
              //     child: SizedBox(
              //         width: double.infinity,
              //         height: 150,
              //         child:
              //         Image.asset("assets/images/logo-1.png")
              //     ),
              //   ),
              // ),
              Padding(
                padding: const EdgeInsets.only(top: 100),
                child: Container(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding:
                    const EdgeInsets.only(top: 22, bottom: 0, left: 10),
                    child: Text(
                      "Forgot Password?",
                      style: TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 10.0, top: 4, bottom: 8),
                child: Text(
                  'Please enter your email address. You will receive an email message with instructions on how to reset your password.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
              ),
              Padding(
                padding:
                const EdgeInsets.only(left: 10, right: 10, top: 15),
                child: TextField(
                  onChanged: (v) {
                    setState(() {});
                  },
                  cursorColor: Colors.black,
                  controller: forgot,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11)),
                    labelText: 'Enter email address',
                    labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    // hintText: "Enter Your E-mail",
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.grey,
                    ),
                    hintStyle: TextStyle(fontSize: 20),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(11),
                    ),
                  ),
                ),
              ),
              (loader)
                  ? const Padding(
                padding: EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 45),
                child: Center(child: CircularProgressIndicator()),
              )
                  : Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 30, right: 30, bottom: 45),
                child: InkWell(
                  onTap: () async {
                    if (forgot.text.isNotEmpty) {
                      if (isEmail(forgot.text)) {
                        forgot.clear();
                        setState(() {
                          loader = true;
                        });
                        var logResponse =
                        await forgetUser(forgot.text)
                            .catchError((value) {
                          setState(() {
                            loader = false;
                          });
                          errorTop( value.toString(),
                          );
                        });
                        setState(() {
                          loader = false;
                        });
                        var response = jsonDecode(logResponse.body);
                        var response1 = jsonDecode(response);
                        print(response1);
                        // errorTop( response1["message"]);
                        showCustom(context);
                      } else {
                        errorTop( "Please enter valid email");
                      }

                    } else {
                      // errorTop( "Please enter Email");
                    }
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: (forgot.text.isNotEmpty)
                          ? const Color.fromRGBO(100, 149, 237, 1)
                          : Colors.grey,
                      border: Border.all(
                          color: Colors.transparent, width: 2),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Send Email",
                        style: TextStyle(
                            fontSize: 21,
                            color: Colors.white,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),

        ),
        (error)
            ? Padding(
          padding:  EdgeInsets.only(top:MediaQuery.of(context).padding.top),
          child: Container(
            height: 50,
            decoration: BoxDecoration(color: Colors.red),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error,
                  color: Colors.white,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    "$errorMessage",
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        )
            : SizedBox(),
      ],),


    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  bool isPassword(String em) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<http.Response> forgetUser(String body) {
    return http.get(
      Uri.parse(
          "https://twcargo.com/wp-json/wp/v2/twc-forgot-password?email=$body"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
  }

  errorTop(String message) async {
    setState(() {
      error = true;
      errorMessage = message;
    });
    await Future.delayed(const Duration(seconds: 5));
    setState(() {
      error = false;
    });
  }

  errorTopinternet(String message) async {
    setState(() {
      error = true;
      errorMessage = message;
    });
    await Future.delayed(const Duration(seconds: 2));
    setState(() {
      error = false;
    });
  }

  showCustom(BuildContext context) {
    FToast fToast = FToast();
    fToast.init(context);
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.green,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: const [
          Icon(
            Icons.check,
            color: Colors.white,
          ),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Password reset link send to your email address',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
    fToast.showToast(
      child: toast,
      toastDuration: const Duration(seconds: 5),
      gravity: ToastGravity.BOTTOM,
    );
  }

}
