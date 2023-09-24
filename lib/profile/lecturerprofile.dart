import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:wato/lectureranalytics.dart';
import 'package:wato/login/login_page.dart';
import 'package:wato/settings/editlecturerprofile.dart';
import 'package:wato/settings/help_support.dart';
import 'package:provider/provider.dart';
import 'package:wato/notification_state.dart';
import 'package:wato/settings/preferences.dart';
import 'package:wato/settings/privacy.dart';

import '../main.dart';

class LecturerProfile extends StatefulWidget {
  const LecturerProfile({Key? key}) : super(key: key);

  @override
  LecturerProfileState createState() => LecturerProfileState();
}

class LecturerProfileState extends State<LecturerProfile> {
  bool isNightMode = false;
  bool isNotifyMode = false;
  bool isDarkMode = false;
  bool isLightMode = false;

  Locale? _selectedLocale;
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? imageUrl;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: size.height * 0.02,
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.green,
                          width: 3,
                        ),
                      ),

                      child: FutureBuilder<DocumentSnapshot>(
                        future: FirebaseFirestore.instance
                            .collection("lecturers")
                            .doc(userId)
                            .get(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData && snapshot.data!.exists) {
                            final data = snapshot.data!.data() as Map<String, dynamic>?; // Explicit cast to Map<String, dynamic>
                            String? imageUrl = data?['profile_photo'] as String?;
                            return CircleAvatar(
                              backgroundImage: imageUrl != null
                                  ? Image.network(imageUrl).image
                                  : const AssetImage('assets/logo.jpg'),
                              maxRadius: 60,
                              minRadius: 50,
                            );
                          } else {
                            return const CircularProgressIndicator();
                          }
                        },
                      ),

                    ),
                  ),
                ],
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("lecturers")
                    .doc(userId)
                    .snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      snapshot.data?["name"] ?? "",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  } else {
                    return const Text("Loading...");
                  }
                },
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: Colors.green,
                    width: size.width,
                    height: size.height * 0.05,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "General",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Editlecturerprofile(),
                          ),
                        );
                      },
                      child: const Text(
                        "Edit profile",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Preferences(),
                          ),
                        );
                      },
                      child: const Text(
                        "Preferences",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Privacy(),
                          ),
                        );
                      },
                      child: const Text(
                        "Privacy",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26),
                        child: Text(
                          "Night mode",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: Provider.of<ThemeProvider>(context).isDarkMode,
                        activeColor: CupertinoColors.darkBackgroundGray,
                        onChanged: (bool value) {
                          Provider.of<ThemeProvider>(context, listen: false).toggleTheme();
                        },
                      ),
                    ],
                  ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Select Language'),
                      content: DropdownButton<Locale>(
                        value: _selectedLocale,
                        onChanged: (Locale? newValue) {
                          setState(() {
                            _selectedLocale = newValue;
                            // Apply language change here
                            // You can use a localization library like `flutter_localizations`
                            // to change the app's language based on the selected locale.
                            // Refer to the library's documentation for implementation details.
                          });
                        },
                        items: const [
                          DropdownMenuItem<Locale>(
                            value: Locale('en', 'US'), // Example language/locale
                            child: Text('English'),
                          ),
                          DropdownMenuItem<Locale>(
                            value: Locale('ar', 'SA'), // Example language/locale
                            child: Text('Arabic'),
                          ),
                          // Add more language options here
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ],
                    );
                  },
                );
              },
              child: const Text(
                "Language",
                textAlign: TextAlign.left,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 15,
                ),
              ),
            ),
          ),
                  Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 26),
                        child: Text(
                          "Notifications",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Spacer(),
                      CupertinoSwitch(
                        value: Provider.of<NotificationState>(context).isNotificationEnabled,
                        onChanged: (bool value) {
                          Provider.of<NotificationState>(context, listen: false).isNotificationEnabled = value;

                          if (value) {
                            // Show notification alert
                            _showNotificationAlert(context);
                          }
                        },
                      ),

                    ],
                  ),
                  Container(
                    color: Colors.green,
                    width: size.width,
                    height: size.height * 0.05,
                    alignment: Alignment.centerLeft,
                    child: const Padding(
                      padding: EdgeInsets.only(left: 20),
                      child: Text(
                        "Other",
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Lectureranalytics(),
                          ),
                        );
                      },
                      child: const Text(
                        "About",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HelpScreen(),
                          ),
                        );
                      },
                      child: const Text(
                        "Help & Support",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: TextButton(
                      onPressed: () {
                        _logout();
                      },
                      child: const Text(
                        "Logout",
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<String?> getUsername(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('lecturers')
          .doc(userId)
          .get();
      return snapshot.get('name');
    } catch (e) {
      if (kDebugMode) {
        print('Error getting username: $e');
      }
      return null;
    }
  }

  Future<void> _logout() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Confirmation'),
        content: const Text('Are you sure you want to log out?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}// Rest of your code...
void _showNotificationAlert(BuildContext context) {
  Fluttertoast.showToast(
    msg: 'You have a new notification.',
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey[700],
    textColor: Colors.white,
  );
}