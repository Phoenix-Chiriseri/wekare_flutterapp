import 'dart:async';
import 'dart:async';
import 'dart:core';

import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart' as sql;

class SQlHelper{

  static Future<void> createTables(sql.Database database) async{
    await database.execute("""create table items(id integer primary key autoincrement not null,title text,description text,
     createdAt timestamp not null default current_timestamp)""");
  }

  static Future<sql.Database> db() async {
    return sql.openDatabase(
      'dbtect.db',
      version: 1,
      onCreate: (sql.Database database,int version) async{
        await createTables(database);
      },
    );
  }

  static Future<int> createItem(String title, String?description) async{
    final db = await SQlHelper.db();
    final data = {'title':title,'description':description};
    final id = await db.insert('items', data,conflictAlgorithm: sql.ConflictAlgorithm.replace);
    return id;
  }

  static Future<List<Map<String,dynamic>>> getItems() async{
    final db = await SQlHelper.db();
    return db.query('items',orderBy:"id");
  }

  static Future<List<Map<String,dynamic>>> getItem(int id) async{
    final db = await SQlHelper.db();
    return db.query('items',where:"id=?",whereArgs:[id], limit:1);
  }
}