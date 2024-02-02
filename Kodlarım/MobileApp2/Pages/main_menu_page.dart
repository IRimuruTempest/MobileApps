import 'package:flutter/material.dart';
import 'package:timemanagamentpotato/Data/EDatabase.dart';
import 'package:timemanagamentpotato/Data/LocalDatabase.dart';
import 'package:timemanagamentpotato/mycolors.dart';

import 'package:timemanagamentpotato/CustomWidgets/MissionWidget.dart';
import 'package:timemanagamentpotato/Pages/MissionAddPage.dart';

class Main_Menu_Page extends StatefulWidget {
  const Main_Menu_Page({super.key});

  @override
  State<Main_Menu_Page> createState() => _Main_Menu_Page();
}

class _Main_Menu_Page extends State<Main_Menu_Page> {
  List<List> _missions = [];

  String userInput = '';
  int? _priority = 0;
  late Image _bckg;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  void _missioncompletestatus(index) {
    setState(() {
      _missions[index][1] = !_missions[index][1];
    });
    LocalDatabase.UpdateMissions(_missions);
  }

  void _prioritychange0(int index) {
    setState(() {
      _missions[index][0] = 0;
    });
    LocalDatabase.UpdateMissions(_missions);
  }

  void _prioritychange1(int index) {
    setState(() {
      _missions[index][0] = 1;
    });
    LocalDatabase.UpdateMissions(_missions);
  }

  void _prioritychange2(int index) {
    setState(() {
      _missions[index][0] = 2;
    });
    LocalDatabase.UpdateMissions(_missions);
  }

  void _deletemission(int index) {
    setState(() {
      _missions.removeAt(index);
    });
    LocalDatabase.UpdateMissions(_missions);
  }

  _BodyContent() {
    _missions = LocalDatabase.GetMissions();
    if (_missions.length == 0) {
      return Center(
        child: Text(
          "Henüz bir göreviniz yok. Görev oluşturmak için sağ alttaki butonu kullanabilirsiniz.",
          textAlign: TextAlign.center,
          style: TextStyle(
            color: MyColors().DarkBlue,
            fontSize: 20,
          ),
        ),
      );
    } else {
      return Container(
        alignment: Alignment.center,
        child: Scrollbar(
          trackVisibility: true,
          thumbVisibility: true,
          thickness: 5,
          radius: Radius.circular(9),
          interactive: true,
          child: ListView.builder(
            padding: EdgeInsets.all(33),
            itemCount: _missions.length,
            itemBuilder: (BuildContext context, int index) {
              return Column(
                children: [
                  MissionWidget(
                    priority: int.parse(_missions[index][0].toString()),
                    is_finished: bool.parse(_missions[index][1].toString()),
                    mission_name: _missions[index][2].toString(),
                    remaining_time: _missions[index][3].toString(),
                    index: index,
                    onChanged: (val) => {_missioncompletestatus(index)},
                    priorityChanged0: (ind) => {_prioritychange0(index)},
                    priorityChanged1: (ind) => {_prioritychange1(index)},
                    priorityChanged2: (ind) => {_prioritychange2(index)},
                    deleteMission: (ind) => {_deletemission(index)},
                  ),
                  SizedBox(
                    height: 20,
                  )
                ],
              );
            },
          ),
        ),
      );
    }
  }

  Color _btcolor() {
    Color cr = Color.fromARGB(255, MyColors().mygrayclose.red,
        MyColors().mygrayclose.green, MyColors().mygrayclose.blue);
    return cr;
  }

  void _AddMission(int pri, String missionname, String time) {

    setState(() {
      _missions.add([pri, false, missionname, time]);
    });
    //local updates
    LocalDatabase.UpdateMissions(_missions);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main Menu"),
      ),
      body: _BodyContent(),
      floatingActionButton: FloatingActionButton(
        onPressed: () => {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (ctx) => Mission_Add_Page(
                addmission: _AddMission,
              ),
            ),
          ),
        },
        tooltip: "Görev ekle",
        shape: CircleBorder(
            side: BorderSide(color: _btcolor()), eccentricity: 0.9),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: _btcolor(),
      ),
    );
  }
}
