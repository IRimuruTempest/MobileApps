import 'package:flutter/material.dart';

class Profile_Page extends StatefulWidget {
  const Profile_Page({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<Profile_Page> {
  String username = "RimuruTempest";
  String pp = "";
  List<int> boyabnei = [4, 11, 7, 9, 16, 30];

  Color colorCalculator(int index) {
    boyabnei.sort();
    if (boyabnei.contains(index)) {
      return Colors.green;
    } else {
      return Colors.blue;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil Sayfası'),
      ),
      body: Column(
        children: [
          Center(
            widthFactor: 60,
            child: Container(
              margin: EdgeInsets.all(16.0),
              child: CircleAvatar(
                radius: 60.0,
                backgroundImage: NetworkImage(pp),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: IconButton(
                    onPressed: () => {},
                    icon: Icon(Icons.edit),
                    iconSize: 20.0,
                  ),
                ),
              ),
            ),
          ),
          TextButton(onPressed: () => {}, child: Text(username)),
          Text("Günlük Aktivite", style: TextStyle(color: Colors.purple)),
          Container(
            width: 300,
            height: 300,
            child: GridView.builder(
              itemCount: 30,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 7,
                mainAxisSpacing: 7,
                crossAxisSpacing: 7,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  color: colorCalculator(index),
                  width: double.infinity,
                  height: double.infinity,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}