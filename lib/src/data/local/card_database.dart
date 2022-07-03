import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class CardDatabase {
  Future<List<Map<String, dynamic>>> getAllCardData();
  Future<int> insertCardData(Map<String, dynamic> data);
}
