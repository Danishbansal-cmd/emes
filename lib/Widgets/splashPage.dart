import 'package:emes/Routes/routes.dart';
import 'package:emes/Utils/decision_tree.dart';
import 'package:flutter/material.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    getNextScreen();
  }

  void getNextScreen() async {
    await Future.delayed(
      const Duration(milliseconds: 1500),
      () => Navigator.push(
        context,
        MaterialPageRoute<void>(
          builder: (context) => DecisionTree(),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color.fromARGB(255, 235, 235, 235),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/icon.png",
                scale: 1,
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                "EMES",
                style: TextStyle(fontSize: 22, letterSpacing: 1.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
