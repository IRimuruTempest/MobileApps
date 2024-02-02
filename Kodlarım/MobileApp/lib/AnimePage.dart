import 'package:flutter/material.dart';

import 'MainMenuPage.dart';

class AnimePage extends StatefulWidget {
  const AnimePage({super.key});

  _AnimePage createState() => _AnimePage();
}

class _AnimePage extends State<AnimePage> {
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
                  child: Container(
                    child: Center(child: Icon(Icons.done)),
                    margin: EdgeInsets.all(10),
                    width: 80,
                    height: 80,
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
                    width: 80,
                    height: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        gradient: LinearGradient(
                            colors: [Color(0xff06d1ec), Color(0xff83f202)])),
                  ),
                ),
                InkWell(
                  child: Container(
                    child: Icon(Icons.four_k),
                    width: 80,
                    height: 80,
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
            Center(
              child: Container(
                child: ListView(
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Container(
                              child: Center(child: Text("Japanese")),
                              width: 100,
                              height: 40,
                              margin: EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  gradient: LinearGradient(
                                      colors: [Colors.cyan, Colors.deepPurple])),
                            ),
                            InkWell(
                              child: Container(
                                child:
                                    Image.asset("assets/EnglishButtonImage.png"),
                                width: 60,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Colors.cyan,
                                      Colors.deepPurple
                                    ])),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Container(
                                child: Image.asset("assets/AnimeButtonImage.png"),
                                width: 60,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Colors.cyan,
                                      Colors.deepPurple
                                    ])),
                              ),
                              onTap: () {},
                            ),
                            InkWell(
                              child: Container(
                                child: Image.asset("assets/TurkiyeBayrak.png"),
                                width: 60,
                                height: 40,
                                margin: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    gradient: LinearGradient(colors: [
                                      Colors.cyan,
                                      Colors.deepPurple
                                    ])),
                              ),
                              onTap: () {},
                            ),
                          ],
                        ),
                        InkWell(
                          child: Container(
                            child: Center(child: Text("Result Here")),
                            width: 300,
                            height: 30,
                            margin: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: LinearGradient(
                                    colors: [Colors.cyan, Colors.deepPurple])),
                          ),
                          onTap: () {},
                        ),
                      ],
                    )
                  ],
                ),
                margin: EdgeInsets.all(15),
                width: 400,
                height: 400,
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
}
