import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mnctest/Auth/forgotPassword.dart';
// import 'package:flutter/services.dart';
import 'package:mnctest/Auth/signup.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/constant/utils/authbio.dart';
import 'package:mnctest/screens/home.dart';
import 'package:mnctest/services/Api/apiClient.dart';
import 'package:mnctest/widgets/Button.dart';
import 'package:mnctest/widgets/background_design.dart';
import 'package:mnctest/widgets/textButton.dart';
import 'package:mnctest/widgets/textfield.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  ConnectivityResult _connectionStatus = ConnectivityResult.none;
  final Connectivity _connectivity = Connectivity();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;

  Future<void> initConnectivity() async {
    late ConnectivityResult result;

    try {
      result = await _connectivity.checkConnectivity();
    } on Exception catch (e) {
      print(e);
      return;
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) {
      return Future.value(null);
    }
  }

  // Future _updateConnectionStatus(result) async {
  //   setState(() {
  //     if (_connectionStatus == ConnectivityResult.mobile ||
  //         _connectionStatus == ConnectivityResult.wifi) {
  //       Fluttertoast.showToast(
  //           msg: "Connection Status: ${_connectionStatus.toString()}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 4,
  //           backgroundColor: Colors.green,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //     if (_connectionStatus == ConnectivityResult.none) {
  //       Fluttertoast.showToast(
  //           msg: "Connection Status: ${_connectionStatus.toString()}",
  //           toastLength: Toast.LENGTH_SHORT,
  //           gravity: ToastGravity.TOP,
  //           timeInSecForIosWeb: 4,
  //           backgroundColor: Colors.red,
  //           textColor: Colors.white,
  //           fontSize: 16.0);
  //     }
  //   });

  //   _connectionStatus = result;
  // }

  @override
  void initState() {
    initConnectivity();

    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen((result) => {
              if (result == ConnectivityResult.mobile ||
                  result == ConnectivityResult.wifi)
                {
                  Fluttertoast.showToast(
                      msg: "You Are Now Connected",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 4,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0)
                }
              else
                {
                  Fluttertoast.showToast(
                      msg: "You Are Not Connected",
                      toastLength: Toast.LENGTH_SHORT,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 4,
                      backgroundColor: Colors.red,
                      textColor: Colors.white,
                      fontSize: 16.0)
                }
            });
  }

  @override
  void dispose() {
    _connectivitySubscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final authprovider = Provider.of<ApiClientProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                clipBehavior: Clip.hardEdge,
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: size.height * 0.4,
                    color: teal,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(
                          "assets/images/profile.png",
                          height: 100,
                          width: 100,
                        ),
                        Text(
                          "Attenance App",
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        )
                      ],
                    )),
                clipper: CustomClipPath(),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Login",
                          style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w600,
                              color: teal),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, top: 2),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Lets get Started !",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w400,
                              color: teal),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      width: size.width * 0.9,
                      controller: emailController,
                      hintText: "Enter Email",
                      icon: Icon(
                        Icons.email,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextInput(
                      width: size.width * 0.9,
                      controller: passwordController,
                      secureTextentry: true,
                      hintText: "Enter Password",
                      icon: Icon(
                        Icons.lock,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    authprovider.authloading
                        ? CircularProgressIndicator.adaptive()
                        : CustomButton(
                            title: "Login",
                            color: teal,
                            ontap: () {
                              authprovider.postRequest(
                                  "https://dummyjson.com/auth/login", {
                                "username": emailController.text.toString(),
                                "password": passwordController.text.toString()
                              });
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => const HomePage()),
                              // );

                              // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              //     content: Text(
                              //         'Connection Status: ${_connectionStatus.toString()}')));
                            },
                          ),

                    Padding(
                      padding: const EdgeInsets.only(right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "Dont Have an Account?",
                            style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: darkgreen),
                          ),
                          // CustomTextButton(
                          //   title: "Signup",
                          // )
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUpScreen()),
                              );
                            },
                            child: Text(
                              "Signup",
                              style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600,
                                  color: teal),
                            ),
                          )
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: CustomTextButton(
                        title: "ForgotPassword",
                        ontap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ForgotPassword()),
                          );
                        },
                      ),
                    ),

                    // Text(
                    //   'Connection Status: ${_connectionStatus.toString()}',
                    //   style: TextStyle(
                    //       color: teal,
                    //       fontSize: 18,
                    //       fontWeight: FontWeight.w500),
                    // )

                    // Row(
                    //   children: [
                    //     Text(
                    //       "Dont Have an Account?",
                    //       style: TextStyle(
                    //           fontSize: 15,
                    //           fontWeight: FontWeight.w200,
                    //           color: green),
                    //     ),
                    //     CustomTextButton(
                    //       title: "Signup",
                    //     )
                    //   ],
                    // )

                    // ClipPath(
                    //   child: Container(
                    //       width: MediaQuery.of(context).size.width,
                    //       height: 200,
                    //       color: teal),
                    //   clipper: CustomClipPathdown(),
                    // ),

                    ElevatedButton.icon(
                        onPressed: () async {
                          bool auth = await Authentication.authentication();
                          print("authenticate: $auth");

                          if (auth) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomePage()));
                          }
                        },
                        icon: Icon(Icons.fingerprint_outlined),
                        label: Text("Authenticate"))
                  ],
                ),
              ),
            ],
          ),
        )));
  }
}

class CustomClipPath extends CustomClipper<Path> {
  var radius = 10.0;
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.arcToPoint(Offset(size.width, size.height),
        radius: Radius.elliptical(30, 10));
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// class CustomClipPathdown extends CustomClipper<Path> {
//   var radius = 20.0;
//   @override
//   Path getClip(Size size) {
//     Path path = Path();
//     path.lineTo(size.width, 0);
//     path.arcToPoint(Offset(size.width, size.height),
//         radius: Radius.elliptical(30, 10));
//     path.lineTo(size.width, 0);
//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) => false;
// }
