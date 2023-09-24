import 'package:flutter/material.dart';
import 'package:wato/learn/learn_screen.dart';
import 'package:wato/profile/lecturerprofile.dart';
import 'package:wato/recent_class.dart';
import 'package:provider/provider.dart';
import 'home.dart';
import '../notification_state.dart';
import 'package:fluttertoast/fluttertoast.dart';


class Exploreme extends StatefulWidget {
  const Exploreme({Key? key}) : super(key: key);

  @override
  ExploremeState createState() => ExploremeState();
}

class ExploremeState extends State<Exploreme> {
  int _currentIndex = 0;
  final List<Widget> _pages = [
    const Home(),
    const LecturerProfile(),
    const LearnScreen(),
    const RecentClass(),
  ];

  @override
  Widget build(BuildContext context) {
    final isNotificationEnabled =
        Provider
            .of<NotificationState>(context)
            .isNotificationEnabled;
    if (isNotificationEnabled) {
      // Show notification alert
      _showNotificationAlert(context);
    }
    return Scaffold(
      body: Scaffold(
          backgroundColor: Colors.green,
          body: IndexedStack(
            index: _currentIndex,
            children: _pages,
          ),
          bottomNavigationBar: Container(
            width: double.infinity,
            height: 60,
            decoration: const BoxDecoration(
              color: Colors.green,
              borderRadius: BorderRadius.all(Radius.circular(20)),
            ),
            child: BottomNavigationBar(
              backgroundColor: Colors.green,
              currentIndex: _currentIndex,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: const [
                BottomNavigationBarItem(
                  backgroundColor: Colors.green,
                  icon: Icon(
                    Icons.home,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.person,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.message,
                    size: 30,
                  ),
                  label: '',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.calendar_today,
                    size: 30,
                  ),
                  label: '',
                ),
              ],
            ),
          )),
    );
  }
}
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
