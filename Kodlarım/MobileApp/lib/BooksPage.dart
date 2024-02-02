import 'package:flutter/material.dart';

import 'MainMenuPage.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  _BooksPage createState() => _BooksPage();
}

class _BooksPage extends State<BooksPage> {
  String? dropdownValue;

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
        child: ListView(children: [
          Center(child: Text("BooksPage")),
          Row(
            children: [
              Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'search term',
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                width: 350,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xff06d1ec), Color(0xff83f202)])),
              ),
              IconButton(onPressed: () {}, icon: Icon(Icons.search))
            ],
          ),
          Container(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                child: TextField(
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Book name',
                  ),
                ),
              ),
            ),
            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
            width: 350,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Color(0xff06d1ec), Color(0xff83f202)])),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
            width: 350,
            height: 50,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: LinearGradient(
                    colors: [Color(0xff06d1ec), Color(0xff83f202)])),
            child: Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  border: InputBorder.none,
                ),
                borderRadius: BorderRadius.circular(20.0),
                hint: const Text('Select book part'),
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(
                    () {
                      dropdownValue = newValue!;
                    },
                  );
                },
                items: <String>['Apple', 'Mango', 'Banana', 'Peach']
                    .map<DropdownMenuItem<String>>(
                  (String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value),
                    );
                  },
                ).toList(),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Container(
                  child: Center(child: Icon(Icons.done)),
                  margin: EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
              ),
              Center(
                child: Container(
                  child: Center(child: Icon(Icons.delete)),
                  margin: EdgeInsets.all(10),
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
              ),
              InkWell(
                child: Container(
                  child: Icon(Icons.four_k),
                  width: 60,
                  height: 60,
                  margin: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
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
          Container(
            margin: EdgeInsets.all(15),
            width: 400,
            height: 400,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff570bd2), Color(0xff0bd26e)])),
          )
        ]),
      ),
    );
  }
}
