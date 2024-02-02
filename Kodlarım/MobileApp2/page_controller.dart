import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'Pages/main_menu_page.dart';
import 'Pages/leaderboard_page.dart';
import 'Pages/chart_page.dart';
import 'Pages/calendar_page.dart';
import 'Pages/study_page.dart';
import 'Pages/diary_page.dart';
import 'mycolors.dart';
import 'Pages/profile_page.dart';

class Page_Controller extends StatefulWidget {
  Page_Controller({super.key});

  @override
  State<Page_Controller> createState() => _Page_ControllerState();
}

class _Page_ControllerState extends State<Page_Controller> {
  int _selectedIndex = 0;

  final List _pages = [
    Main_Menu_Page(),
    Leaderboard_Page(),
    Chart_Page(),
    Calendar_Page(),
    Diary_Page(),
    Profile_Page()
  ];
  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _navigateBottomBar,
        backgroundColor: Colors.white,
        unselectedItemColor: MyColors().mygrayclose,
        selectedItemColor: MyColors().DarkBlue, //okunurluk için BNBSelectedItemColor değiştirildi
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.leaderboard), label: "Leaderboard"),
          BottomNavigationBarItem(
              icon: Icon(Icons.pie_chart_sharp), label: "Chart"),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: "Calendar"),
          BottomNavigationBarItem(
              icon: Icon(Icons.library_books), label: "Diary"),
          BottomNavigationBarItem(icon: Icon(Icons.person_2),label: "Profile")
        ],
      ),
    );
  }
}
