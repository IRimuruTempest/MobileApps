import 'package:flutter/material.dart';
import 'package:timemanagamentpotato/Data/EDatabase.dart';
import 'page_controller.dart';
import 'mycolors.dart';

void main(List<String> args) async{
  WidgetsFlutterBinding.ensureInitialized();
  await EDatabase.Connect();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Page_Controller(),
      theme: ThemeData(
          scaffoldBackgroundColor: MyColors().mybackgroundcolor,
          appBarTheme: AppBarTheme(color: MyColors().mygrayclose),
          textTheme: Typography.whiteRedwoodCity),
    );
  }
}
