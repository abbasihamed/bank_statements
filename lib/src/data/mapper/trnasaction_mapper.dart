import '../model/transaction.dart';

class TrnasactionMapper {
  static Map<String, dynamic> toMap(Transaction transaction) {
    return {
      'transaction_balance': transaction.transactionBalance,
      'transaction_time': transaction.transactionTime,
      'transaction_date': transaction.transactionDate,
      'transaction_mode': transaction.transactionMode,
      'description': transaction.description,
      'account_id': transaction.cardId
    };
  }
}
