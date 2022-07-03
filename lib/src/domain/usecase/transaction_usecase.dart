import 'package:bank_statements/src/data/model/transaction.dart';

abstract class TransactionUseCase {
  Future<int> createExecute(Transaction transaction);
  Future getWithIdExecute(int id);
}
