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
  Future<List<Transaction>> getTransactionWithId(int id,String date) async {
    final data = await _database.getTransactionWithId(id,date);
    return TransactionMapper.toList(data);
  }
}
