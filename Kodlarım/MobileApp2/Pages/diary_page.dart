
import 'package:flutter/material.dart';
import '../mycolors.dart';

//ana değişkenler başlangıç
List<Map<String, Object>> icerik = [];
var huhu = [
  {
    'type': 'Klasör',
    'name': 'elma',
    'date': '5-6-2020',
    'content': [
      {
        'type': 'Dosya',
        'name': 'çekirdek',
        'date': '6-6-2020',
        'content': ['ajsldfjlasjdflajsldfjalsdjflasjldfsldjfl', 'asdasdasd']
      },
      {
        'type': 'Dosya',
        'name': 'mangal',
        'date': '16-6-2020',
        'content': 'ajsldfjlasjdfl123123flasjldfsldjfl'
      },
      {
        'type': 'Klasör',
        'name': '2020',
        'date': '16-6-2020',
        'content': 'aksdjlakşsdjşakldjkşalsdj',
      },
    ],
  },
]; //artık bu yapı
//ana değişkenler sonu

class Diary_Page extends StatefulWidget {
  @override
  State<Diary_Page> createState() => _Diary_PageState();
}

class _Diary_PageState extends State<Diary_Page> {
  @override
  Widget build(BuildContext context) {
    if (icerik.isEmpty == false) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Diary'),
        ),
        body: DoluSayfaIcerik(context),
        floatingActionButton: FloatingActionButton(
          onPressed: EkleBtnTikla,
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 25,
            ),
          ),
          shape: CircleBorder(),
          backgroundColor: Colors.red,
        ),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: Text('Diary'),
        ),
        body: BosSayfaIcerik(context),
      );
    }
  }

  Center DoluSayfaIcerik(BuildContext context) {
    return Center(
      child: ReorderableListView(
        onReorder: (oldIndex, newIndex) {
          setState(() {
            if (oldIndex < newIndex) {
              newIndex -= 1;
            }

            final Map<String, Object> item = icerik.removeAt(oldIndex);
            icerik.insert(newIndex, item);
          });
        },
        children: [
          for (int index = 0; index < icerik.length; index += 1)
            ListTile(
              onTap: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      content: Text(
                        'butona tıklandı',
                        style: TextStyle(color: Colors.black),
                      ),
                    );
                  },
                );
              },
              onLongPress: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.blueAccent)),
                            child: ListTile(
                              leading: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Yeniden Adlandır',
                              ),
                            ),
                            onPressed: () {
                              Secim(icerik[index]['type'].toString(), true,
                                  eski: icerik[index]['name'].toString());
                            },
                          ),
                          SizedBox(height: 12),
                          ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStatePropertyAll<Color>(
                                    Colors.redAccent)),
                            child: ListTile(
                              leading: Icon(
                                Icons.delete,
                                color: Colors.white,
                              ),
                              title: Text(
                                'Sil',
                              ),
                            ),
                            onPressed: () {
                              setState(() {
                                print(
                                    'Bir element siliniyor element : ${icerik[index]}');
                                icerik.removeAt(index);
                                print('silme işlemi başarılı');
                                Navigator.of(context).pop();
                              });
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
              key: Key('$index'),
              tileColor: index % 2 == 0
                  ? MyColors().DarkBlue.withOpacity(0.05)
                  : MyColors().DarkBlue.withOpacity(0.15),
              leading: icerik[index]['type'] == 'Dosya'
                  ? Icon(
                Icons.file_present,
                color: Colors.black,
              )
                  : Icon(
                Icons.folder,
                color: Colors.orangeAccent,
              ),
              title: Text(icerik[index]['name'].toString()),
            ),
        ],
      ),
    );
  }

  Center BosSayfaIcerik(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(25.0),
            child: Text(
              textAlign: TextAlign.center,
              'Hiçbir klasörünüz veya sayfanız bulunamamaktadır yeni bir tane oluşturmak için \'+\' butonuna basınız ',
              style: TextStyle(color: MyColors().DarkBlue, fontSize: 20),
            ),
          ),
          ElevatedButton(
            onPressed: EkleBtnTikla,
            // onPressed: () {
            //   print(icerik.length);
            // },
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 25,
              ),
            ),
            style: ElevatedButton.styleFrom(
              //primary: Colors.red,
              shape: CircleBorder(),
            ),
          ),
        ],
      ),
    );
  } //hiç klasör veya dosya bulunmadığı zaman sayfanın görüntüsü

  void EkleBtnTikla() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  Secim('Dosya', false);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.file_copy_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Yeni Dosya',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Secim('Klasör', false);
                },
                child: ListTile(
                  leading: Icon(
                    Icons.folder_copy_outlined,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Yeni Klasör',
                    style: TextStyle(color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
  //yeni dosya veya klasör eklemek için kullandığımız buton

  void Secim(String a, bool guncelle, {String? eski}) {
    TextEditingController ya = TextEditingController();
    int mevcutindex = -1;
    Navigator.of(context).pop();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            guncelle
                ? '$eski ${a == 'Klasör' ? 'Klasör\'ünün' : 'Dosya\'sının'}  Yeni Adı'
                : "Yeni $a",
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.black),
          ),
          content: TextFormField(
            controller: ya,
            autofocus: true,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Yeni $a Adını Giriniz',
            ),
            style: TextStyle(color: Colors.black),
          ),
          actions: <Widget>[
            TextButton(
              style: ButtonStyle(
                  backgroundColor:
                  MaterialStatePropertyAll<Color>(Colors.blueAccent)),
              child: Text(
                "Kaydet",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                if (guncelle) {
                  mevcutindex = icerik.indexWhere((element) =>
                  element['type'] == a && element['name'] == eski);
                  setState(() {
                    if (mevcutindex == -1) {
                      print('elementi güncellemede hata var');
                    } else {
                      icerik[mevcutindex]['name'] = ya.text.toString();
                      print(
                          'bir element güncellendi name\'i $eski iken ${ya.text} oldu yeni element :${icerik[mevcutindex]}');
                    }
                  });
                  Navigator.of(context).pop();
                } else {
                  setState(() {
                    icerik.add(
                      {
                        'type': a,
                        'name': '${ya.text}',
                        'date': DateTime.now(),
                        'content': '',
                      },
                    );
                    print(
                        'yeni element oluşturuldu :${icerik[icerik.length - 1]}');
                  });
                  Navigator.of(context).pop();
                }
              },
            ),
            TextButton(
              style: ButtonStyle(
                backgroundColor: MaterialStatePropertyAll<Color>(Colors.red),
              ),
              child: Text(
                "İptal",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                print('iptal edildi');
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  } //yeni eklenecek olan şeyin dosya mı klasör mü olduğunu seçtiren alert
}
