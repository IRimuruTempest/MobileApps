import 'dart:convert';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'MainMenuPage.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  _AnimePage createState() => _AnimePage();
}

class _AnimePage extends State<AnimePage> {
  TextEditingController animeNameController = TextEditingController();
  TextEditingController seasonController = TextEditingController();
  TextEditingController partController = TextEditingController();
  TextEditingController japaneseWordController = TextEditingController();
  TextEditingController englishWordController = TextEditingController();
  TextEditingController turkishWordController = TextEditingController();
  List<String> buttonText = ["asd","qwe"];
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
        child: ListView(
          children: [
            Center(child: Text("AnimePage")),
            Row(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a search term',
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 350,
                  height: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.search))
              ],
            ),
            Row(
              children: [
                Center(
                  child: Container(
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: TextField(
                          controller: animeNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Anime Name',
                          ),
                        ),
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                    width: 200,
                    height: 40,
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
                          controller: seasonController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Season',
                          ),
                        ),
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                    width: 70,
                    height: 40,
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
                          controller: partController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Part',
                          ),
                        ),
                      ),
                    ),
                    margin: EdgeInsets.all(10),
                    width: 70,
                    height: 40,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                  ),
                ),
              ],
            ),
            Center(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      controller: japaneseWordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Japanese Word',
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10),
                width: 400,
                height: 40,
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
                      controller: englishWordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'English Word',
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10),
                width: 400,
                height: 40,
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
                      controller: turkishWordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Turkish Word',
                      ),
                    ),
                  ),
                ),
                margin: EdgeInsets.all(10),
                width: 400,
                height: 40,
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
                          borderRadius: BorderRadius.circular(40),
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
                    fetchDataFromDatabase(currentUser);
                  },
                ),
                Center(
                  child: InkWell(
                    child: Container(
                      child: Center(child: Icon(Icons.delete)),
                      margin: EdgeInsets.all(10),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          gradient: LinearGradient(
                              colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                    ),
                    onTap: (){
                      deleteDataFromDatabase(currentUser);
                    },
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.four_k),
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.deepPurple])),
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MainMenuPage()));
                  },
                ),
              ],
            ),
            Center(
              child: Container(
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: result.length,
                    itemBuilder: (BuildContext context, int index) {
                      return builderItem(index, currentUser);
                    }),
                margin: EdgeInsets.all(15),
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        colors: [Color(0xff570bd2), Color(0xff0bd26e)])),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget builderItem(int index, int currentUser) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              child: Center(child: Text(buttonText[index])),
              width: 100,
              height: 40,
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient:
                      LinearGradient(colors: [Colors.cyan, Colors.deepPurple])),
            ),
            InkWell(
              child: Container(
                child: Image.asset("assets/EnglishButtonImage.png"),
                width: 60,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.deepPurple])),
              ),
              onTap: () {
                fetchDataFromDatabase(currentUser);
                String TXT = result[index]["english_dictionary"].toString();
                buttonText[index] = TXT;
              },
            ),
            InkWell(
              child: Container(
                child: Image.asset("assets/AnimeButtonImage.png"),
                width: 60,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.deepPurple])),
              ),
              onTap: () {
                fetchDataFromDatabase(currentUser);
                String TXT = result[index]["japanese_dictionary"].toString();
                buttonText[index] = TXT;
              },
            ),
            InkWell(
              child: Container(
                child: Image.asset("assets/TurkiyeBayrak.png"),
                width: 60,
                height: 40,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.deepPurple])),
              ),
              onTap: () {
                fetchDataFromDatabase(currentUser);
                String TXT = result[index]["turkish_dictionary"].toString();
                buttonText[index] = TXT;
              },
            ),
          ],
        ),
        Container(
          child: Center(
              child: Text(result[index]['anime_name'] +
                  " / " +
                  result[index]['season'] +
                  " / " +
                  result[index]['part'])),
          width: 300,
          height: 30,
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient:
                  LinearGradient(colors: [Colors.cyan, Colors.deepPurple])),
        ),
      ],
    );
  }

  void fetchDataFromDatabase(int user) async {
    final String url = "http://192.168.0.28/animefetchdata.php";

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
          String japaneseWord = entry['japanese_dictionary'];
          String englishWord = entry['english_dictionary'];
          String turkishWord = entry['turkish_dictionary'];

          print(
              "Japanese Word: $japaneseWord English Word: $englishWord, Turkish Word: $turkishWord");
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

  void saveDataToDatabase(int user) async {
    final String url = "http://192.168.0.28/animepageadddata.php";

    // Get values from controllers
    String animeName = animeNameController.text;
    String seasonValue = seasonController.text;
    String partValue = partController.text;
    String japaneseWord = japaneseWordController.text;
    String englishWord = englishWordController.text;
    String turkishWord = turkishWordController.text;
    String currentUser = user.toString(); // Replace with your actual user ID

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'anime_nameValue': animeName,
        'seasonValue': seasonValue,
        'partValue': partValue,
        'japanese_dictionaryValue': japaneseWord,
        'english_dictionaryValue': englishWord,
        'turkish_dictionaryValue': turkishWord,
        'useridValue': currentUser,
      },
    );

    print("Response: ${response.body}");
  }
  void deleteDataFromDatabase(int user) async {
    final String url =
        "http://192.168.0.28/animedeletedata.php"; // Replace with the actual delete script URL

    var response = await http.post(Uri.parse(url), body: {
      'anim_user_id': user.toString(),
      'japanese_word': japaneseWordController.text,
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
}
