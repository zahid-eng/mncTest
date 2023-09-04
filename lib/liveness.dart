import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnctest/constant/constant.dart';
import 'main.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class LiveNessScreen extends StatefulWidget {
  final List<String> imageDataList;
  const LiveNessScreen({super.key, required this.imageDataList});

  @override
  State<LiveNessScreen> createState() => _LiveNessScreenState();
}

class _LiveNessScreenState extends State<LiveNessScreen>
    with TickerProviderStateMixin {
  Uint8List? faceImage;
  String? croppedImage;
  void detectFaces(String path) async {
    final options =
        FaceDetectorOptions(enableLandmarks: true, enableContours: true);
    final faceDetector = FaceDetector(options: options);
    final List<Face> faces = await faceDetector
        .processImage(InputImage.fromFilePath(path.split("file://")[1]));

    List<Map<String, int>> faceMaps = [];

    for (Face face in faces) {
      int x = face.boundingBox.left.toInt();
      int y = face.boundingBox.top.toInt();
      int w = face.boundingBox.width.toInt();
      int h = face.boundingBox.height.toInt();
      Map<String, int> thisMap = {'x': x, 'y': y, 'w': w, 'h': h};
      faceMaps.add(thisMap);
    }
    img.Image originalImage =
        img.decodeImage(File(path.split("file://")[1]).readAsBytesSync())!;
    img.Image faceCrop = img.copyCrop(originalImage,
        x: faceMaps[0]['x']!,
        y: faceMaps[0]['y']!,
        width: faceMaps[0]['w']!,
        height: faceMaps[0]['h']!);

    // Save the cropped image as PNG
    List<int> pngBytes = img.encodePng(faceCrop);
    Directory appDirectory = await getApplicationDocumentsDirectory();
    String filePath =
        '${appDirectory.path}/cropped_image${DateTime.now().microsecondsSinceEpoch}.png';
    // hamare pass static path us ko dynamic k lye kia hum ne

    File croppedFile = File(filePath);
    await croppedFile.writeAsBytes(pngBytes);

    Future.delayed(Duration(seconds: 2)).then((value) {
      setState(() {
        //faceImage = Uint8List.fromList(faceCrop.toUint8List());
        // Uint8List faceImage = base64.decode(faceCrop.);

        // faceImage = img.decodeImage(faceCrop.data!.) as Uint8List?;

        croppedImage = filePath;
      });
    });
  }

  @override
  void initState() {
    super.initState();
    detectFaces(widget.imageDataList[0]);
  }

  @override
  Widget build(BuildContext context) {
    // String imagepath =
    //     '///data/user/0/com.example.mnctest/files/img_HOLD_STILL.jpg';

    // Uint8List loadData(imagePath) {
    //   print(imagePath);
    //   File file = File(imagePath);
    //   Uint8List bytes = file.readAsBytesSync();
    //   return bytes;
    // }
    // ImageProvider imageProvider = new MemoryImage(loadData());

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: teal,
        shadowColor: teal,
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Welcome to Face Attendance',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ignore: unnecessary_null_comparison
            // widget.imageDataList != null
            croppedImage != null
                ? Text(
                    "Detect Face",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),

            croppedImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          border: Border.all(color: teal, width: 2.0)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 174, 232, 226),
                                          width: 3),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 8,
                                    child: CircleAvatar(
                                      radius: 60,
                                      child: ClipOval(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.file(
                                          File(croppedImage.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 128, 213, 204),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("Ali")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "MlcNO :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("123344")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Oraganization :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("Pixcile")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                : Center(
                    child: CircularProgressIndicator(
                      color: teal,
                    ),
                  ),
            croppedImage != null
                ? Text(
                    "Matched Face",
                    style: TextStyle(
                      color: Colors.teal,
                      fontSize: 20,
                    ),
                    textAlign: TextAlign.center,
                  )
                : SizedBox(),
            croppedImage != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Container(
                      height: 150,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(30),
                              topRight: Radius.circular(30)),
                          border: Border.all(color: teal, width: 2.0)),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            children: [
                              Stack(
                                children: [
                                  Container(
                                    height: 150,
                                    width: 140,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 174, 232, 226),
                                          width: 2),
                                    ),
                                  ),
                                  Positioned(
                                    left: 10,
                                    top: 8,
                                    child: CircleAvatar(
                                      radius: 60,
                                      child: ClipOval(
                                        clipBehavior: Clip.antiAlias,
                                        child: Image.file(
                                          File(croppedImage.toString()),
                                          fit: BoxFit.fill,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(left: 10),
                                width: MediaQuery.of(context).size.width * 0.45,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 128, 213, 204),
                                    borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(30),
                                        bottomLeft: Radius.circular(30))),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            "Name :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("Ali")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "MlcNO :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("123344")
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          Text(
                                            "Oraganization :  ",
                                            style:
                                                TextStyle(color: Colors.white),
                                          ),
                                          Text("Pixcile")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ))
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
