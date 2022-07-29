import 'package:bank_statements/src/data/model/transaction.dart';

abstract class TransactionUseCase {
  Future<List<Transaction>> getWithDateExecute(int id, String fromDate, String toDate);
  Future<List<Transaction>> getWithIdExecute(int id);
  Future<int> createExecute(Transaction transaction);
}
