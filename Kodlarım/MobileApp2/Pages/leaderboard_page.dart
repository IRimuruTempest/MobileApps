import 'package:flutter/material.dart';
import 'package:timemanagamentpotato/Data/LocalDatabase.dart';
import 'package:timemanagamentpotato/mycolors.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math';

class Leaderboard_Page extends StatefulWidget {
  @override
  _LeaderboardState createState() => _LeaderboardState();
}

enum sortSelections { Hours, FinishedTasks, ProductivityScore }

enum CalendarView { day, week, month, year }

sortSelections selectedSort = sortSelections.Hours;

class _LeaderboardState extends State<Leaderboard_Page> {
  @override
  void initState() {
    super.initState();
    Users = LocalDatabase.Users;
  }

  CalendarView calendarView = CalendarView.day;
  List<UserValuesForCalculation> leaderboardData = [];

  Set<sortSelections> selection = <sortSelections>{sortSelections.Hours};

  List<User1> Users = [
  ];
  Widget ppNullOrFill(int index){
    if(Users[index].pp==null){
      return Text("${leaderboardData[index].name[0]}${leaderboardData[index].name[1]}");
    }
    else {
      return Image.network(Users[index].pp.toString());
    }
  }

  Widget MyLeadingCalculation(int index) {
    int ind = index + 1;

    Widget crown;

    if (ind == 1) {
      crown = Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: Icon(
                    FontAwesomeIcons.crown,
                    size: 36,
                    color: Colors.yellow,
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Center(
                    child: Text(
                      '1',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ));
    } else if (ind == 2) {
      crown = Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: Icon(
                    FontAwesomeIcons.crown,
                    size: 36,
                    color: Colors.grey[300],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Center(
                    child: Text(
                      '2',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ));
    } else if (ind == 3) {
      crown = Padding(
          padding: const EdgeInsets.only(right: 0.0),
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Center(
                  child: Icon(
                    FontAwesomeIcons.crown,
                    size: 36,
                    color: Colors.orange[300],
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 5, top: 10),
                child: Center(
                    child: Text(
                      '3',
                      style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                    )),
              )
            ],
          ));
    } else {
      crown = CircleAvatar(
          backgroundColor: Colors.grey,
          radius: 13,
          child: Text(
            ind.toString(),
            style: TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 15),
          ));
    }

    return Padding(
      padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 10),
      child: Container(
        height: 100,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(15.0)),
            boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5.0)]),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(right: 0.0),
                  child: Row(
                    children: <Widget>[
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15.0, right: 25),
                          child: crown,
                        ),
                      ),
                      Align(
                        child: CircleAvatar(
                          backgroundColor: Colors.red.shade800,
                          child: ppNullOrFill(index),
                          radius: 30,
                        ),
                      ),
                      Align(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                padding: const EdgeInsets.only(left: 8.0, top: 5),
                                child: Text(
                                  '${leaderboardData[index].name} ',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  '${ leaderboardData[index].value.toStringAsFixed(2)} ${selectedSort.name} ',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 9,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }


  Widget MyListWievWidget() {
    if (leaderboardData.isEmpty) {
      return Center(child: Text('No users found'));
    } else {
      return ListView.builder(
          itemCount: leaderboardData.length,
          itemBuilder: (context, index) => MyLeadingCalculation(index)
      );
    }
  }

  //filtreleme yapt
  double SecileneGoreDegerHesapla(User1 user) {
    switch (selectedSort) {
      case sortSelections.Hours:
        switch (calendarView) {
          case CalendarView.day:
            return user.hours.isNotEmpty ? user.hours.last : 0;
          case CalendarView.week:
            return user.hours.length >= 7
                ? user.hours.sublist(user.hours.length - 7).reduce((a, b) => a + b)
                : 0;
          case CalendarView.month:
            return user.hours.length >= 30
                ? user.hours.sublist(user.hours.length - 30).reduce((a, b) => a + b)
                : 0;
          case CalendarView.year:
            return user.hours.length >= 360
                ? user.hours.sublist(user.hours.length - 360).reduce((a, b) => a + b)
                : 0;
        }
      case sortSelections.FinishedTasks:
        switch (calendarView) {
          case CalendarView.day:
            return user.finishedTasks.isNotEmpty ? user.finishedTasks.last : 0;
          case CalendarView.week:
            return user.finishedTasks.length >= 7
                ? user.finishedTasks.sublist(user.finishedTasks.length - 7).reduce((a, b) => a + b)
                : 0;
          case CalendarView.month:
            return user.finishedTasks.length >= 30
                ? user.finishedTasks.sublist(user.finishedTasks.length - 30).reduce((a, b) => a + b)
                : 0;
          case CalendarView.year:
            return user.finishedTasks.length >= 360
                ? user.finishedTasks.sublist(user.finishedTasks.length - 360).reduce((a, b) => a + b)
                : 0;
        }

      case sortSelections.ProductivityScore:
        return user.overallProductivityScores;
    }
  }

  void creatingLeaderboardData() {
    leaderboardData.clear();
    for (User1 user in Users) {
      leaderboardData.add(UserValuesForCalculation(user.name, SecileneGoreDegerHesapla(user)));
    }
    leaderboardData.sort((a, b) => b.value.compareTo(a.value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Leaderboard'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Theme(
            data: Theme.of(context)
                .copyWith(hintColor: MyColors().mybackgroundcolor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SegmentedButton<sortSelections>(
                  segments: const <ButtonSegment<sortSelections>>[
                    ButtonSegment<sortSelections>(
                        value: sortSelections.Hours, label: Text('Hour')),
                    ButtonSegment<sortSelections>(
                        value: sortSelections.FinishedTasks,
                        label: Text('Finished Task')),
                    ButtonSegment<sortSelections>(
                        value: sortSelections.ProductivityScore,
                        label: Text('Productivity Score')),
                  ],
                  selected: selection,
                  onSelectionChanged: (Set<sortSelections> newSelection) {
                    setState(() {
                      leaderboardData.clear();
                      selection = newSelection;
                      selectedSort = newSelection.first;
                      for (User1 user in Users) {
                        user.overallProductivityScores =
                            user.getOverallProductivityScore();
                      }
                      creatingLeaderboardData();
                    });
                  },
                ),
                SegmentedButton<CalendarView>(
                  segments: const <ButtonSegment<CalendarView>>[
                    ButtonSegment<CalendarView>(
                        value: CalendarView.day,
                        label: Text('Day'),
                        icon: Icon(Icons.calendar_view_day)),
                    ButtonSegment<CalendarView>(
                        value: CalendarView.week,
                        label: Text('Week'),
                        icon: Icon(Icons.calendar_view_week)),
                    ButtonSegment<CalendarView>(
                        value: CalendarView.month,
                        label: Text('Month'),
                        icon: Icon(Icons.calendar_view_month)),
                    ButtonSegment<CalendarView>(
                        value: CalendarView.year,
                        label: Text('Year'),
                        icon: Icon(Icons.calendar_today)),
                  ],
                  selected: <CalendarView>{calendarView},
                  onSelectionChanged: (Set<CalendarView> newSelection) {
                    setState(
                          () {
                        leaderboardData.clear();
                        calendarView = newSelection.first;
                        for (User1 user in Users) {
                          user.overallProductivityScores =
                              user.getOverallProductivityScore();
                        }
                        creatingLeaderboardData();
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: MyListWievWidget(),
    );
  }
}

class User1 {
  String name;
  List hours;
  List finishedTasks;
  double overallProductivityScores = 0;
  String? pp;

  User1({required this.name, required this.hours, required this.finishedTasks});

  double getOverallProductivityScore() {
    double totalHours = hours.isNotEmpty ? hours.reduce((a, b) => a + b) : 0;
    double totalFinishedTasks =
    finishedTasks.isNotEmpty ? finishedTasks.reduce((a, b) => a + b) : 0;

    return totalHours != 0 ? (totalFinishedTasks / totalHours) * 100 : 0;
  }
}

class UserValuesForCalculation {
  String name;
  double value;

  UserValuesForCalculation(this.name, this.value);
}