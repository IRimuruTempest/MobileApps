import 'dart:math';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:timemanagamentpotato/Data/LocalDatabase.dart';

class Chart_Page extends StatefulWidget {
  @override
  _StatisticsState createState() => _StatisticsState();
}

enum sortSelections { Hours, FinishedTasks, ProductivityScore }

enum Calendar { day, week, month, year }

class _StatisticsState extends State<Chart_Page> {
  final Users = [
    User(
      name: "Ahmet",
      hours: [
        10,
        20,
        30,
        40,
        50,
        60,
        70,
        80,
        90,
        100,
      ],
      finishedTasks: [
        20,
        30,
        40,
        70,
        60,
        24,
        45,
        40,
        45,
        50,
      ],
    ),
  ];

  List<double> verimlilikGorunumu(User user) {
    switch (selectedSort) {
      case sortSelections.Hours:
        switch (calendarView) {
          case Calendar.day:
            return user.hours.sublist(0, 1);
          case Calendar.week:
            return user.hours.sublist(user.hours.length - 7, user.hours.length);

          case Calendar.month:
            return user.hours
                .sublist(user.hours.length - 30, user.hours.length);

          case Calendar.year:
            if (user.hours.length >= 360) {
              List<double> toplamVerimlilik = [];
              for (int i = 0; i < 12; i++) {
                double toplam = 0;
                for (int j = i * 30; j < (i + 1) * 30; j++) {
                  toplam += user.hours[j];
                }
                toplamVerimlilik.add(toplam);
              }
              return toplamVerimlilik;
            } else {
              return user.hours;
            }
        }
      case sortSelections.FinishedTasks:
        switch (calendarView) {
          case Calendar.day:
            return user.finishedTasks.sublist(0, 1);
          case Calendar.week:
            return user.finishedTasks.sublist(
                user.finishedTasks.length - 7, user.finishedTasks.length);

          case Calendar.month:
            return user.finishedTasks.sublist(
                user.finishedTasks.length - 30, user.finishedTasks.length);

          case Calendar.year:
            if (user.finishedTasks.length >= 360) {
              List<double> toplamVerimlilik = [];
              for (int i = 0; i < 12; i++) {
                double toplam = 0;
                for (int j = i * 30; j < (i + 1) * 30; j++) {
                  toplam += user.finishedTasks[j];
                }
                toplamVerimlilik.add(toplam);
              }
              return toplamVerimlilik;
            } else {
              return user.finishedTasks;
            }
        }
      case sortSelections.ProductivityScore:
        switch (calendarView) {
          case Calendar.day:
            return user.productivityScore.sublist(0, 1);

          case Calendar.week:
            return user.productivityScore.sublist(
                user.productivityScore.length - 7,
                user.productivityScore.length);

          case Calendar.month:
            return user.productivityScore.sublist(
                user.productivityScore.length - 30,
                user.productivityScore.length);

          case Calendar.year:
            if (user.productivityScore.length >= 360) {
              List<double> toplamVerimlilik = [];
              for (int i = 0; i < 12; i++) {
                double toplam = 0;
                for (int j = i * 30; j < (i + 1) * 30; j++) {
                  toplam += user.productivityScore[j];
                }
                toplamVerimlilik.add(toplam);
              }
              return toplamVerimlilik;
            } else {
              return user.productivityScore;
            }
        }
    }
  }

  List<BarChartGroupData> getBarChartGroupData(User user) {
    List<double> verimlilikVerileri = verimlilikGorunumu(user);
    verimlilikHesapla(user);
    for(int i=0; i< 360; i++){
      Users[0].finishedTasks.add(Random().nextDouble()*100);
      Users[0].hours.add(Random().nextDouble()*100);
    }

    List<BarChartGroupData> barGroups = [];
    for (int i = 0; i < verimlilikVerileri.length; i++) {
      barGroups.add(
        BarChartGroupData(
          x: i + 1,
          barRods: [
            BarChartRodData(
              fromY: 0,
              toY: verimlilikVerileri[i],
              width: 8,
              color: Colors.cyan,
            ),
          ],
        ),
      );
    }

    return barGroups;
  }

  List<double> verimlilikHesapla(User user) {
    for (int i = 0; i < user.hours.length; i++) {
      user.productivityScore.add((user.finishedTasks[i] / user.hours[i] * 100));
    }
    return user.productivityScore;
  }

  double productivityScore = 0;
  Calendar calendarView = Calendar.day;
  sortSelections selectedSort = sortSelections.Hours;
  Set<sortSelections> selection = <sortSelections>{sortSelections.Hours};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Statistics'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(80.0),
          child: Theme(
            data: Theme.of(context).copyWith(hintColor: Colors.white),
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
                    setState(
                      () {
                        selectedSort = newSelection.first;
                        selection = newSelection;
                      },
                    );
                  },
                ),
                SegmentedButton<Calendar>(
                  segments: const <ButtonSegment<Calendar>>[
                    ButtonSegment<Calendar>(
                        value: Calendar.day,
                        label: Text('Day'),
                        icon: Icon(Icons.calendar_view_day)),
                    ButtonSegment<Calendar>(
                        value: Calendar.week,
                        label: Text('Week'),
                        icon: Icon(Icons.calendar_view_week)),
                    ButtonSegment<Calendar>(
                        value: Calendar.month,
                        label: Text('Month'),
                        icon: Icon(Icons.calendar_view_month)),
                    ButtonSegment<Calendar>(
                        value: Calendar.year,
                        label: Text('Year'),
                        icon: Icon(Icons.calendar_today)),
                  ],
                  selected: <Calendar>{calendarView},
                  onSelectionChanged: (Set<Calendar> newSelection) {
                    setState(
                      () {
                        calendarView = newSelection.first;
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: AspectRatio(
                aspectRatio: 1,
                child: BarChart(
                  BarChartData(
                      borderData: FlBorderData(
                        border: const Border(
                            top: BorderSide.none,
                            right: BorderSide.none,
                            left: BorderSide(width: 1),
                            bottom: BorderSide(width: 1)),
                      ),
                      groupsSpace: 10,
                      barGroups: getBarChartGroupData(Users[0])),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class User {
  String name;
  List<double> hours;
  List<double> finishedTasks;
  List<double> productivityScore = [];

  User({required this.name, required this.hours, required this.finishedTasks});
}
