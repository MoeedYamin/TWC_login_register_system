import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:transworld_cargo_app/main.dart';
import 'package:transworld_cargo_app/register.dart';
import 'package:http/http.dart' as http;
import 'forget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'mainpage.dart';

class Mylogin extends StatefulWidget {
  const Mylogin({super.key});

  @override
  State<Mylogin> createState() => _MyloginState();
}

class _MyloginState extends State<Mylogin> {
  bool invisible = false;
  bool loader = false;
  bool error = false;
  String errorMessage = "";
  TextEditingController user = TextEditingController();
  TextEditingController password = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (prefs.getString("username") != null) {
      user.text = prefs.getString("username")!;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!connected) {
      errorTopinternet("No internet connection found.");
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(245, 245, 245, 1),
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 50),
                    child: Container(
                      alignment: Alignment.center,
                      child: SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Image.asset("assets/images/logo-1.png")),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 0, left: 10),
                      child: Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 15),
                    child: TextField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp("[a-z,_,0-9]")),
                      ],
                      controller: user,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(11)),
                        labelText: 'Username',
                        labelStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        fillColor: Colors.grey.shade100,
                        filled: true,
                        // hintText: "Enter Your E-mail",
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
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, top: 20),
                    child: TextFormField(
                      onChanged: (v) {
                        setState(() {});
                      },
                      controller: password,
                      obscureText: !invisible,
                      cursorColor: Colors.black,
                      style: TextStyle(color: Colors.black),
                      decoration: InputDecoration(
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(11)),
                          labelText: 'Password',
                          labelStyle:
                              TextStyle(color: Colors.grey, fontSize: 18),
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
                              // onTapCancel: ()
                              // {
                              //   setState(() {
                              //     invisible=true;
                              //   });
                              // },
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
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Container(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => forget()),
                          );
                        },
                        child: Text(
                          'Lost Your Password?',
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      ),
                    ),
                  ),
                  (loader)
                      ? const Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 30, right: 30),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 30, right: 30),
                          child: InkWell(
                            onTap: () async {
                              if (user.text.isNotEmpty &&
                                  password.text.isNotEmpty) {
                                // if(isPassword(password.text))
                                //   {
                                setState(() {
                                  loader = true;
                                });
                                var logResponse =
                                    await loginUser(user.text, password.text)
                                        .catchError((value) {
                                  setState(() {
                                    loader = false;
                                  });
                                  errorTop(value.toString());
                                });
                                setState(() {
                                  loader = false;
                                });
                                var response = jsonDecode(logResponse.body);
                                var response1 = jsonDecode(response);
                                print(response1);
                                print(response1["status"]);
                                if (response1.containsKey("message")) {
                                  errorTop(response1["message"]);
                                } else {
                                  // errorTop(response1["status"]);
                                }
                                // clear();
                                if (response1["status"] == "approved") {
                                  prefs.setBool("Login", true);
                                  prefs.setString(
                                      "URL", response1["inquiry_url"]);
                                  prefs.setString("name",
                                      response1["user_data"]["first_name"]);
                                  prefs.setString("username",
                                      response1["user_data"]["username"]);
                                  prefs.setInt(
                                      "id", response1["user_data"]["id"]);
                                  prefs.setString(
                                      "token", response1["login_token"]);
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => MyMainPage(
                                                url: response1["inquiry_url"],
                                                name: response1["user_data"]
                                                    ["first_name"],
                                              )));
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
                                        password.text.isNotEmpty)
                                    ? const Color.fromRGBO(100, 149, 237, 1)
                                    : Colors.grey,
                                border: Border.all(
                                    color: Colors.transparent, width: 2),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                          ),
                        ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, top: 10, right: 10),
                    child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          "Or",
                          style: TextStyle(fontSize: 21, color: Colors.grey),
                        )),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 10, left: 30, right: 30),
                    child: InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Myregister()),
                        );
                      },
                      child: Container(
                        alignment: Alignment.center,
                        width: 200,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          color: Colors.transparent,
                          border: Border.all(
                              color: Color.fromRGBO(100, 149, 237, 1),
                              width: 2),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Create an account",
                            style: TextStyle(
                                fontSize: 21,
                                color: Color.fromRGBO(100, 149, 237, 1)),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            (error)
                ? Container(
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
                  )
                : SizedBox(),
          ],
        ),
      ),
    );
  }

  bool isPassword(String em) {
    String p = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!?@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  Future<http.Response> loginUser(var user, var password) {
    return http.get(
      Uri.parse(
          "https://twcargo.com/wp-json/wp/v2/twc-login?username=$user&password=$password"),
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
    await Future.delayed(const Duration(seconds: 300));
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
}
