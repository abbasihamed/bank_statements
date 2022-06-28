import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import 'bank_database.dart';

class BankAccountDatabaseImp implements BankDatabase {
  final String _dbName = 'bank_account';
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    return openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        db.execute('''
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
      },
      version: 1,
    );
  }

  @override
  Future<int> insertData(Map<String, dynamic> data) async {
    final db = await database;
    return await db.insert('account', data);
  }

  @override
  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await database;
    return await db.query('account');
  }
}
