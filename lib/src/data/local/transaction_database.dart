abstract class TransactionDatabase {
  Future<int> insertTansactionData(Map<String, dynamic> data);
  Future getTransactionWithId(int id);
}
