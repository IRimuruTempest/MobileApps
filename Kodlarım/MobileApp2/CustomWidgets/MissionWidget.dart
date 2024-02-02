import 'package:flutter/material.dart';
import 'package:timemanagamentpotato/Data/LocalDatabase.dart';
import 'dart:core';
import 'dart:async';
import 'package:timemanagamentpotato/Pages/study_page.dart';

class MissionWidget extends StatefulWidget {
  int priority, index;
  String remaining_time, mission_name;
  bool is_finished;
  Function onChanged;
  final void Function(int) priorityChanged0;
  final void Function(int) priorityChanged1;
  final void Function(int) priorityChanged2;
  final void Function(int) deleteMission;

  MissionWidget(
      {super.key,
      required this.priority,
      required this.is_finished,
      required this.mission_name,
      required this.remaining_time,
      required this.onChanged,
      required this.index,
      required this.priorityChanged0,
      required this.priorityChanged1,
      required this.priorityChanged2,
      required this.deleteMission});

  @override
  State<MissionWidget> createState() => _MissionWidget();
}

class _MissionWidget extends State<MissionWidget> {
  void _onchanged(val) {
    widget.onChanged(widget.index);
  }

  List<Color> _prioritycolors = [
    //0,1,2
    Colors.green,
    Colors.orange,
    Colors.red
  ];

  List<String> _prioritystrings = [
    'düşük öncelik',
    'Orta Öncelik',
    'YÜKSEK ÖNCELİK'
  ];

  BorderSide _bsd() {
    return BorderSide(
        color: _prioritycolors[widget.priority],
        width: 10,
        style: BorderStyle.solid);
  }

  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        _formatTimeText = _formatTimefunc();
      });
    });
  }

  @override
  void dispose() {
    // Timer'ı iptal et
    _timer.cancel();
    super.dispose();
  }

  int _grval = 1;

  String _formatTimeText = '';

  String _formatTimefunc() {
    String ck = widget.remaining_time;

    DateTime before = DateTime.parse(ck);
    DateTime now = DateTime.now();
    Duration fark = before.difference(now);

    if (!fark.isNegative) {
      int kalanGun = fark.inDays;
      int kalanSaat = fark.inHours.remainder(24);
      int kalanDakika = fark.inMinutes.remainder(60);
      int kalanSaniye = fark.inSeconds.remainder(60);

      if (kalanGun >= 3) {
        ck = 'Kalan Süre: $kalanGun gün';
      } else if (kalanGun >= 1) {
        ck = 'Kalan Süre: $kalanGun gün $kalanSaat saat';
      } else if (kalanGun == 0 && kalanSaat >= 1) {
        ck = 'Kalan Süre: $kalanSaat saat $kalanDakika dakika';
      } else if (kalanGun == 0 && kalanSaat <= 0) {
        ck = 'Kalan Süre: $kalanDakika dakika $kalanSaniye saniye';
      }
    } else {
      ck = 'SÜRESİ DOLMUŞ';
    }
    return ck;
  }

  @override
  Widget build(BuildContext context) {
    setState(() {
      _formatTimeText = _formatTimefunc();
    });

    return ListTile(
      leading: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 5,
          ),
          Container(
            padding: EdgeInsets.zero,
            width: 30,
            height: 30,
            child: Checkbox(
              onChanged: _onchanged,
              value: widget.is_finished,
              checkColor: Colors.white,
              splashRadius: 15,
              side:
                  BorderSide(color: _prioritycolors[widget.priority], width: 2),
              activeColor: _prioritycolors[widget.priority],
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          ),
          Container(
            width: 30,
            height: 30,
            child: IconButton(
              disabledColor: Colors.grey,
              onPressed: widget.is_finished
                  ? null
                  : () => {
                        LocalDatabase.ActiveMission = [
                          widget.priority,
                          widget.is_finished,
                          widget.mission_name,
                          widget.remaining_time
                        ],
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Study_Page(),
                          ),
                        ),
                      },
              icon: Transform.scale(
                child: Icon(
                  Icons.book,
                  color: widget.is_finished
                      ? Colors.grey
                      : _prioritycolors[widget.priority],
                  size: 15,
                ),
                scale: 1.5,
              ),
              tooltip: 'Özel Çalış',
            ),
          ),
          Container(
            width: 30,
            height: 30,
            child: IconButton(
              onPressed: () => {
                showDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      title: Text(
                        'Görevi sil',
                        textAlign: TextAlign.center,
                      ),
                      content: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                              text: '${widget.mission_name} ',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12)),
                          TextSpan(
                              text:
                                  'isimli görevi silmek istediğinizden emin misiniz?',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12))
                        ]),
                      ),
                      actionsAlignment: MainAxisAlignment.spaceEvenly,
                      contentPadding: EdgeInsets.all(25),
                      actions: [
                        TextButton(
                          onPressed: () => {
                            Navigator.of(context).pop(),
                            widget.deleteMission(widget.index)
                          },
                          child: Text(
                            'Evet',
                            style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(35, 15, 35, 15))),
                        ),
                        TextButton(
                          onPressed: () => {Navigator.of(context).pop()},
                          child: Text(
                            'Hayır',
                            style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                fontSize: 16),
                          ),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  EdgeInsets.fromLTRB(55, 25, 55, 25))),
                        )
                      ],
                      titleTextStyle: TextStyle(
                          color: Colors.blue,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                      backgroundColor: Colors.white,
                    );
                  },
                ),
              },
              tooltip: 'Sil',
              icon: Transform.scale(
                child: Icon(
                  Icons.delete,
                  size: 15,
                ),
                scale: 1.7,
              ),
              color: _prioritycolors[widget.priority],
            ),
          )
        ],
      ),
      tileColor: Color.fromRGBO(
          _prioritycolors[widget.priority].red,
          _prioritycolors[widget.priority].green,
          _prioritycolors[widget.priority].blue,
          0.2),
      title: Text(
        widget.mission_name,
        textAlign: TextAlign.center,
        style: widget.is_finished
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 18,
                decorationColor: _prioritycolors[widget.priority],
                decorationThickness: 3,
              )
            : TextStyle(fontSize: 18),
      ),
      trailing: SafeArea(
        child: Container(
            child: Column(
          children: [
            Container(
              child: Text(
                _prioritystrings[widget.priority],
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: widget.is_finished
                      ? Colors.grey
                      : _prioritycolors[widget.priority],
                  fontSize: 10,
                  fontWeight: FontWeight.bold,
                ),
              ),
              width: 120,
              height: 12,
              alignment: Alignment.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    onPressed: widget.is_finished
                        ? null
                        : () => {widget.priorityChanged0(widget.index)},
                    icon: Icon(
                      Icons.circle_outlined,
                      color: widget.is_finished ? Colors.grey : Colors.green,
                    ),
                    padding: EdgeInsets.zero,
                    isSelected: widget.priority == 0 ? true : false,
                    selectedIcon: Icon(
                      Icons.circle,
                      color: widget.is_finished ? Colors.grey : Colors.green,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    onPressed: widget.is_finished
                        ? null
                        : () => {widget.priorityChanged1(widget.index)},
                    icon: Icon(
                      Icons.circle_outlined,
                      color: widget.is_finished ? Colors.grey : Colors.orange,
                    ),
                    padding: EdgeInsets.zero,
                    isSelected: widget.priority == 1 ? true : false,
                    selectedIcon: Icon(
                      Icons.circle,
                      color: widget.is_finished ? Colors.grey : Colors.orange,
                    ),
                  ),
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    onPressed: widget.is_finished
                        ? null
                        : () => {widget.priorityChanged2(widget.index)},
                    icon: Icon(
                      Icons.circle_outlined,
                      color: widget.is_finished ? Colors.grey : Colors.red,
                    ),
                    padding: EdgeInsets.zero,
                    isSelected: widget.priority == 2 ? true : false,
                    selectedIcon: Icon(
                      Icons.circle,
                      color: widget.is_finished ? Colors.grey : Colors.red,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
      subtitle: Text(
        '${_formatTimeText}',
        textAlign: TextAlign.center,
        style: widget.is_finished
            ? TextStyle(
                decoration: TextDecoration.lineThrough,
                fontSize: 11,
                decorationColor: _prioritycolors[widget.priority],
                decorationThickness: 4)
            : TextStyle(fontSize: 11),
      ),
      contentPadding: EdgeInsets.fromLTRB(0, 0, 0, 0),
      shape: RoundedRectangleBorder(
        side: _bsd(),
        borderRadius: BorderRadius.circular(55),
      ),
    );
  }
}
