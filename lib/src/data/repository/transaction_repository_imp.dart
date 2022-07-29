import 'package:bank_statements/src/data/local/transaction_database.dart';
import 'package:bank_statements/src/data/mapper/trnasaction_mapper.dart';
import 'package:bank_statements/src/data/model/transaction.dart';
import 'package:bank_statements/src/domain/repository/transaction_repository.dart';

class TransactionRepositoryImp implements TransactionRepository {
  final TransactionDatabase _database;
  const TransactionRepositoryImp(this._database);
  @override
  Future<int> createTransaction(Transaction transaction) async {
    return await _database
        .insertTansactionData(TransactionMapper.toMap(transaction));
  }

  @override
  Future<List<Transaction>> getTransactionWithDate(
      int id, String fromDate, String toDate) async {
    final data = await _database.getTransactionWithDate(id, fromDate, toDate);
    return TransactionMapper.toList(data);
  }

  @override
  Future<List<Transaction>> getAllTransactionWithId(int id) async {
    final data = await _database.getAllTransactionWithId(id);
    return TransactionMapper.toList(data);
  }
}
