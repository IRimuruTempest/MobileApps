import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlengjpn/DontBreakChain.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';

import 'MainMenuPage.dart';

class HobbiesPage extends StatefulWidget {
  @override
  _HobbiesPageState createState() => _HobbiesPageState();
}

class _HobbiesPageState extends State<HobbiesPage> {

  TextEditingController hobbyNameController = TextEditingController();
  List<String> hobbies = ["asd", "ppp"];



  @override
  Widget build(BuildContext context) {
    int currentUser = Provider.of<UserProvider>(context).currentUser;
   setState(() {
     fetchDataFromDatabase(currentUser);
   });
    return Scaffold(
      body: Column(
        children: [
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
          ListView.builder(
              shrinkWrap: true,
              itemCount: hobbies.length,
              itemBuilder: (BuildContext context, int index) {
                return builderItem(index, currentUser);
              }),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (BuildContext context) {
                return SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        TextFormField(
                          decoration: InputDecoration(labelText: 'HobbyName'),
                          controller: hobbyNameController,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            setState(() {
                              saveDataToDatabase(
                                  currentUser, hobbyNameController.text);
                              hobbies.add(hobbyNameController.text);
                            });
                            Navigator.of(context).pop(); // Alt çubuğu kapat
                          },
                          child: Text('Gönder'),
                        ),
                      ],
                    ),
                  ),
                );
              });
        },
        child: Icon(Icons.add),
      ),
    );
  }

  Widget builderItem(int index, int currentUser) {
    return Row(
      children: [
        InkWell(
          child: Container(
            height: 40,
            margin: EdgeInsets.all(10),
            width: 340,
            child: Center(child: Text(hobbies[index])),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient:
                    LinearGradient(colors: [Colors.cyan, Colors.deepPurple])),
          ),
          onTap: () {
            int Index = index;
            Provider.of<UserProvider>(context, listen: false).setCurrentUserHobby(hobbies[Index]);
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => DontBreakChain()));
          },
        ),
        IconButton(
            onPressed: () {
              int Index = index;
              setState(() {
                deleteDataFromDatabase(currentUser, hobbies[Index]);
                hobbies.removeAt(Index);
              });
            },
            icon: Icon(Icons.delete))
      ],
    );
  }

  void fetchDataFromDatabase(int user) async {
    final String url = "http://192.168.0.28/hobbyfetchdata.php";

    // Get values from controllers
    String currentUser = user.toString(); // Replace with your actual user ID

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'useridValue': currentUser,
      },
    );

    if (response.statusCode == 200) {
      // Parse the response and update the hobbies list
      List<String> fetchedHobbies = json.decode(response.body).cast<String>();
      setState(() {
        hobbies = fetchedHobbies;
      });
    } else {
      print("Failed to fetch data. Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }

  void saveDataToDatabase(int user, String text) async {
    final String url = "http://192.168.0.28/hobbypageadddata.php";

    // Get values from controllers
    String hobbyName = text;
    String currentUser = user.toString(); // Replace with your actual user ID

    // Send data to PHP script
    var response = await http.post(
      Uri.parse(url),
      body: {
        'hobbyName': hobbyName,
        'useridValue': currentUser,
      },
    );

    print("Response: ${response.body}");
  }

  void deleteDataFromDatabase(int user, String text) async {
    final String url = "http://192.168.0.28/hobbypagedeletedata.php";
    String hobbyName = text;
    String currentUser =
        user.toString(); // Replace with the actual delete script URL

    var response = await http.post(Uri.parse(url), body: {
      'hobbyName': hobbyName,
      'userID': currentUser,
    });

    if (response.statusCode == 200) {
      print("Item deleted successfully");
    } else {
      print("Failed to delete item. Status Code: ${response.statusCode}");
      print("Response Body: ${response.body}");
    }
  }
}
