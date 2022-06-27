
import '../../data/model/bank_account.dart';
import '../repository/account_repository.dart';
import 'account_usecase.dart';

class AccountUsecaseImp implements AccountUseCase {
  final AccountRepo _accountRepo;
  const AccountUsecaseImp(this._accountRepo);
  @override
  Future<int> createExecute(AccountModels accountModels) async {
    return await _accountRepo.createCard(accountModels);
  }
}
