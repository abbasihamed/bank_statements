import 'package:bank_statements/src/data/model/transaction.dart';

abstract class TransactionDatabase {
  Future<int> insertTansactionData(Map<String, dynamic> data);
  Future<List<Map<String, dynamic>>> getTransactionWithId(int id);
}
