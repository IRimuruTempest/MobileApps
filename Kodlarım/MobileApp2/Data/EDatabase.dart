import 'dart:developer';

import 'package:mongo_dart/mongo_dart.dart';
import 'dart:async';


class EDatabase {
  static var db, coll;
  static String CON_STR = 'mongodb+srv://erenkarakayaw:WRgVydqFU3bHvpS8@savepoteytowithtime.zwesxhr.mongodb.net/savepoteytodb?retryWrites=true&w=majority';

  static Connect() async {

    db = await Db.create(CON_STR);

    await db.open();

    inspect(db);

    coll = db.collection('users');

  }

  static Insert(String username,String password,String pp) async {
    await coll.insertOne({
      '_id' : ObjectId.parse( ObjectId.createId(DateTime.now().second, true).hexString),
      'username' : username,
      'password' : password,
      'pp' : pp,
      "uncompleted_missions": [],
      "completed_missions": [],
      "daily_assessments": [],
      'settings' : {}
    });
  }

  static Update(String updateUsername,String updatedValue, Value) async {
    await coll.update(
      where.eq('username', updateUsername),
      modify.set(updatedValue, Value)
    );
  }

  static Delete(String username) async {
    await coll.remove(where.eq('username' , username));
  }


}