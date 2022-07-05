import 'package:bank_statements/src/data/model/transaction.dart';
import 'package:bank_statements/src/domain/repository/transaction_repository.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase.dart';

class TransactionUsecaseImp implements TransactionUseCase {
  final TransactionRepository _repository;
  const TransactionUsecaseImp(this._repository);
  @override
  Future<int> createExecute(Transaction transaction) async {
    return await _repository.createTransaction(transaction);
  }

  @override
  Future<List<Transaction>> getWithIdExecute(int id) async {
    return await _repository.getTransactionWithId(id);
  }
}
