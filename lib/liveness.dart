import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:photo_manager/photo_manager.dart';
import 'main.dart';

class LiveNessScreen extends StatefulWidget {
  const LiveNessScreen({super.key});

  @override
  State<LiveNessScreen> createState() => _LiveNessScreenState();
}

class _LiveNessScreenState extends State<LiveNessScreen> {
  static const platform = MethodChannel('liveness.face.detection/face');
  List<String>? imageList;

  Future<void> accessFileSystem() async {
    // Get the directory where documents are stored.
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // Create a new file within the directory.
    File file = File('${documentsDirectory.path}/$imageList');
    // Write some data to the file.
    print('documentsDirectory:$documentsDirectory');
    // Read data from the file.
    // String fileContent = await file.readAsString();
    // print('File content: $fileContent');
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
                        .map((img) => Image.file(
                              File(img.split("file://")[1]),
                              width: 200,
                              height: 200,
                            ))
                        .toList())
                : SizedBox(),
            ElevatedButton(
                onPressed: () async {
                  try {
                    if (imageList != null) {
                      PhotoManager.clearFileCache();
                    }

                    var result =
                        await platform.invokeListMethod("startFaceDetection");
                    if (result != null) {
                      Future.delayed(Duration(seconds: 10)).then((res) {
                        setState(() {
                          var _result = result.cast<String>();
                          imageList = _result as List<String>;
                        });
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
