import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LecturerLoginReportPage extends StatelessWidget {
  final String userId;

  const LecturerLoginReportPage({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecturer Login Report'),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection('lecturers')
            .doc(userId)
            .collection('loginTimes')
            .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching user login times'));
          } else if (snapshot.hasData) {
            final loginTimes = snapshot.data!.docs;
            return ListView.builder(
              itemCount: loginTimes.length,
              itemBuilder: (context, index) {
                final loginTime = loginTimes[index];
                final timestamp = loginTime['timestamp'].toDate();
                final course = loginTime['course'];
                return ListTile(
                  title: Text(timestamp.toString()),
                  subtitle: Text('Course: $course'),
                  // Customize the list item as needed
                );
              },
            );
          } else {
            return const Center(child: Text('No login times available for this user'));
          }
        },
      ),
    );
  }
}
