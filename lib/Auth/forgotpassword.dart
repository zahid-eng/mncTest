import 'package:flutter/material.dart';
import 'package:mnctest/MySlide/my_bottomtop.dart';
import 'package:mnctest/MySlide/my_fade_transition.dart';
import 'package:mnctest/MySlide/my_slide_transition..dart';
import 'package:mnctest/MySlide/my_topbottom.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/screens/home.dart';
import 'package:mnctest/widgets/Button.dart';
import 'package:mnctest/widgets/textButton.dart';
import 'package:mnctest/widgets/textfield.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ClipPath(
              child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: size.height * 0.4,
                  color: teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MySlideTransition(
                        duration: 700,
                        child: MyFadeAnimation(
                          duration: 600,
                          child: Image.asset(
                            "assets/images/profile.png",
                            height: 100,
                            width: 100,
                          ),
                        ),
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
            Text(
              "Forgot Password",
              style: TextStyle(
                  fontSize: 20, color: teal, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: MyFadeAnimation(
                duration: 300,
                child: MySlideTransition(
                  duration: 700,
                  child: TextInput(
                    hintText: "Enter Email",
                    icon: Icon(
                      Icons.email,
                      color: teal,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SlidebottomtoTop(
                duration: 600,
                child: MyFadeAnimation(
                  duration: 200,
                  child: CustomButton(
                      title: "Sent",
                      color: teal,
                      ontap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const HomePage()),
                        );
                      }),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: 20, top: 10),
                child: CustomTextButton(
                    title: "Login",
                    ontap: () {
                      Navigator.pop(context);
                    }),
              ),
            )
          ],
        ),
      ),
    );
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
