import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/screens/home.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )
      ..forward()
      ..repeat(reverse: true);
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  List<dynamic> userData = [
    {
      "Name": "Syed Mazhar Hussain Zaidi",
      "MLCNo": 123,
      "Designation": "Plumber",
      "Cnic": "42201-833939-9",
    },
    {
      "Name": "Ashras Rashid",
      "MLCNo": 124,
      "Designation": "Developer",
      "Cnic": "42201-833939-9",
    },
    {
      "Name": "Hassam Raza",
      "MLCNo": 125,
      "Designation": "Engineer",
      "Cnic": "42201-833939-9",
    },
    {
      "Name": "Adeel Shoukat",
      "MLCNo": 126,
      "Designation": "Developer",
      "Cnic": "42201-833939-9",
    },
    {
      "Name": "Zahid Ali",
      "MLCNo": 127,
      "Designation": "Engineer",
      "Cnic": "42201-833939-9",
    }
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Attendance History",
            style: TextStyle(color: Colors.white),
          ),
          elevation: 10,
          backgroundColor: teal,
          centerTitle: true,
          toolbarHeight: 200,
          leading: GestureDetector(
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (route) => false);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: AnimatedIcon(
                progress: animation,
                icon: AnimatedIcons.arrow_menu,
                size: 30.0,
                // semanticLabel: 'Show menu',
                color: Colors.white,
                //   Icons.arrow_back_ios,
                //   color: Colors.white,
                // ),
              ),
            ),
          ),
        ),
        body: AnimationLimiter(
          child: ListView.builder(
              itemCount: userData.length,
              itemBuilder: (contex, index) {
                var item = userData[index];
                return AnimationConfiguration.staggeredGrid(
                  duration: Duration(milliseconds: 800),
                  columnCount: 2,
                  position: index,
                  child: SlideAnimation(
                    verticalOffset: 50.0,
                    child: FadeInAnimation(
                      child: Card(
                          shadowColor: teal,
                          elevation: 10,
                          margin: EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: ListTile(
                            leading: CircleAvatar(
                                radius: 35,
                                backgroundImage:
                                    AssetImage("assets/images/profilepic.jpg")),
                            title: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(item["Name"].toString(),
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: teal,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w600)),
                              ],
                            ),
                            subtitle: Column(
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      "Cnic :",
                                      style: TextStyle(color: teal),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      item["Cnic"].toString(),
                                      style: TextStyle(
                                          fontSize: 15,
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "MLC No:",
                                      style: TextStyle(color: teal),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(item["MLCNo"].toString())
                                  ],
                                ),
                              ],
                            ),
                            trailing: Padding(
                              padding: const EdgeInsets.only(left: 5, top: 20),
                              child: RichText(
                                  text: TextSpan(
                                text: 'Designation\n',
                                style: TextStyle(color: black),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: item["Designation"],
                                    style: TextStyle(
                                        color: teal,
                                        overflow: TextOverflow.ellipsis),
                                  )
                                ],
                              )),
                            ),
                          )),
                    ),
                  ),
                );
              }),
        ));
  }
}
