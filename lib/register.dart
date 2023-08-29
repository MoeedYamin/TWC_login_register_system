import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transworld_cargo_app/login.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';


import 'main.dart';
import 'mainpage.dart';

class Myregister extends StatefulWidget {
  const Myregister({super.key});

  @override
  State<Myregister> createState() => _MyregisterState();
}


class _MyregisterState extends State<Myregister> {
  bool invisible = false;
  bool show = false;
  bool loader = false;
  TextEditingController user = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController fName = TextEditingController();
  TextEditingController lName = TextEditingController();
  TextEditingController phNumber = TextEditingController();
  TextEditingController comName = TextEditingController();
  TextEditingController address = TextEditingController();
  TextEditingController password = TextEditingController();
  bool error = false;
  String errorMessage = "";

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
      body:
    // SafeArea(
    //     child:
        Stack(children: [
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
                //         child: Image.asset("assets/images/logo-1.png")),
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
                        "Create Account",
                        style:
                        TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[a-z,_,0-9]")),
                    ],
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: user,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Username',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: email,
                    onChanged: (v) {
                      setState(() {});
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Email',
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
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    cursorColor: Colors.black,
                    controller: fName,
                    onChanged: (v) {
                      setState(() {});
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'First Name',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: lName,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Last Name',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.person_pin,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    keyboardType: TextInputType.phone,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.allow(RegExp("[+0-9]")),
                    ],
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: phNumber,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Phone No.',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.phone,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: comName,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Company Name',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.location_city,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextField(
                    cursorColor: Colors.black,
                    onChanged: (v) {
                      setState(() {});
                    },
                    controller: address,
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(11)),
                      labelText: 'Address',
                      labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                      fillColor: Colors.grey.shade100,
                      filled: true,
                      prefixIcon: Icon(
                        Icons.location_on,
                        color: Colors.grey,
                      ),
                      hintStyle: TextStyle(fontSize: 20),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(11),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: TextFormField(
                    obscureText: !invisible,
                    cursorColor: Colors.black,
                    controller: password,
                    onChanged: (v) {
                      setState(() {});
                    },
                    style: TextStyle(color: Colors.black),
                    decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11)),
                        labelText: 'Password',
                        errorText:
                        ('Must contain 8 digits.1 uppercase, 1 number, 1 special symbol'),
                        errorBorder: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.black, width: 1.0),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        focusedErrorBorder: new OutlineInputBorder(
                          borderSide:
                          new BorderSide(color: Colors.blue, width: 2.0),
                          borderRadius: BorderRadius.circular(11),
                        ),
                        errorStyle: TextStyle(color: Colors.grey,fontSize: 11),
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        prefixIcon: Icon(
                          Icons.lock,
                          color: Colors.grey,
                        ),
                        suffixIcon: GestureDetector(
                            onTap: () {
                              if (invisible == true) {
                                setState(() {
                                  invisible = false;
                                });
                              } else {
                                setState(() {
                                  invisible = true;
                                });
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Icon(
                                Icons.remove_red_eye_outlined,
                                color: Colors.grey,
                                size: 28,
                              ),
                            )),
                        hintStyle: TextStyle(fontSize: 20),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11),
                            borderSide: BorderSide(color: Colors.black))),
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
                      if (user.text.isNotEmpty &&
                          email.text.isNotEmpty &&
                          fName.text.isNotEmpty &&
                          lName.text.isNotEmpty &&
                          phNumber.text.isNotEmpty &&
                          comName.text.isNotEmpty &&
                          address.text.isNotEmpty &&
                          password.text.isNotEmpty) {
                        if (isEmail(email.text)) {
                          if (isPassword(password.text)) {
                            setState(() {
                              loader = true;
                            });
                            var regResponse = await registerUser(
                                jsonEncode(<String, String>{
                                  "username": user.text,
                                  "email": email.text,
                                  "first_name": fName.text,
                                  "last_name": lName.text,
                                  "phone": phNumber.text,
                                  "company": comName.text,
                                  "address": address.text,
                                  "password": password.text,
                                })).catchError((message) {
                              setState(() {
                                loader = false;
                              });
                              errorTop( message.toString(),
                              );
                            });
                            setState(() {
                              loader = false;
                            });
                            print(regResponse.body);
                            var response = jsonDecode(regResponse.body);
                            var response1 = jsonDecode(response);
                            print(response1);
                            print(response1["status"]);
                            if (response1.containsKey("message"))
                              errorTop(response1["message"]);
                            print("abc");
                            // else
                            //   errorTop(response1["status"]);

                            if (response1["status"] == "registered") {
                              Navigator.pop(context);
                              // print('done');
                              // prefs.setBool("Login", true);
                              // prefs.setString(
                              //     "URL", response1["inquiry_url"]);
                              // prefs.setString("name",
                              //     response1["user_data"]["first_name"]);
                              // prefs.setString("username",user.text);
                              // prefs.setInt(
                              //     "id", response1["user_data"]["id"]);
                              // prefs.setString(
                              //     "token", response1["login_token"]);
                              // Navigator.pushReplacement(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => MyMainPage(
                              //           url: response1["inquiry_url"],
                              //           name: response1["user_data"]
                              //           ["first_name"],
                              //         )));
                              // Fluttertoast.showToast(
                              //     msg: "Registration completed. Please login to your account",
                              //     toastLength: Toast.LENGTH_SHORT,
                              //     gravity: ToastGravity.CENTER,
                              //     timeInSecForIosWeb: 3,
                              //     backgroundColor: Colors.greenAccent,
                              //     textColor: Colors.white,
                              //     fontSize: 16.0
                              // );
                              showCustom(context);


                            }
                            // print(response["status"]);
                          } else {
                            // password format
                            errorTop( "Password is not strong");
                          }
                        } else {
                          errorTop( "Please enter valid email",
                          );
                        }
                      } else {
                        return;
                      }
                    },
                    child: Container(
                      alignment: Alignment.center,
                      width: 200,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: (user.text.isNotEmpty &&
                            email.text.isNotEmpty &&
                            fName.text.isNotEmpty &&
                            lName.text.isNotEmpty &&
                            phNumber.text.isNotEmpty &&
                            comName.text.isNotEmpty &&
                            address.text.isNotEmpty &&
                            password.text.isNotEmpty)
                            ? Color.fromRGBO(100, 149, 237, 1)
                            : Colors.grey,
                        border: Border.all(
                            color: Colors.transparent, width: 2),
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
                          "Register",
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
            : SizedBox(),],)
      // ),
    );
  }

  Future<http.Response> registerUser(var body) {
    return http.post(
      Uri.parse("https://twcargo.com/wp-json/wp/v2/twc-register"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body,
    );
  }

  bool isEmail(String em) {
    String p =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  bool isPassword(String em) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~%^()-_|<>.,+=;:]).{8,}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  errorTop(String message) async {
    setState(() {
      error = true;
      errorMessage = message;
    });
    await Future.delayed(const Duration(seconds: 300));
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
              'Registration completed. Please login to your account.',
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

}
