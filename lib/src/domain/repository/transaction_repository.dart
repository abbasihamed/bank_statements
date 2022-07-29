import 'package:bank_statements/src/data/model/transaction.dart';

abstract class TransactionRepository {
  Future<List<Transaction>> getTransactionWithDate(int id, String fromDate, String toDate);
  Future<List<Transaction>> getAllTransactionWithId(int id);
  Future<int> createTransaction(Transaction transaction);
}
