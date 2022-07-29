import 'dart:io';

import 'package:bank_statements/src/data/local/transaction_database.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'card_database.dart';

class BankAccountDatabaseImp implements CardDatabase, TransactionDatabase {
  final String _dbName = 'bank_account';
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path, version: 1, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
                  CREATE TABLE account(
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    account_number TEXT NOT NULL,
                    card_number TEXT NOT NULL,
                    iban_number TEXT NOT NULL,
                    cvv2 TEXT NOT NULL,
                    card_date NOT NULL,
                    balance TEXT NOT NULL
                  )
              ''');
    await db.execute('''
            CREATE TABLE cardtransaction(
                    id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
                    transaction_card TEXT NOT NULL,
                    transaction_balance TEXT NOT NULL,
                    transaction_time TEXT NOT NULL,
                    transaction_date TEXT NOT NULL,
                    transaction_mode TEXT NOT NULL,
                    description TEXT NOT NULL,
                    account_id  INTEGER NOT NULL,
                    FOREIGN KEY (account_id) REFERENCES account (id)
                  )
          ''');
  }

  @override
  Future<int> insertCardData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('account', data);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllCardData() async {
    final db = await database;
    return await db.query('account');
  }

  @override
  Future<int> insertTansactionData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('cardtransaction', data);
  }

  @override
  Future<List<Map<String, dynamic>>> getTransactionWithDate(
      int id, String fromDate, String toDate) async {
    final db = await database;

    return await db.rawQuery(
        "SELECT * FROM cardtransaction where account_id == $id AND (transaction_date >= '$fromDate' AND transaction_date <= '$toDate') ");
  }

  @override
  Future<void> updateBalance(Map<String, dynamic> data) async {
    final db = await database;
    await db.update('account', data, where: 'id = ?', whereArgs: [data['id']]);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllTransactionWithId(int id) async {
    final db = await database;
    return await db
        .query('cardtransaction', where: 'account_id = ? ', whereArgs: [id]);
  }
}
