import 'package:flutter/material.dart';
import 'package:mysqlengjpn/AllIncomes.dart';
import 'package:mysqlengjpn/AllSpendings.dart';
import 'package:mysqlengjpn/MainMenuPage.dart';
import 'userNotifier.dart';
import 'package:provider/provider.dart';

class MoneyManagementPage extends StatefulWidget {
  const MoneyManagementPage({Key? key}) : super(key: key);

  @override
  _MoneyManagementPageState createState() => _MoneyManagementPageState();
}

class _MoneyManagementPageState extends State<MoneyManagementPage> {
  @override
  Widget build(BuildContext context) {
    int currentUser = Provider.of<UserProvider>(context).currentUser;
    TextEditingController moneyForNameController = TextEditingController();
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
          children: [
            InkWell(
              child: Container(
                child: Icon(Icons.four_k),
                width: 100,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.deepPurple])),
              ),
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => MainMenuPage()));
              },
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                width: 325,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text('All Income'),
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllIncomesPage()));
              },
            ),
            InkWell(
              child: Container(
                margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                width: 325,
                height: 50,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: LinearGradient(
                        colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Text('All Spendings'),
                  ),
                ),
              ),
              onTap: (){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AllSpendingsPage()));
              },
            ),
            Row(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: moneyForNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Enter a saving name',
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 325,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.done),
                    width: 50,
                    height: 50,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.deepPurple])),
                  ),
                  onTap: () {
                    // add data to database
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
