import "package:cloud_firestore/cloud_firestore.dart";
import 'package:flutter/material.dart';
import "package:firebase_auth/firebase_auth.dart";
import "package:wato/analytics/custom_Anima.dart";
import "package:flutter/foundation.dart";

class Lectureranalytics extends StatefulWidget {
  const Lectureranalytics({super.key});


  @override
  LectureranalyticsState createState() => LectureranalyticsState();
}

class LectureranalyticsState extends State<Lectureranalytics>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  final List<double> _percentages = [0.8, 0.6, 0.9, 0.7, 0.5, 0.4];
  final List<Color> _colors = [
    Colors.blue,
    Colors.orange,
    Colors.pink,
    Colors.green,
    Colors.purple,
    Colors.red,
  ];
  final userId = FirebaseAuth.instance.currentUser!.uid;
  String? imageUrl;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..forward();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Screen'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(
              height: size.height * 0.02,
            ),
            Stack(children: [
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
                  return Text(snapshot.data!["name"],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 13,
                        fontWeight: FontWeight.bold,
                      ));
                } else {
                  return const Text("Loading...");
                }
              },
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[0],
                      color: _colors[0],
                      animation: _animation,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[1],
                      color: _colors[1],
                      animation: _animation,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[1],
                      color: _colors[1],
                      animation: _animation,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[3],
                      color: _colors[3],
                      animation: _animation,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            Expanded(
              child: Row(
                children: [
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[4],
                      color: _colors[4],
                      animation: _animation,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: AnimatedCircularProgress(
                      percentage: _percentages[5],
                      color: _colors[5],
                      animation: _animation,
                    ),
                  ),
                ],
              ),
            ),
          ],
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
}



