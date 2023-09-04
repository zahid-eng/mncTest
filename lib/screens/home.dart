import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter/services.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/liveness.dart';
import 'package:mnctest/screens/AttendanceHistory.dart';
import 'package:mnctest/screens/leaves.dart';
import 'package:mnctest/services/Api/apiClient.dart';
import 'package:mnctest/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  List<dynamic> users = [];
  List<dynamic> listData = [
    {"icon": Icons.person_3_rounded, "title": "Attendance"},
    {"icon": Icons.document_scanner, "title": "Daily Attendance List"},
    {"icon": Icons.smartphone, "title": "Mapped Employees"},
    {"icon": Icons.rate_review, "title": "Rate Us"},
    {"icon": Icons.list_alt, "title": "Leaves"},
    {"icon": Icons.person, "title": "Profile"}
  ];

  static const platform = MethodChannel('liveness.face.detection/face');
  List<String>? imageList;

  void _runNativeCode() async {
    try {
      // if (imageList != null) {
      //   PhotoManager.clearFileCache();
      // }
      imageCache.clear();
      imageCache.clearLiveImages();

      var result = await platform.invokeListMethod("startFaceDetection");
      if (result != null) {
        Future.delayed(Duration(seconds: 1)).then((res) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contex) =>
                      LiveNessScreen(imageDataList: result.cast<String>())));
          // setState(() {
          //   imageList = result.cast<String>();
          // });
          // detectFaces(imageList![0]);
        });
      }
      print("FaceDetectionResult ${result}");
    } on PlatformException catch (e) {
      print("FaceDetectionResult ${e.message}");
    }
  }

  final apiClient = ApiClientProvider();
  final getUrl = "https://jsonplaceholder.typicode.com/posts";
  final getParams = {"param1": "value1", "param2": "value2"};

  Future<void> _fetchData() async {
    final getResponse = await apiClient.getRequest(
      getUrl,
    );

    if (getResponse != null) {
      print("GET Response:");
      print(getResponse.statusCode);

      print(getResponse.data);
    }
    setState(() {
      users = getResponse!.data;
    });
  }

  // @override
  // void initState() {
  //   _fetchData();
  // }

  @override
  Widget build(BuildContext context) {
    Drawer? customDrawer;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      drawer: CustomDrawer(),
      appBar: null,
      key: _key,
      body: SafeArea(
        child: Container(
          height: size.height,
          width: size.width,
          child: Stack(
            children: [
              Container(
                  height: size.height * 0.35,
                  width: size.width,
                  color: teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 20, top: 20),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: GestureDetector(
                              onTap: () {
                                _key.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Colors.white,
                                size: 30,
                              ),
                            )),
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Welcome !\n",
                              style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                              children: <TextSpan>[
                            TextSpan(
                              text: "to ML&C Attendance",
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300),
                            )
                          ]))
                    ],
                  )),
              Container(
                margin: EdgeInsets.only(top: 220, left: 10, right: 10),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 1.9,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 10),
                    itemCount: listData.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var item = listData[index];
                      return InkWell(
                        hoverColor: teal,
                        onTap: () {
                          print(item);
                          if (item["title"] == "Attendance") {
                            _runNativeCode();
                          }
                          if (item["title"].contains("Daily")) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => AttendanceHistory()));
                          }
                          if (item["title"].contains("Leaves")) {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (contex) => LeavesScreen()));
                          }
                        },
                        child: Card(
                          color: Colors.white,
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                item["icon"],
                                color: teal,
                                size: 30,
                              ),
                              SizedBox(height: 10),
                              Text(
                                item["title"],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(color: Colors.black),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

enum myNavigation { Attendance, DailyAttendnce, MappedEmployees, Rateus }
