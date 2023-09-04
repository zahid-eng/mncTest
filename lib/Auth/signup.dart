import 'dart:io';

import 'package:flutter/material.dart';

import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/widgets/Button.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mnctest/widgets/textButton.dart';
import 'package:mnctest/widgets/textfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  File? image;
  Future pickImage() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  Future cameraPick() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image == null) return;
      final imageTemp = File(image.path);
      setState(() => this.image = imageTemp);
    } on Exception catch (e) {
      print('Failed to pick image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      // appBar: AppBar(
      //   toolbarHeight: 200,
      //   primary: true,
      //   flexibleSpace: Container(
      //     decoration: BoxDecoration(
      //       image: DecorationImage(
      //         image: AssetImage("assets/images/cb_care.png"),
      //         fit: BoxFit.cover,
      //       ),
      //     ),
      //   ),
      // ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              ClipPath(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: size.height * 0.35,
                    color: teal,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            "assets/images/profile.png",
                            height: 80,
                            width: 80,
                          ),
                        ],
                      ),
                    )),
                clipper: CustomClipPath(),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Column(
                  children: [
                    Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        image != null
                            ? CircleAvatar(
                                radius: 60,
                                backgroundImage: FileImage(image!),
                              )
                            : CircleAvatar(
                                radius: 60,
                                backgroundImage: AssetImage(
                                  "assets/images/profilepic.jpg",
                                ),
                              ),
                        Positioned(
                            right: 0.0,
                            bottom: 70.0,
                            child: InkWell(
                              onTap: () {
                                var alert = AlertDialog(
                                  backgroundColor: teal,
                                  title: Text("Alert"),
                                  content: Text("Pick Image"),
                                  actions: [
                                    ElevatedButton(
                                        onPressed: () {
                                          cameraPick();
                                          Navigator.pop(context);
                                        },
                                        child: Text(
                                          "Camera",
                                          style: TextStyle(color: teal),
                                        )),
                                    ElevatedButton(
                                        onPressed: () {
                                          pickImage();
                                          Navigator.pop(context);
                                        },
                                        child: Text("Gallery",
                                            style: TextStyle(color: teal))),
                                  ],
                                );
                                showDialog(
                                    context: context,
                                    builder: (BuildContext) => alert);
                              },
                              child: Container(
                                width: 35.0,
                                height: 35.0,
                                decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.white),
                                child: Icon(
                                  Icons.flip_camera_ios,
                                  color: teal,
                                ),
                              ),
                            ))
                      ],
                    ),
                    Text("Profile Picture",
                        style: TextStyle(
                            fontSize: 18,
                            color: teal,
                            fontWeight: FontWeight.w500)),
                    SizedBox(
                      height: 15,
                    ),
                    TextInput(
                      hintText: "Name",
                      icon: Icon(
                        Icons.person,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextInput(
                      hintText: "Cnic",
                      icon: Icon(
                        Icons.credit_card,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextInput(
                      hintText: "Email",
                      icon: Icon(
                        Icons.email,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextInput(
                      hintText: "Password",
                      icon: Icon(
                        Icons.key,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextInput(
                      hintText: "Confirm Password",
                      icon: Icon(
                        Icons.key,
                        color: teal,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    CustomButton(
                      title: "Save",
                      color: teal,
                      ontap: () {},
                    ),
                    CustomTextButton(
                      title: "Back to Login",
                      ontap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
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
