import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'main.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class LiveNessScreen extends StatefulWidget {
  const LiveNessScreen({super.key});

  @override
  State<LiveNessScreen> createState() => _LiveNessScreenState();
}

class _LiveNessScreenState extends State<LiveNessScreen> {
  static const platform = MethodChannel('liveness.face.detection/face');
  List<String>? imageList;
  Uint8List? faceImage;
  String? croppedImage;

  // late final InputImage inputImage;
  // final options = FaceDetectorOptions();
  // final faceDetector = FaceDetector(
  //     options: FaceDetectorOptions(
  //         minFaceSize: 0.1, performanceMode: FaceDetectorMode.fast));

  // Future<void> accessFileSystem() async {
  //   // Get the directory where documents are stored.
  //   Directory documentsDirectory = await getApplicationDocumentsDirectory();
  //   // Create a new file within the directory.
  //   File file = File('${documentsDirectory.path}/$imageList');
  //   // Write some data to the file.
  //   print('documentsDirectory:$documentsDirectory');
  //   // Read data from the file.
  //   // String fileContent = await file.readAsString();
  //   // print('File content: $fileContent');
  // }

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

      // final double? rotX =
      //     face.headEulerAngleX; // Head is tilted up and down rotX degrees
      // final double? rotY =
      //     face.headEulerAngleY; // Head is rotated to the right rotY degrees
      // final double? rotZ =
      //     face.headEulerAngleZ; // Head is tilted sideways rotZ degrees

      // If landmark detection was enabled with FaceDetectorOptions (mouth, ears,
      // eyes, cheeks, and nose available):
      // final FaceLandmark? leftEar = face.landmarks[FaceLandmarkType.leftEar];
      // if (leftEar != null) {
      //   final Point<int> leftEarPos = leftEar.position;
      // }

      // // If classification was enabled with FaceDetectorOptions:
      // if (face.smilingProbability != null) {
      //   final double? smileProb = face.smilingProbability;
      // }

      // // If face tracking was enabled with FaceDetectorOptions:
      // if (face.trackingId != null) {
      //   final int? id = face.trackingId;
      // }
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

    setState(() {
      //faceImage = Uint8List.fromList(faceCrop.toUint8List());
      // Uint8List faceImage = base64.decode(faceCrop.);

      // faceImage = img.decodeImage(faceCrop.data!.) as Uint8List?;

      croppedImage = filePath;
    });
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
      appBar: AppBar(
        title: const Text('Liveness Identifier Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            imageList != null
                ? Row(
                    children: imageList!
                        .map((img) => Image(
                              key: UniqueKey(),
                              image: FileImage(File(img.split("file://")[1])),
                              width: 200,
                              height: 200,
                            ))
                        .toList())
                : SizedBox(),

            croppedImage != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 20, top: 20),
                    child: Row(
                      children: [
                        Image.file(File(croppedImage.toString())),
                      ],
                    ),
                  )
                : SizedBox(),
            ElevatedButton(
                onPressed: () async {
                  try {
                    // if (imageList != null) {
                    //   PhotoManager.clearFileCache();
                    // }
                    imageCache.clear();
                    imageCache.clearLiveImages();

                    var result =
                        await platform.invokeListMethod("startFaceDetection");
                    if (result != null) {
                      Future.delayed(Duration(seconds: 1)).then((res) {
                        setState(() {
                          imageList = result.cast<String>();
                        });
                        detectFaces(imageList![0]);
                      });
                    }
                    print("FaceDetectionResult ${result}");
                  } on PlatformException catch (e) {
                    print("FaceDetectionResult ${e.message}");
                  }
                },
                child: Text("Start"))
            // Text(livenessResult?.toJson().toString() ?? "Data still empty"),
            // ElevatedButton(
            //   onPressed: () async {
            //     livenessResult =
            //         await _mncIdentifierFacePlugin.startLivenessDetection();
            //     setState(() {});
            //   },
            //   child: const Text("START LIVENESS IDENTIFIER"),
            // )
          ],
        ),
      ),
    );
  }
}
