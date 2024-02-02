import 'package:flutter/material.dart';

import 'MainMenuPage.dart';

class KeepGoingSteadily extends StatefulWidget {
  const KeepGoingSteadily({super.key});

  _KeepGoingSteadily createState() => _KeepGoingSteadily();
}

class _KeepGoingSteadily extends State<KeepGoingSteadily> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue,
              Colors.purple,
            ],
          ),
        ),
        child: Column(
          children: [
            InkWell(
              child: Container(
                child: Icon(Icons.four_k),
                width: 100,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(colors: [Colors.cyan, Colors.deepPurple])),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainMenuPage()));
              },
            ),
            Center(child: Text("KeepGoingSteadily")),
          ],
        ),
      ),
    );
  }
}
