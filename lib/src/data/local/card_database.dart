
abstract class CardDatabase {
  Future<List<Map<String, dynamic>>> getAllCardData();
  Future<int> insertCardData(Map<String, dynamic> data);
  Future<void> updateBalance(Map<String, dynamic> data);
}
