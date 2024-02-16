import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'MainMenuPage.dart';

class BooksPage extends StatefulWidget {
  const BooksPage({super.key});

  _BooksPage createState() => _BooksPage();
}

class _BooksPage extends State<BooksPage> {
  TextEditingController searchController = TextEditingController();
  String? dropdownValue;

  List<Map<String, dynamic>> result = [
    {"book_part": "asd"}
  ];
  List<Map<String, dynamic>> resulttxt = [
    {"book_text": "asd"}
  ];

  @override
  Widget build(BuildContext context) {
    int currentUser = Provider.of<UserProvider>(context).currentUser;
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
                      controller: searchController,
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
              IconButton(
                  onPressed: () {
                    fetchDataFromDatabase(currentUser);
                  },
                  icon: Icon(Icons.search))
            ],
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
              child: DropdownButton<String>(
                borderRadius: BorderRadius.circular(20.0),
                hint: const Text('Select book part'),
                value: dropdownValue,
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                    bookReturnText(currentUser);
                  });
                },
                items: result
                    .map<DropdownMenuItem<String>>((Map<String, dynamic> item) {
                  return DropdownMenuItem<String>(
                    value: item["book_part"],
                    child: Text(item["book_part"]),
                  );
                }).toList(),
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
            child: ListView(
              children: [Text(resulttxt[0]["book_text"])],
            ),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Color(0xff570bd2), Color(0xff0bd26e)])),
          )
        ]),
      ),
    );
  }

  void fetchDataFromDatabase(int user) async {
    final String url = "http://192.168.0.28/bookfetchdata.php";

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'currentUserId': user.toString(),
        'BookName': searchController.text
      },
    );

    if (response.statusCode == 200) {
      print("status code 200");
      if (response.body.isNotEmpty) {
        List<Map<String, dynamic>> data =
            (json.decode(response.body) as List<dynamic>)
                .cast<Map<String, dynamic>>();
        setState(() {
          result = data;
        });
        // Process the data as needed
      } else {
        print("Empty response received from the server");
      }
      // Use the data as needed
    } else {
      print("Failed to fetch data from the server");
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }

  void bookReturnText(int user) async {
    final String url = "http://192.168.0.28/bookreturntext.php";

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'currentUserId': user.toString(),
        'BookName': searchController.text,
        'BookPart': dropdownValue,
      },
    );

    if (response.statusCode == 200) {
      print("status code 200");
      if (response.body.isNotEmpty) {
        List<Map<String, dynamic>> data =
            (json.decode(response.body) as List<dynamic>)
                .cast<Map<String, dynamic>>();
        setState(() {
          resulttxt = data;
        });
        // Process the data as needed
      } else {
        print("Empty response received from the server");
      }
      // Use the data as needed
    } else {
      print("Failed to fetch data from the server");
      print("Response Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }
}
