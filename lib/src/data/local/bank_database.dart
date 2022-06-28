import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class BankDatabase {
  Future<List<Map<String, dynamic>>> getAllData();
  Future<int> insertData(Map<String, dynamic> data);
}
