// import 'dart:convert';
// import 'dart:math';
//
// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:http/http.dart' as http;
// import 'package:transworld_cargo_app/Splash.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:webview_flutter_android/webview_flutter_android.dart';
// import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
//
// import 'main.dart';
//
//
// class MyMainPageregister extends StatefulWidget {
//   String url;
//   String name;
//
//   MyMainPageregister({super.key, required this.url, required this.name});
//
//   @override
//   State<MyMainPageregister> createState() => _MyMainPageState();
// }
//
// class _MyMainPageState extends State<MyMainPageregister> {
//   late WebViewController controller;
//   bool isLoading = true;
//
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//
//     controller = WebViewController();
//
//     final WebViewWidget webViewWidget = WebViewWidget(controller: controller);
//
//     if (WebViewPlatform.instance is WebKitWebViewPlatform) {
//       final WebKitWebViewWidget webKitWidget =
//       webViewWidget.platform as WebKitWebViewWidget;
//     } else if (WebViewPlatform.instance is AndroidWebViewPlatform) {
//       final AndroidWebViewWidget androidWidget =
//       webViewWidget.platform as AndroidWebViewWidget;
//     }
//     controller = WebViewController()
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             // Update loading bar.
//           },
//           onPageStarted: (String url) {
//             // setState(() {
//             //   isLoading = true;
//             // });
//           },
//           onPageFinished: (String url) {
//             print("url is $url");
//             setState(() {
//               isLoading = false;
//             });
//             // controller.reload();
//           },
//           onWebResourceError: (WebResourceError error) {},
//         ),
//       )
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..loadRequest(Uri.parse(widget.url));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Welcome ${widget.name}'),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return AlertDialog(
//                         shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(Radius.circular(6.0))),
//                         title: Text('Are you sure you want to logout?',style: TextStyle(fontSize: 22)),
//                         // content: Text('We hate to see you leave'),
//                         actions: <Widget>[
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                             },
//                             child: Text('No',style: TextStyle(fontSize: 17)),
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               Navigator.of(context).pop();
//                               Logout();
//                             },
//                             child: Text('Yes',style: TextStyle(fontSize: 17)),
//                           ),
//                         ],
//                       );
//                     });
//               },
//               icon: Icon(Icons.logout))
//         ],
//       ),
//       body: Container(
//         color: Colors.black,
//         child: SafeArea(
//           child: Stack(
//             children: <Widget>[
//               WebViewWidget(
//                 controller: controller,
//               ),
//               isLoading
//                   ? Center(
//                 child: CircularProgressIndicator(),
//               )
//                   : Stack(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Future<http.Response> logoutUser(var user, var token) {
//     return http.get(
//       Uri.parse(
//           "https://twcargo.com/wp-json/wp/v2/twc-logout?user_id=$user&login_token=$token"),
//       headers: <String, String>{
//         'Content-Type': 'application/json; charset=UTF-8',
//       },
//       // body: body,
//     );
//   }
//
//   Logout() async {
//     showDialog(
//       // The user CANNOT close this dialog  by pressing outsite it
//         barrierDismissible: false,
//         context: context,
//         builder: (_) {
//           return Dialog(
//             // The background color
//             backgroundColor: Colors.white,
//             child: Padding(
//               padding: const EdgeInsets.symmetric(vertical: 20),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: const [
//                   // The loading indicator
//                   CircularProgressIndicator(),
//                   SizedBox(
//                     height: 15,
//                   ),
//                   // Some text
//                   Text('Logging Out...')
//                 ],
//               ),
//             ),
//           );
//         });
//     var logResponse =
//     await logoutUser(prefs.getInt("id"), prefs.getString("token"))
//         .catchError((value) {
//       Fluttertoast.showToast(
//         msg: value.toString(),
//       );
//     });
//     Navigator.pop(context);
//     var response = jsonDecode(logResponse.body);
//     var response1 = jsonDecode(response);
//     print(response1);
//     print(response1["status"]);
//     Fluttertoast.showToast(
//       msg: response1["status"],
//     );
//     if (response1["status"] == "logout_successful") {
//       prefs.setBool("Login", false);
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> Splash()));
//     }
//   }
// }
