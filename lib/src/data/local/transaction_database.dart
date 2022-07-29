
abstract class TransactionDatabase {
  Future<List<Map<String, dynamic>>> getAllTransactionWithId(int id);
  Future<List<Map<String, dynamic>>> getTransactionWithDate(
      int id, String fromDate, String toDate);
  Future<int> insertTansactionData(Map<String, dynamic> data);
}
