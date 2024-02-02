import 'package:flutter/material.dart';
import 'package:timemanagamentpotato/Data/LocalDatabase.dart';
import 'package:timemanagamentpotato/mycolors.dart';
import 'dart:async';
import 'package:timemanagamentpotato/CustomWidgets/LoadingWidget.dart';
import 'dart:math';

class Study_Page extends StatefulWidget {
  Study_Page({super.key});

  @override
  State<Study_Page> createState() => _Study_Page();
}

class _Study_Page extends State<Study_Page> {
  //late Image _bck = Image.asset('landscape.jpg');

  List<Image> _bck = [];

  bool _loading = true;

  String _liveremainingtime = '';

  bool _isStudy = false;

  bool _isBreak = false;

  late Timer _timer;

  int _Minute = 25, _Second = 0;

  int _pomodoroCount = 0;

  int _breakCount = 0;

  bool _multipleIMG = false;

  var rnd = Random();

  int _winningpic = 0;

  String _formatTime() {
    String ck = '';

    if (_Minute < 10)
      ck += '0$_Minute:';
    else
      ck += '$_Minute:';

    if (_Second < 10)
      ck += '0$_Second';
    else
      ck += '$_Second';

    return ck;
  }

  double _lvalue = 1.0; //init

  void _loadingValue() {
    int cursec = (_Minute * 60) + _Second;
    int totsec;

    if (!_isBreak) {
      ///totaltime = 25 minute
      totsec = 25 * 60;
    } else {
      ///totaltime = 5 minute
      totsec = 5 * 60;
    }
    setState(() {
      _lvalue = cursec / totsec;
    });
  }

  void _spendTime() {

    if (_Second == 0 && _Minute == 0 && _isStudy && !_isBreak) {
      setState(() {
        _isBreak = true;

        _pomodoroCount++;

        _lvalue = 1;
        _Minute = 5;
        _Second = 1;


      });

      if (_pomodoroCount % 4 == 0) setState(() {
        _Minute = 30;
      });

    }
    else if (_Second == 0 && _Minute == 0 && _isStudy && _isBreak) {
      setState(() {
        _isBreak = false;

        _breakCount++;

        _lvalue = 1;
        _Minute = 25;
        _Second = 1;


      });
    }

    if (_Second == 0 && _Minute > 0) {
      setState(() {
        _Second = 59;
        _Minute--;
      });
    } else if (_Second > 0) {
      setState(() {
        _Second--;
      });
    }

  }

  @override
  void initState() {
    super.initState();

    if (_multipleIMG) _winningpic = rnd.nextInt(4);

    _bck.add(Image.asset('assets/landscape.jpg'));
    _bck.add(Image.asset('assets/miami.jpg'));
    _bck.add(Image.asset('assets/losangeles.jpg'));
    _bck.add(Image.asset('assets/istanbul.jpg'));

    _loadingValue();

    _bck[_winningpic]
        .image
        .resolve(ImageConfiguration())
        .addListener(ImageStreamListener(
      (info, sync) {
        if (mounted) {
          setState(() {
            _loading = false;
          });
        }
      },
    ));

    _timer = Timer.periodic(Duration(seconds: 1), (as) {
      if (_isStudy) _spendTime();
      _loadingValue();
      String ck = '';
      if (LocalDatabase.formatTimefunc(LocalDatabase.ActiveMission[3])
              .toString()
              .substring(12) ==
          'Ş') {
        ck = 'SÜRESİ DOLMUŞ';
      } else {
        ck = LocalDatabase.formatTimefunc(LocalDatabase.ActiveMission[3])
            .toString()
            .substring(12);
      }
      setState(() {
        _liveremainingtime = ck;
      });
    });
  }

  @override
  void didChangeDependencies() {
    precacheImage(_bck[_winningpic].image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _liveremainingtime =
        LocalDatabase.formatTimefunc(LocalDatabase.ActiveMission[3])
            .toString()
            .substring(12);

    return _loading
        ? LoadingWidget()
        : Scaffold(
            extendBodyBehindAppBar: true,
            appBar: AppBar(
              leading: Container(),
              title: Text(
                'ÇALIŞILAN GÖREV',
                style: TextStyle(
                  color: Colors.cyan,
                  fontWeight: FontWeight.bold,
                ),
              ),
              leadingWidth: 0,
              backgroundColor: Colors.transparent,
              elevation: 0,
            ),
            body: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: _bck[_winningpic].image,
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    top: 95,
                    left: 12.5,
                    child: Container(
                      //margin: EdgeInsets.fromLTRB(25, 0, 0, 25),
                      alignment: Alignment.center,
                      width: MediaQuery.of(context).size.width - 25,
                      height: 30,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                          width: 1,
                          color: Colors.redAccent,
                        ),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '              ${LocalDatabase.ActiveMission[2]}',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                          Text(
                            '$_liveremainingtime              ',
                            style: TextStyle(
                              color: Colors.redAccent,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 140,
                    top: 145,
                    child: Container(
                      width: 280,
                      height: 60,
                      child: Text(
                        _isBreak ? 'MOLA' : 'ODAKLAN',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _isBreak
                                ? Colors.purpleAccent
                                : Colors.lightGreenAccent,
                            fontSize: 54,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    ///LOADING BAR
                    left: MediaQuery.of(context).size.width / 2 - 110,
                    top: 260,
                    child: Container(
                      width: 220,
                      height: 220,
                      child: CircularProgressIndicator(
                        value: _lvalue,
                        color: _isBreak
                            ? Colors.purpleAccent
                            : Colors.lightBlueAccent,
                        strokeWidth: 8,
                      ),
                    ),
                  ),
                  Positioned(
                    ///LOADING BAR
                    left: MediaQuery.of(context).size.width / 2 - 60,
                    top: 330,
                    child: Container(
                      width: 120,
                      height: 40,
                      child: Text(
                        _formatTime(),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: _isBreak
                                ? Colors.purpleAccent
                                : Colors.lightBlueAccent,
                            fontSize: 32,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 150,
                    top: 500,
                    child: _isBreak
                        ? Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            transformAlignment: Alignment.center,
                            child: IconButton(
                              icon: Icon(Icons.next_plan_outlined),
                              alignment: Alignment.center,
                              iconSize: 80,
                              color: Colors.purpleAccent,
                              onPressed: () => setState(() {
                                _isBreak = !_isBreak;
                                _Minute = 25;
                                _Second = 0;
                                _lvalue = 1;
                              }),
                              tooltip: _isStudy
                                  ? _isBreak
                                      ? 'Molayı Geç'
                                      : 'Çalışmayı Duraklat'
                                  : 'Çalışmayı Sürdür',
                            ),
                          )
                        : Container(
                            width: 100,
                            height: 100,
                            alignment: Alignment.center,
                            transformAlignment: Alignment.center,
                            child: IconButton(
                              selectedIcon: Icon(Icons.pause_circle_outline),
                              isSelected: _isStudy,
                              icon: Icon(Icons.play_circle_outlined),
                              alignment: Alignment.center,
                              iconSize: 80,
                              color: Colors.lightGreenAccent,
                              onPressed: () => setState(() {
                                _isStudy = !_isStudy;
                              }),
                              tooltip: _isStudy
                                  ? 'Çalışmayı Duraklat'
                                  : 'Çalışmayı Sürdür',
                            ),
                          ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 + 50,
                    top: 500,
                    child: Container(
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      transformAlignment: Alignment.center,
                      child: IconButton(
                        icon: Icon(Icons.stop_circle_outlined),
                        alignment: Alignment.center,
                        iconSize: 80,
                        color: _isBreak
                            ? Colors.purpleAccent
                            : Colors.lightGreenAccent,
                        onPressed: () => {Navigator.of(context).pop()},
                        tooltip: 'Çalışmayı Bitir',
                      ),
                    ),
                  ),
                  Positioned(
                    left: MediaQuery.of(context).size.width / 2 - 75,
                    top: 650,
                    child: Container(
                      alignment: Alignment.center,
                      transformAlignment: Alignment.center,
                      width: 150,
                      height: 60,
                      child: Text(
                        _isBreak ? '${_breakCount + 1}. mola' : '${_pomodoroCount + 1}. pomodoro',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isBreak ? Colors.purpleAccent : Colors.lightGreenAccent,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}

/*



 */
