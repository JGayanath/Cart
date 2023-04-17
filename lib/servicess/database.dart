
import 'package:path/path.dart';
import 'package:pree_bill/model/cart_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static const int _version = 1;
  static const String _dbName = "Cart.db";

  static Future<Database> _getDB() async {
    return openDatabase(join(await getDatabasesPath(), _dbName),
        onCreate: (db, version) async => await db.execute(
            "CREATE TABLE Cart(id INTEGER PRIMARY KEY,date TEXT NOT NULL, item TEXT NOT NULL, price TEXT NOT NULL,discount TEXT NOT NULL,quantity TEXT NOT NULL,total TEXT NOT NULL);"),
        version: _version);
  }

  static Future<int> addCart(Cart_Model cart) async {
    final db = await _getDB();
    return await db.insert("Cart", cart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updateNote(Cart_Model cart) async {
    final db = await _getDB();
    return await db.update("Cart", cart.toJson(),
        where: 'id = ?',
        whereArgs: [cart.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  // delete item selected date
  static Future<int> deleteCartItem(String date) async {
    final db = await _getDB();
    return await db.delete(
      "Cart",
      where: 'date = ?',
      whereArgs: [date],
    );
  }



  static Future<List<Cart_Model>?> getAllItems() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Cart',
    );
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Cart_Model.fromJson(maps[index]));
  }

  //--- get unique data without duplicate value from cart table
  static Future<List<Cart_Model>?> getUniqueDate() async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Cart',
      distinct: true,
      groupBy: 'date',
    );

    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Cart_Model.fromJson(maps[index]));
  }

  // get all data from selected date
  static Future<List<Cart_Model>?> getDateItems(String date) async {
    final db = await _getDB();
    final List<Map<String, dynamic>> maps = await db.query(
      'Cart',
      where: 'date = ?',
      whereArgs: [date],
    );
    if (maps.isEmpty) {
      return null;
    }
    return List.generate(
        maps.length, (index) => Cart_Model.fromJson(maps[index]));
  }

  static Future<double> getTotal(String date) async {
    // Open the database
    final db = await _getDB();

    // Execute the query and get the result
    final result = await db.query('Cart',
        columns: ['SUM(total)'],
        where: 'date = ?',
        whereArgs: [date]);

    // Get the sum total from the result
    final total = result.first.values.first as double;

    return total;

    // Close the database
    await db.close();
  }

}
