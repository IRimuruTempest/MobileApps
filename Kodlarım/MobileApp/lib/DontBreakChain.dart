import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';

class DontBreakChain extends StatefulWidget {
  @override
  State<DontBreakChain> createState() => _DontBreakChainState();
}

class _DontBreakChainState extends State<DontBreakChain> {
  List<bool> buttonStatusList = List.generate(365, (index) => false);
  final List<bool> resetList = List.generate(365, (index) => false);

  @override
  Widget build(BuildContext context) {
    String currentHobby = Provider.of<UserProvider>(context).currentHobby;
    int currentUser = Provider.of<UserProvider>(context).currentUser;
    fetchData(currentUser, currentHobby);
    return Scaffold(
      appBar: AppBar(
        title: Text('Don\'t Break Chain'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 10,
        ),
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              print(currentHobby);
              bool isButtonEnabled = buttonStatusList[index];
              _toggleButtonStatus(index);
              if (isButtonEnabled) {
                _deleteDatabase(currentUser, currentHobby, index + 1);
              } else {
                _updateDatabase(currentUser, currentHobby, index + 1);
              }

              //fetchData(currentUser, currentHobby, index + 1);
            },
            child: Container(
              decoration: BoxDecoration(
                color: buttonStatusList[index] ? Colors.green : Colors.white,
                border: Border.all(),
              ),
              child: Center(
                child: Text('${index + 1}'),
              ),
            ),
          );
        },
        itemCount: 365,
      ),
    );
  }

  void _toggleButtonStatus(int index) {
    setState(() {
      buttonStatusList[index] = !buttonStatusList[index];
    });
  }

  Future<void> _deleteDatabase(
      int currentUser, String currentHobby, int day) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/dontbreakchaindelete.php'),
      body: {
        'current_user': currentUser.toString(),
        'current_hobby': currentHobby,
        'day': day.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Successful response, handle accordingly
      print('Button status updated in the database.');
      print('Response: ${response.body}');
      setState(() {
        buttonStatusList[day - 1] = false;
      });
    } else {
      // Handle errors
      print('Failed to update button status in the database.');
      print('Error: ${response.body}');
    }
  }

  Future<void> _updateDatabase(
      int currentUser, String currentHobby, int day) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/dontbreakchain.php'),
      body: {
        'current_user': currentUser.toString(),
        'current_hobby': currentHobby,
        'day': day.toString(),
      },
    );

    if (response.statusCode == 200) {
      // Successful response, handle accordingly
      setState(() {
        buttonStatusList[day - 1] = true;
      });
      print('Button status updated in the database.');
      print('Response: ${response.body}');
    } else {
      // Handle errors
      print('Failed to update button status in the database.');
      print('Error: ${response.body}');
    }
  }

  Future<void> fetchData(int currentUser, String currentHobby) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/get_button_statuses.php'),
      body: {
        'current_user': currentUser.toString(),
        'current_hobby': currentHobby,
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      if (data['status'] == 'success') {
        // Buton durumlarını güncelle
        setState(() {
          buttonStatusList = List.generate(
              365, (index) => data['data'][index.toString()] == 1);
        });
      } else {
        // Hata durumunda kullanıcıyı bilgilendir
        print('Veriler alınamadı: ${data['message']}');
      }
    } else {
      // Hata durumunda kullanıcıyı bilgilendir
      print('Veriler alınamadı. Hata kodu: ${response.statusCode}');
    }
  }
}
