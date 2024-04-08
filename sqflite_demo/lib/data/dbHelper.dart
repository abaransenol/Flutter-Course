import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_demo/models/product.dart';

class DbHelper{
  Database? _database;

  Future<Database?> get getDatabase async {
    if (_database == null){
      _database = await initalizeDatabase();
    }

    return _database;
  }

  Future<Database> initalizeDatabase() async{
    String dbPath = join(await getDatabasesPath(), "etrade.db");
    var eTradeDb = await openDatabase(dbPath, version: 1, onCreate: createDatabase);
    return eTradeDb;
  }

  void createDatabase(Database database, int version) async {
    await database.execute("Create table products(id integer primary key, name text, description text, unitPrice double)");
  }





  Future<List<Product>> getProducts() async {
    var database = await getDatabase;

    var results = await database!.query("products");
    return await List.generate(results.length, (index) => Product.fromObject(results[index]));
  }

  Future<int> insertData(Product product) async{
    var database = await getDatabase;

    return await database!.insert("products", product.toMap());
  }

  Future<int> deleteData(int id) async{
    var database = await getDatabase;

    //return await database.rawDelete("delete from products where id=$id");
    return await database!.delete("products", where: "id=?", whereArgs: [id]);

  }

  Future<int> updateData(Product product) async{
    var database = await getDatabase;

    return await database!.update("products", product.toMap(), where: "id=?", whereArgs: [product.id]);
  }
}

