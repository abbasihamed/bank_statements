import '../../data/model/bank_account.dart';
import '../repository/account_repository.dart';
import 'create_account_usecase.dart';

class CreateAccountUsecaseImp implements CreateAccountUseCase {
  final AccountRepo _accountRepo;
  const CreateAccountUsecaseImp(this._accountRepo);
  @override
  Future<int> createExecute(AccountModels accountModels) async {
    return await _accountRepo.createCard(accountModels);
  }
}
