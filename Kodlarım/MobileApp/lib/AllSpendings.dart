import 'package:flutter/material.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'MoneyManagement.dart';
import 'package:http/http.dart' as http;

class Spending {
  final String name;
  final int amount;

  Spending({required this.name, required this.amount});
}

class AllSpendingsPage extends StatefulWidget {
  @override
  State<AllSpendingsPage> createState() => _AllSpendingsPageState();
}

class _AllSpendingsPageState extends State<AllSpendingsPage> {
  TextEditingController SpendingNameController = TextEditingController();
  TextEditingController SpendingValueController = TextEditingController();
  TextEditingController PeriodController = TextEditingController();

  List<Spending> spendings = [
  ];

  Future<void> deleteIncomeFromDatabase(int userId, String spendingName) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/delete_spending.php'), // PHP dosyanızın yolu
      body: {
        'UserID': userId.toString(),
        'SpendingName': spendingName,
      },
    );

    if (response.statusCode == 200) {
      print("Income deleted successfully!");
    } else {
      throw Exception('Failed to delete income');
    }
  }

  Future<void> addSpendingToDatabase(String name, int value, int userId) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/add_spending.php'), // PHP dosyanızın yolu
      body: {
        'SpendingName': name,
        'SpendingValue': value.toString(), // Değeri bir stringe dönüştürdük
        'UserID': userId.toString(),
      },
    );

    if (response.statusCode == 200) {
      print("Spending added successfully!");
    } else {
      throw Exception('Failed to add Spending');
    }
  }

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
        child: Column(
          children: [
            InkWell(
              child: Container(
                child: Icon(Icons.four_k),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                      colors: [Colors.cyan.shade50, Colors.cyan]
                  ),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MoneyManagementPage()),
                );
              },
            ),
            Row(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: SpendingNameController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'saving name',
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 110,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: SpendingValueController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'saving value',
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 110,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: PeriodController,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'period',
                        ),
                      ),
                    ),
                  ),
                  margin: EdgeInsets.fromLTRB(10, 10, 0, 10),
                  width: 85,
                  height: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                          colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.done),
                    width: 40,
                    height: 40,
                    margin: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                            colors: [Colors.cyan, Colors.deepPurple])),
                  ),
                  onTap: () {
                    setState(() {
                      spendings.add(Spending(name: SpendingNameController.text, amount: int.parse(SpendingValueController.text)));
                      addSpendingToDatabase(SpendingNameController.text, int.parse(SpendingValueController.text), currentUser);
                    });
                    // add data to database
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: spendings.length,
                itemBuilder: (context, index) {
                  return Row(
                    children: [
                      Container(
                        width: 325,
                        height: 50,
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                              colors: [Colors.cyan.shade50, Colors.cyan]
                          ),
                        ),
                        child: ListTile(
                          title: Text(spendings[index].name),
                          trailing: Text('${spendings[index].amount.toString()} ₺'),
                        ),
                      ),
                      InkWell(
                        child: Container(
                          child: Icon(Icons.delete),
                          width: 40,
                          height: 40,
                          margin: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              gradient: LinearGradient(
                                  colors: [Colors.cyan, Colors.deepPurple])),
                        ),
                        onTap: () async {
                          String name = spendings[index].name;
                          setState(() {
                            int Index = index;
                            spendings.removeAt(Index);
                          });
                          await deleteIncomeFromDatabase(currentUser, name);
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}