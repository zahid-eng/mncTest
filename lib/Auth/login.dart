import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/widgets/Button.dart';
import 'package:mnctest/widgets/background_design.dart';
import 'package:mnctest/widgets/textButton.dart';
import 'package:mnctest/widgets/textfield.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                "assets/images/cb_care.png",
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Hello !",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w600, color: teal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30, top: 2),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Lets get Started !",
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w400, color: teal),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextInput(
                  width: size.width * 0.9,
                  hintText: "Enter Email",
                  icon: Icon(
                    Icons.email,
                    color: teal,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: TextInput(
                  width: size.width * 0.9,
                  secureTextentry: true,
                  hintText: "Enter Password",
                  icon: Icon(
                    Icons.lock,
                    color: teal,
                  ),
                ),
              ),
              CustomButton(
                title: "Login",
                color: teal,
                ontap: () {
                  print("This is custom Button");
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
                        print("signup");
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
                ),
              )
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
            ],
          ),
        )));
  }
}
