import 'package:flutter/material.dart';

import 'MainMenuPage.dart';

class EmptyButton extends StatefulWidget {
  const EmptyButton({super.key});
  _EmptyButton createState() => _EmptyButton();
}

class _EmptyButton extends State<EmptyButton> {
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
            Center(child: Text("QR Code")),
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
          ],
        ),
      ),
    );
  }
}
