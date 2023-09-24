import "package:flutter/material.dart";
import 'package:wato/admin/adminreport.dart';


import 'package:wato/notification/notifications.dart';


import 'admin logout.dart';




class Manager extends StatefulWidget {
  const Manager({Key? key}) : super(key: key);

  @override
  ManagerState createState() => ManagerState();
}

class ManagerState extends State<Manager> {
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
                                builder: (context) => const Logout()),
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
                              builder: (context) => const Notifications(),
                            ),
                          );
                        },
                      ),
                    ),
                    Center(
                      child:
                      IconButton(
                        icon: const Icon(Icons.file_copy_rounded,
                          color: Colors.white,
                          size: 40,
                      ), onPressed: () {  Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Admin(),
                        ),
                      );
                          },
                      ),
                    ),
                    const Text("Reports",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        )),
                    ])),

            ])));
  }
}
