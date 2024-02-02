import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'MainMenuPage.dart';
import 'package:http/http.dart' as http;

class EnglishDictionaryPage extends StatefulWidget {
  const EnglishDictionaryPage({super.key});

  @override
  State<EnglishDictionaryPage> createState() => _EnglishDictionaryPageState();
}

class _EnglishDictionaryPageState extends State<EnglishDictionaryPage> {
  TextEditingController englishWordController = TextEditingController();

  TextEditingController turkishWordController = TextEditingController();

  TextEditingController searchWord = TextEditingController();

  List<Map<String, dynamic>> result = [
    {"asd": "asd"}
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
        child: SingleChildScrollView(
          child: Column(children: [
            Row(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: searchWord,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term',
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
                      searchDataFromDatabase(
                          currentUser); // current user değerini doğulama
                    },
                    icon: Icon(Icons.search))
              ],
            ),
            Center(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'English Word',
                      ),
                      controller: englishWordController,
                    ),
                  ),
                ),
                margin: EdgeInsets.all(15),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xff06d1ec), Color(0xff83f202)])),
              ),
            ),
            Center(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Turkish Word',
                      ),
                      controller: turkishWordController,
                    ),
                  ),
                ),
                margin: EdgeInsets.all(15),
                width: 200,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xff06d1ec), Color(0xff83f202)])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: InkWell(
                    child: Container(
                      child: Center(child: Icon(Icons.done)),
                      margin: EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          gradient: LinearGradient(
                              colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                    ),
                    onTap: () {
                      saveDataToDatabase(currentUser);
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.delete),
                    margin: EdgeInsets.all(10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: LinearGradient(
                        colors: [Color(0xffe89a07), Color(0x196fca08)],
                      ),
                    ),
                  ),
                  onTap: () {
                    deleteDataFromDatabase(currentUser);
                  },
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.refresh),
                    margin: EdgeInsets.all(10),
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        gradient: LinearGradient(
                            colors: [Color(0xff07e85d), Color(0x196fca08)])),
                  ),
                  onTap: () {
                    print(result);
                    fetchDataFromDatabase(currentUser);
                  },
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.four_k),
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
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
              width: 400,
              color: Colors.red,
              child: ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (BuildContext context, int index) {
                  return Row(
                    children: [
                      buildWordContainer(
                          result[index]['english_word'].toString()),
                      buildWordContainer(
                          result[index]['turkish_word'].toString()),
                    ],
                  );
                },
              ),
            ),
          ]),
        ),
      ),
    );
  }

  void searchDataFromDatabase(int user) async {
    final String url = "http://192.168.0.28/engfetchdataword.php";

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'currentUserId': user.toString(),
        'searchWord': searchWord.text.toString()
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
        for (var entry in data) {
          String englishWord = entry['english_word'];
          String turkishWord = entry['turkish_word'];

          print("English Word: $englishWord, Turkish Word: $turkishWord");
        }
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

  void fetchDataFromDatabase(int user) async {
    final String url = "http://192.168.0.28/engfetchdata.php";

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {'currentUserId': user.toString()},
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
        for (var entry in data) {
          String englishWord = entry['english_word'];
          String turkishWord = entry['turkish_word'];

          print("English Word: $englishWord, Turkish Word: $turkishWord");
        }
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

  Widget buildWordContainer(String word) {
    return Container(
      child: Center(child: Text(word)),
      width: 165,
      height: 50,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.cyan, Colors.deepPurple],
        ),
      ),
    );
  }

  void deleteDataFromDatabase(int user) async {
    final String url =
        "http://192.168.0.28/engdeletedata.php"; // Replace with the actual delete script URL

    var response = await http.post(Uri.parse(url), body: {
      'eng_user_id': user.toString(),
      'english_word': englishWordController.text,
      'turkish_word': turkishWordController.text,
    });

    if (response.statusCode == 200) {
      print("Item deleted successfully");
      fetchDataFromDatabase(user);
    } else {
      print("Failed to delete item. Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }

  void saveDataToDatabase(int user) async {
    final String url = "http://192.168.0.28/englishpage.php";

    // Get values from controllers
    String englishWord = englishWordController.text;
    String turkishWord = turkishWordController.text;
    String currentUser = user.toString(); // Replace with your actual user ID

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'englishWord': englishWord,
        'turkishWord': turkishWord,
        'currentUser': currentUser,
      },
    );

    print("Response: ${response.body}");
  }
}
