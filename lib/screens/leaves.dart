import 'package:flutter/material.dart';
import 'package:mnctest/constant/constant.dart';
import 'package:mnctest/screens/home.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class LeavesScreen extends StatefulWidget {
  const LeavesScreen({super.key});

  @override
  State<LeavesScreen> createState() => _LeavesScreenState();
}

class _LeavesScreenState extends State<LeavesScreen>
    with SingleTickerProviderStateMixin {
  final GlobalKey<AnimatedListState> _key = GlobalKey();

  @override
  void initState() {
    founduser = users;
    super.initState();
  }

  bool? pending = false;

  List<Map<String, dynamic>> founduser = [];
  List<Map<String, dynamic>> users = [
    {"name": "Hassam"},
    {"name": "Zahid"},
    {"name": "Ashras"},
    {"name": "Syed Faizan Hussain"},
    {"name": "Adeel Shoukat"},
    {"name": "Ali Ghanchi"},
    {"name": "Ahad Ghanchi"},
  ];

  // void _addTask() async {
  //    newTask = users('New Task ${users.length + 1}', false);
  //   tasks.add(newTask);
  //   _key.currentState!.insertItem(users.length - 1);
  // }

  void _runFilter(String enterkeyword) {
    List<Map<String, dynamic>> results = [];

    if (enterkeyword.isEmpty) {
      results = users;
    } else {
      results = users
          .where((user) =>
              user["name"].toLowerCase().contains(enterkeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      founduser = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          backgroundColor: teal,
          onPressed: () {},
          child: Icon(
            Icons.add,
            size: 25,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: teal,
          shadowColor: teal,
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
          elevation: 20,
          title: Text(
            "Leaves",
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              height: 50,
              width: MediaQuery.of(context).size.width * 0.9,
              decoration: BoxDecoration(
                  border: Border.all(color: teal),
                  borderRadius: BorderRadius.circular(30)),
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 10, right: 10),
                child: TextFormField(
                  onChanged: (value) {
                    _runFilter(value);
                  },
                  decoration: InputDecoration(
                      suffixIcon: Icon(
                        Icons.search,
                        color: teal,
                      ),
                      border: InputBorder.none,
                      hintText: "Search Employee"),
                ),
              ),
            ),
            Expanded(
                child: founduser.isNotEmpty
                    ? AnimationLimiter(
                        child: ListView.builder(
                            itemCount: founduser.length,
                            itemBuilder: (contex, index) {
                              var item = founduser[index];
                              return AnimationConfiguration.staggeredList(
                                position: index,
                                duration: const Duration(milliseconds: 700),
                                child: SlideAnimation(
                                  horizontalOffset: 50.0,
                                  child: FadeInAnimation(
                                    child: Card(
                                      color: deepurple,
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 5),
                                      child: ListTile(
                                        title: Text(
                                          item["name"],
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        leading: CircleAvatar(
                                          backgroundImage: AssetImage(
                                              "assets/images/profilepic.jpg"),
                                          radius: 30,
                                        ),
                                        subtitle: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Text(
                                                  "Status",
                                                  style: TextStyle(color: teal),
                                                ),
                                                Text(
                                                  "Pending",
                                                  style: TextStyle(
                                                      color: Colors.blue,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("From Date",
                                                    style:
                                                        TextStyle(color: teal)),
                                                Text("2/3/19")
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text("To Date ",
                                                    style:
                                                        TextStyle(color: teal)),
                                                Text("2/4/20")
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      )
                    : Text(
                        "No Result Found",
                        style: TextStyle(fontSize: 20),
                      )),
          ],
        ));
  }
}

// class AnimatedListItem extends StatefulWidget {
//   final int index;

//   const AnimatedListItem(this.index, {Key? key}) : super(key: key);

//   @override
//   State<AnimatedListItem> createState() => _AnimatedListItemState();
// }

// class _AnimatedListItemState extends State<AnimatedListItem> {
//   bool _animate = false;

//   static bool _isStart = true;

//   @override
//   void initState() {
//     super.initState();
//     if (_isStart) {
//       Future.delayed(Duration(milliseconds: widget.index * 100), () {
//         setState(() {
//           _animate = true;
//           _isStart = false;
//         });
//       });
//     } else {
//       _animate = true;
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedOpacity(
//       duration: const Duration(milliseconds: 1000),
//       opacity: _animate ? 1 : 0,
//       curve: Curves.easeInOutQuart,
//       child: AnimatedPadding(
//         duration: const Duration(milliseconds: 1000),
//         padding: _animate
//             ? const EdgeInsets.all(4.0)
//             : const EdgeInsets.only(top: 10),
//         child: Container(
//           constraints: const BoxConstraints.expand(height: 100),
//           child: Card(
//             child: Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: Text(
//                 widget.index.toString(),
//                 style: const TextStyle(fontSize: 24),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
