import 'package:bank_statements/src/data/model/transaction.dart';

abstract class TransactionRepository {
  Future<int> createTransaction(Transaction transaction);
  Future<List<Transaction>> getTransactionWithId(int id,String date);
}
