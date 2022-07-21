import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';
import 'package:bank_statements/src/domain/usecase/update_balance_usecase.dart';

class UpdateBalanceUseCaseImp implements UpdateBalanceUseCase {
  final AccountRepo _accountRepo;
  const UpdateBalanceUseCaseImp(this._accountRepo);
  @override
  Future<void> updateBalance(AccountModels accountModels) async {
    await _accountRepo.updateBalance(accountModels);
  }
}
