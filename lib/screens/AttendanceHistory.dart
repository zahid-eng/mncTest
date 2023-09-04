import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/screens/home.dart';

class AttendanceHistory extends StatefulWidget {
  const AttendanceHistory({super.key});

  @override
  State<AttendanceHistory> createState() => _AttendanceHistoryState();
}

class _AttendanceHistoryState extends State<AttendanceHistory> {
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
            child: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
          ),
        ),
        body: ListView.builder(
            itemCount: userData.length,
            itemBuilder: (contex, index) {
              var item = userData[index];
              return Card(
                  shadowColor: teal,
                  elevation: 10,
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
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
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: [
                          Text(
                            "Designation",
                            style: TextStyle(
                              color: teal,
                            ),
                          ),
                          Text(
                            item["Designation"],
                            style: TextStyle(overflow: TextOverflow.ellipsis),
                          )
                        ],
                      ),
                    ),
                  ));
            }));
  }
}
