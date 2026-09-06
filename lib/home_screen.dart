import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Welcome to the Homework Tracker!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            TextButton(
              child: const Text(
                'Get Started',
                style: TextStyle(color: Colors.green),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}