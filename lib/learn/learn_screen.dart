
import 'package:flutter/material.dart';
import 'package:wato/learn/live_stream1.dart';


class LearnScreen extends StatefulWidget {
  const LearnScreen({Key? key,}) : super(key: key);

  @override
  LearnScreenState createState() => LearnScreenState();
}

class LearnScreenState extends State<LearnScreen> {
  final liveController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    liveController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
      child: SingleChildScrollView(
      child: Column(children: [
      Container(
      alignment: Alignment.topLeft,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        color: Colors.green,
        onPressed: () {
          Navigator.pop(context);
        },
      ),
    ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
             SizedBox(
              width: 150,
              child: TextField(
      controller: liveController,
                  style: const TextStyle(
                      fontSize: 25
                  ),
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),

              ),
            ),
            const SizedBox(height: 30),
            SizedBox(
              height: 70,
              width: 200,
              child: ElevatedButton(
                  onPressed: (){
                    Navigator.push(
                    context, MaterialPageRoute(
                    builder: (context) => LiveScreen1(
      liveID: liveController.text,
      ),
      ),
      );
      },
                  child: const Text('Start Class',
                      style:TextStyle(
                      fontSize: 25,
                        fontWeight: FontWeight.bold,

                  ),
              ),
            ),
            ),
            const SizedBox(height: 30),
      SizedBox(
      height: 70,
      width: 200,

        ),
  ],
        ),
      ],
        ),
    ),
      ),
    );
  }

}