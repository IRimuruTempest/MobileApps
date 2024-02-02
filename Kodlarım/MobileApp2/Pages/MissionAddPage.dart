import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:timemanagamentpotato/mycolors.dart';
import 'package:masked_text_field/masked_text_field.dart';


class Mission_Add_Page extends StatefulWidget {
  Function(int, String, String) addmission;

  Mission_Add_Page({
    super.key,
    required this.addmission,
  });

  @override
  State<Mission_Add_Page> createState() => _Mission_Add_Page();
}

class _Mission_Add_Page extends State<Mission_Add_Page> {
  String _textfieldstr = '';
  String _textfielddate = DateTime.now().toString().substring(0,DateTime.now().toString().length-4);

  int _pri = 0;

  Color _bordercolor = MyColors().mygrayclose;

  TextEditingController _missioneditor = TextEditingController();

  @override
  void initState() {

    super.initState();

    _missioneditor.text = _textfielddate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Görev Ekle")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 290,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'GÖREV ADI',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors().mygrayclose,
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors().DarkBlue,
                      style: BorderStyle.solid,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                ),
                onChanged: (value) => {
                  setState(() {
                    _textfieldstr = value;
                  })
                },
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 290,
              child: TextField(
                controller: _missioneditor,
                decoration: InputDecoration(
                  labelText: 'SON YAPILMA TARİHİ',
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: MyColors().mygrayclose,
                        style: BorderStyle.solid,
                        width: 3,
                      ),
                      borderRadius: BorderRadius.all(Radius.circular(11))),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                      color: MyColors().DarkBlue,
                      style: BorderStyle.solid,
                      width: 3,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(11)),
                  ),
                ),
                onChanged: (value) => {
                  setState(() {
                    _textfielddate = value;
                  })
                },
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Container(
              width: 290,
              child: Wrap(
                children: [
                  RadioListTile(
                    value: 0,
                    groupValue: _pri,
                    onChanged: (da) => {
                      setState(() {
                        _pri = int.parse(da.toString());
                      })
                    },
                    title: Text(
                      'Düşük Öncelikli',
                      style: TextStyle(
                          color: _pri == 0 ? Colors.green : Colors.black),
                    ),
                    activeColor: Colors.green,
                  ),
                  RadioListTile(
                    value: 1,
                    groupValue: _pri,
                    onChanged: (da) => {
                      setState(() {
                        _pri = int.parse(da.toString());
                      })
                    },
                    title: Text(
                      'Orta Öncelikli',
                      style: TextStyle(
                          color: _pri == 1 ? Colors.orange : Colors.black),
                    ),
                    activeColor: Colors.orange,
                  ),
                  RadioListTile(
                    value: 2,
                    groupValue: _pri,
                    onChanged: (da) => {
                      setState(() {
                        _pri = int.parse(da.toString());
                      })
                    },
                    title: Text(
                      'Yüksek Öncelikli',
                      style: TextStyle(
                          color: _pri == 2 ? Colors.red : Colors.black),
                    ),
                    activeColor: Colors.red,
                  ),
                  Container(
                    height: 25,
                  ),
                  Container(
                    width: 65,
                  ),
                  Container(
                    width: 160,
                    height: 50,
                    child: ElevatedButton(
                      onPressed: () => {
                        if (_textfieldstr.length > 0 &&
                            _textfielddate.length > 0)
                          {
                            widget.addmission(
                                _pri, _textfieldstr, _textfielddate),
                            Navigator.pop(context)
                          },
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: MyColors().mybackgroundcolor,
                        shape: RoundedRectangleBorder(
                            side: BorderSide(color: _bordercolor, width: 5),
                            borderRadius: BorderRadius.circular(12)),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.add, color: Colors.black),
                          SizedBox(
                            width: 7,
                          ),
                          Text(
                            'Görev Ekle',
                            style: TextStyle(
                              color: Colors.black,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}