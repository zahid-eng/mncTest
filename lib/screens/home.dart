import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/widgets/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<dynamic> listData = [
    {"icon": Icons.person_3_rounded, "title": "Attendance"},
    {"icon": Icons.document_scanner, "title": "Daily Attendance\nList"},
    {"icon": Icons.smartphone, "title": "Mapped Employees"},
    {"icon": Icons.rate_review, "title": "Rate Us"}
  ];
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: CustomDrawer(),
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
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100, left: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
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
                    ),
                  )),
              Container(
                margin: EdgeInsets.only(top: 220, left: 10, right: 10),
                child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 1.9,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 15),
                    itemCount: listData.length,
                    itemBuilder: (BuildContext ctx, index) {
                      var item = listData[index];
                      return Card(
                        color: Colors.white,
                        elevation: 10,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              item["icon"],
                              size: 40,
                              color: Colors.black38,
                            ),
                            SizedBox(height: 10),
                            Text(
                              item["title"],
                              style: TextStyle(color: Colors.black),
                            )
                          ],
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
