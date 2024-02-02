import 'package:flutter/material.dart';
import 'package:mysqlengjpn/MainMenuPage.dart';

class MoneyManagementPage extends StatefulWidget {
  const MoneyManagementPage({super.key});

  _MoneyManagementPage createState() => _MoneyManagementPage();
}

class _MoneyManagementPage extends State<MoneyManagementPage> {
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
            Text("Money Management Page"),
            InkWell(
              child: Container(
                child: Icon(Icons.four_k),
                width: 100,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.deepPurple])),
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
