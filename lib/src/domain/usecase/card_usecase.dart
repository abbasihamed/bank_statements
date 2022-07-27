import '../../data/model/bank_account.dart';

abstract class CardUseCase {
  Future<List<AccountModels>> fetchAccountUseCase();
  Future<int> createExecute(AccountModels accountModels);
  Future<void> updateBalance(AccountModels accountModels);
}
