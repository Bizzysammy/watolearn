import "package:flutter/material.dart";
import 'package:wato/Assignments/download.dart';
import 'package:wato/notification/notifcation_s.dart';
import 'package:wato/profile/profile_page.dart';
import 'package:wato/Assignments/results.dart';
import 'package:wato/Assignments/upload.dart';


class Assignments extends StatefulWidget {
  const Assignments({Key? key}) : super(key: key);

  @override
  AssignmentsState createState() => AssignmentsState();
}

class AssignmentsState extends State<Assignments> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.green,
        body: SafeArea(
            child: Column(children: [
          Container(
              width: size.width,
              height: size.height * 0.3,
              decoration: const BoxDecoration(
                color: Colors.green,
              ),
              child: Column(children: [
                ListTile(
                  leading: IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.menu),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                  trailing: IconButton(
                    iconSize: 30,
                    icon: const Icon(Icons.notifications),
                    color: Colors.white,
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const NotificationScreen(),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child:
                  Icon(Icons.assignment,
                      color: Colors.white,
                      size: size.height * 0.13,
                  ),
                  ),

                const Text("Assignments",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    )),
              ])),
          Expanded(
            child: Container(
              width: size.width,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: size.height * 0.05,
                  ),
                  Container(
                      width: size.width * 0.9,
                      height: size.height * 0.1,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                          bottom: BorderSide(width: 4.0, color: Colors.green),
                          right: BorderSide(width: 4.0, color: Colors.green),
                          left: BorderSide(width: 4.0, color: Colors.green),
                          top: BorderSide(width: 4.0, color: Colors.green),
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                        children: [
                          IconButton (
                          icon: Icon(Icons.notes,
                              size: size.height * 0.09,
                          ), onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Uploads(),
                              ),
                            );
                          },
                  ),
                          IconButton(
                            icon: Icon(Icons.notes,
                              size: size.height * 0.09,
                          ), onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const Downloads(),
                              ),
                            );
                          },
                          ),
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.only(left: 30),
                    child: Row(children: [
                      for (var i = 0; i < 5; i++)
                        const Icon(
                          Icons.star,
                          color: Colors.green,
                          size: 30,
                    ),
                    ],
              ),
                  ),
                  const Text("You have 5 assignments due today",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 20,
                  ),
                  const Divider(
                    color: Colors.green,
                    thickness: 4,
                    indent: 30,
                    endIndent: 30,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   CircleAvatar(
                    radius: 50,
                    backgroundColor: Colors.green,
                    child: IconButton(
                    icon: const Icon(Icons.person,
                      color: Colors.white,
                      size: 40,
                    ), onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Results(),
                        ),
                      );
                    },
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Teacher Assessing the Assignment",
                      style: TextStyle(
                        color: Colors.green,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      )),
                ],
              ),
            ),
          )
        ])));
  }
}
