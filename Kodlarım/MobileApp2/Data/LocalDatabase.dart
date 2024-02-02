import 'package:flutter/material.dart';

class LocalDatabase {

  static List<List> MISSIONS = [
    [0, false, 'kv izle', '2023-10-26 08:22:00.000'],
    [2, false, 'hoi4 gir', '2024-01-05 00:00:00.000'],
    [1, false, 'deneme' , '2023-11-02 16:22:00.000'],
    [2, false, 'asde' , '2023-11-03 19:22:00.000'],
    [0, false, 'kv izle', '2023-10-26 08:22:00.000'],
    [2, false, 'hoi4 gir', '2024-01-05 00:00:00.000'],
    [1, false, 'deneme' , '2023-11-02 16:22:00.000'],
    [2, false, 'asde' , '2023-11-03 19:22:00.000'],
  ];

  static void UpdateMissions(List<List> list) {
    MISSIONS = list;
  }
  static List<List> GetMissions() {
    List<List> lt = [];
    for (List i in MISSIONS) {
      lt.add(i);
    }
    return lt;
  }

  static List ActiveMission = []; //study mission

  static String connectedUsername = '';

  static void ResetStudy() {

    ActiveMission = [];

  }

  static  String formatTimefunc(String ck) {

    DateTime before = DateTime.parse(ck);
    DateTime now = DateTime.now();
    Duration fark = before.difference(now);

    if (!fark.isNegative) {
      int kalanGun = fark.inDays;
      int kalanSaat = fark.inHours.remainder(24);
      int kalanDakika = fark.inMinutes.remainder(60);
      int kalanSaniye = fark.inSeconds.remainder(60);

      if (kalanGun >= 3) {
        ck = 'Kalan Süre: $kalanGun gün';
      } else if (kalanGun >= 1) {
        ck = 'Kalan Süre: $kalanGun gün $kalanSaat saat';
      } else if (kalanGun == 0 && kalanSaat >= 1) {
        ck = 'Kalan Süre: $kalanSaat saat $kalanDakika dakika';
      } else if (kalanGun == 0 && kalanSaat <= 0) {
        ck = 'Kalan Süre: $kalanDakika dakika $kalanSaniye saniye';
      }
    } else {
      ck = 'SÜRESİ DOLMUŞ';
    }
    return ck;
  }

}