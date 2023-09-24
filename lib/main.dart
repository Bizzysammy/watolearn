import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wato/recent_class.dart';
import 'lecturerassignments.dart';
import 'learn/join_class.dart';
import 'Assignments/assignments.dart';
import 'analytics/analytics.dart';
import 'firebase_options.dart';
import 'groupdiscussion/discusion.dart';
import 'learn/learn_screen.dart';
import 'login/login_page.dart';
import 'progress/progress.dart';
import 'past_papers/pastpapers.dart';
import 'notification_state.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<ThemeProvider>(
          create: (_) => ThemeProvider(),
        ),
        ChangeNotifierProvider<NotificationState>(
          create: (_) => NotificationState(),
        ),
      ],

      child: const MyApp(),
    ),
  );




}
class ThemeProvider extends ChangeNotifier {
  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void toggleTheme() {
    _isDarkMode = !_isDarkMode;
    notifyListeners();
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final isDarkMode = Provider.of<ThemeProvider>(context).isDarkMode;
    final theme = isDarkMode ? ThemeData.dark() : ThemeData(
      primarySwatch: Colors.green,
    );

    return MaterialApp(
      title: 'Wato',
      theme:theme ,
      home: ChangeNotifierProvider<NotificationState>(
        create: (_) => NotificationState(),
        child: const LoginPage(),
      ),

      initialRoute: '/',
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/':
            return MaterialPageRoute(builder: (_) => const LoginPage());
          case '/Assignments':
            return MaterialPageRoute(builder: (_) => const Assignments());
          case '/AnalyticsScreen':
            return MaterialPageRoute(builder: (_) => const AnalyticsScreen());
          case '/GroupDiscussionScreen':
            return MaterialPageRoute(
                builder: (_) => const GroupDiscussionScreen());
          case '/RecentClass':
            return MaterialPageRoute(builder: (_) => const RecentClass());
          case '/LearnScreen':
            return MaterialPageRoute(builder: (_) => const LearnScreen());
          case '/Joinclass':
            return MaterialPageRoute(builder: (_) => const JoinClass());
          case '/Progress':
            return MaterialPageRoute(builder: (_) => const Progress());
          case '/Past':
            return MaterialPageRoute(builder: (_) => const Past());
          case '/Lecturerassignments':
            return MaterialPageRoute(builder: (_) => const Lecturerassignments());
          // add more routes here
          default:
            return null;
        }
      },
    );
  }
}
