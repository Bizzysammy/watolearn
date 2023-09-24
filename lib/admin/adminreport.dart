import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:wato/notification/notifcation_s.dart';



import 'lecturer report.dart';

class Admin extends StatefulWidget {
  const Admin ({Key? key}) : super(key: key);

  @override
  AdminState createState() =>  AdminState();
}

class  AdminState extends State< Admin> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lecturer Tracking Report'),
          actions: [
      Padding(
      padding: const EdgeInsets.only(right: 16.0),
        child: IconButton(
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
          ],
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('lecturers').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return const Center(child: Text('Error fetching users'));
          } else if (snapshot.hasData) {
            final users = snapshot.data!.docs;
            return ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                final user = users[index];
                return ListTile(
                  title: Text(user['name']),
                  onTap: () => _viewUserLoginReport(context, user.id),
                  // Customize the list item as needed
                );
              },
            );
          } else {
            return const Center(child: Text('No users available'));
          }
        },

      ),
    );
  }

  void _viewUserLoginReport(BuildContext context, String userId) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LecturerLoginReportPage(userId: userId)),
    );
  }
}