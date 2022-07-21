import '../model/transaction.dart';

class TransactionMapper {
  static Map<String, dynamic> toMap(Transaction transaction) {
    return {
      'transaction_card':transaction.transactionCard,
      'transaction_balance': transaction.transactionBalance,
      'transaction_time': transaction.transactionTime,
      'transaction_date': transaction.transactionDate,
      'transaction_mode': transaction.transactionMode,
      'description': transaction.description,
      'account_id': transaction.cardId
    };
  }

  static List<Transaction> toList(List<Map<String, dynamic>> data) {
    final value = data.map((e) {
      return Transaction(
        cardId: e['account_id'],
        description: e['description'],
        transactionBalance: e['transaction_balance'],
        transactionDate: e['transaction_date'],
        transactionMode: e['transaction_mode'],
        transactionTime: e['transaction_time'],
        transactionCard: e['transaction_card']
      );
    }).toList();
    return value;
  }
}
