import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mysqlengjpn/userNotifier.dart';
import 'package:provider/provider.dart';
import 'MoneyManagement.dart';
import 'package:http/http.dart' as http;

class Income {
  String name;
  int amount;
  int period;
  DateTime date;

  Income(
      {required this.name,
      required this.amount,
      required this.period,
      required this.date});
}

class AllIncomesPage extends StatefulWidget {
  @override
  State<AllIncomesPage> createState() => _AllIncomesPageState();
}

class _AllIncomesPageState extends State<AllIncomesPage> {
  TextEditingController IncomeNameController = TextEditingController();
  TextEditingController IncomeValueController = TextEditingController();
  TextEditingController PeriodController = TextEditingController();

  List<Income> incomes = [];

  //todo periyot ile date i böldüğüm sayı kadar currentAmount a para ekleyen programı çalıştır
  //todo bu sayfadaki kodların hepsinin birebir aynısını allSpendings sayfasında da yap
  //todo MoneyManagement sayfasında bu sayfadaki fetchFromDatabase in aynısını ama
  //todo incomes ve spendings veritabanındaki saving_name = currentSavingName ile eşleşiyor mu sorgusunu ekle
  //todo QR kod okumayı ekle ve bitir.

  Future<void> deleteIncomeFromDatabase(int userId, String incomeName) async {
    final response = await http.post(
      Uri.parse('http://192.168.0.28/delete_income.php'), // PHP dosyanızın yolu
      body: {
        'UserID': userId.toString(),
        'IncomeName': incomeName,
      },
    );

    if (response.statusCode == 200) {
      print("Income deleted successfully!");
    } else {
      throw Exception('Failed to delete income');
    }
  }

  Future<void> fetchData(int currentUser) async {
    incomes.clear();
    final response = await http.get(
        Uri.parse('http://192.168.0.28/get_incomes.php?user_id=$currentUser'));

    if (response.statusCode == 200) {
      if (response.body.isEmpty) {
        print('Response body is empty.');
        // Handle empty response here
        return;
      } else {
        List<dynamic> data = jsonDecode(response.body);
        for (var item in data) {
          String name = item["income_name"];
          int amount = int.parse(item["income_amount"]);
          int period = int.parse(item["IncomePeriod"]);
          DateTime date = DateTime.parse(item["IncomeDate"]);
          setState(() {
            incomes.add(
                Income(name: name, amount: amount, period: period, date: date));

          });

          print('Income Name: ${item["income_name"]}');
          print('Income Amount: ${item["income_amount"]}');
          print('Income Period: ${item["IncomePeriod"]}');
          print('Income Date: ${item["IncomeDate"]}');
          print('-------------------------');
        }
      }

      try {
        final List<dynamic> data = jsonDecode(response.body);
        // Verileri işleme devam edin
        print(data);
      } catch (e) {
        print('Error decoding JSON: $e');
        // Handle JSON decoding error here
      }
    } else {
      throw Exception('Veri getirme hatası: ${response.statusCode}');
    }
  }

// Call fetchData with a valid currentUser value

  Future<void> addIncomeToDatabase(
      String name, int value, int userId, int period, DateTime day) async {
    final formattedDate =
        '${day.year}-${day.month.toString().padLeft(2, '0')}-${day.day.toString().padLeft(2, '0')} ${day.hour.toString().padLeft(2, '0')}:${day.minute.toString().padLeft(2, '0')}:${day.second.toString().padLeft(2, '0')}';

    final response = await http.post(
      Uri.parse('http://192.168.0.28/add_income.php'), // PHP dosyanızın yolu
      body: {
        'IncomeName': name.toString(),
        'IncomeValue': value.toString(),
        'UserID': userId.toString(),
        'IncomePeriod': period.toString(),
        'IncomeDate': formattedDate,
      },
    );

    if (response.statusCode == 200) {
      print("Income added successfully!");
    } else {
      throw Exception('Failed to add income');
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
                      colors: [Colors.cyan.shade50, Colors.cyan]),
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MoneyManagementPage()),
                );
              },
            ),
            InkWell(
              child: Container(
                child: Icon(Icons.refresh),
                width: 50,
                height: 50,
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(40),
                  gradient: LinearGradient(
                      colors: [Colors.cyan.shade50, Colors.cyan]),
                ),
              ),
              onTap: () {
                fetchData(currentUser);
              },
            ),
            Row(
              children: [
                Container(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                      child: TextField(
                        controller: IncomeNameController,
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
                        controller: IncomeValueController,
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
                      addIncomeToDatabase(
                        IncomeNameController.text,
                        int.parse(IncomeValueController.text),
                        currentUser,
                        int.parse(PeriodController.text),
                        DateTime.now(), // Tarih bilgisini PHP tarafına gönderin
                      );
                    });
                    // add data to database
                  },
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: incomes.length,
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
                              colors: [Colors.cyan.shade50, Colors.cyan]),
                        ),
                        child: ListTile(
                          title: Text(incomes[index].name),
                          trailing:
                              Text('${incomes[index].amount.toString()} ₺'),
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
                          String name = incomes[index].name;
                          setState(() {
                            int Index = index;
                            incomes.removeAt(Index);
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
