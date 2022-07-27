import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';
import 'package:bank_statements/src/domain/usecase/card_usecase.dart';

class CardUseCaseImp implements CardUseCase {
  final AccountRepo _accountRepo;
  const CardUseCaseImp(this._accountRepo);
  @override
  Future<int> createExecute(AccountModels accountModels) async {
    return await _accountRepo.createCard(accountModels);
  }

  @override
  Future<List<AccountModels>> fetchAccountUseCase() async {
    return await _accountRepo.getAllCardData();
  }

  @override
  Future<void> updateBalance(AccountModels accountModels) async {
    await _accountRepo.updateBalance(accountModels);
  }
}
