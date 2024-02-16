import 'package:flutter/material.dart';
import 'package:mysqlengjpn/AnimePage.dart';
import 'package:mysqlengjpn/BooksPage.dart';
import 'package:mysqlengjpn/EmptyButton.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'EnglishDictionaryPage.dart';
import 'MoneyManagement.dart';
import 'HobbiesPage.dart';
import 'package:mysqlengjpn/LoginPage.dart';

class MainMenuPage extends StatefulWidget {
  const MainMenuPage({super.key});

  _MainMenuPage createState() => _MainMenuPage();
}

class _MainMenuPage extends State<MainMenuPage> {
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
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(5),
          children: [
            InkWell(
              child: Container(
                child:
                    Image(image: AssetImage('assets/EnglishButtonImage.png')),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => EnglishDictionaryPage(),
                  ),
                );
              },
            ),
            InkWell(
              child: Container(
                child: Image(image: AssetImage('assets/AnimeButtonImage.png')),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const AnimePage()));
              },
            ),
            InkWell(
              child: Container(
                child: Image(image: AssetImage('assets/BookButtonImage.png')),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const BooksPage()));
              },
            ),
            InkWell(
              child: Container(
                child: Image(image: AssetImage('assets/MoneyButtonImage.png')),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>  MoneyManagementPage()));
              },
            ),
            InkWell(
              child: Container(
                child: Image(
                    image: AssetImage('assets/ZinciriKirmaButtonImage.png')),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HobbiesPage()));
              },
            ),
            InkWell(
              child: Container(
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                        colors: [Color(0xffe30909), Color(0xff0b9cc8)])),
              ),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const EmptyButton()));
              },
            ),
          ],
        ),
      ),
    );
  }
}
