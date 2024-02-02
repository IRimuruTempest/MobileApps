import 'package:flutter/material.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'MainMenuPage.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  _LoginPage createState() => _LoginPage();
}

class _LoginPage extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String url =
        "http://192.168.0.28/login.php"; // Replace with your API endpoint

    try {
      final response = await http.post(
        Uri.parse(url),
        body: {
          "username": usernameController.text,
          "password": passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        // Check if the 'success' key exists in the response
        if (data.containsKey('success')) {
          if (data['success']) {
            // Login successful
            print("Login successful");
            int userID = data['user_id'];
            Provider.of<UserProvider>(context, listen: false)
                .setCurrentUser(userID);
            print("User ID: $userID");
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainMenuPage(),
              ),
            );
          } else {
            // Login failed
            print("Login failed: ${data['message']}");
          }
        } else {
          // Invalid response format
          print("Invalid response format");
        }
      } else {
        // Server returned an error status code
        print("Server error: ${response.statusCode}");
      }
    } catch (e) {
      // Handle network or other errors
      print("Error: $e");
    }
  }

  Future<void> signUp() async {
    final url = 'http://192.168.0.28/signup.php';
    final response = await http.post(
      Uri.parse(url),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': usernameController.text,
        'password': passwordController.text,
      }),
    );

    if (response.statusCode == 200) {
      // Successful signup
      Fluttertoast.showToast(msg: "Signup Successfully");
    } else {
      // Handle error
      Fluttertoast.showToast(msg: 'Error during signup: ${response.body}');
    }
  }

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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Username',
                      ),
                    ),
                  ),
                ),
                width: 200,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(colors: [Colors.amber, Colors.cyan])),
              ),
            ),
            Center(
              child: Container(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: TextField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
                width: 200,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient:
                        LinearGradient(colors: [Colors.amber, Colors.cyan])),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                    child: Container(
                      child: Icon(Icons.login),
                      width: 100,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.deepPurple])),
                    ),
                    onTap: login),
                InkWell(
                    child: Container(
                      child: Icon(Icons.app_registration),
                      width: 100,
                      height: 50,
                      margin: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.cyan, Colors.deepPurple])),
                    ),
                    onTap: signUp),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
