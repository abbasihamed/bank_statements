import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';
import 'package:bank_statements/src/domain/usecase/fetch_acount_usecase.dart';

class FetchAccountUseCaseImp implements FetchAccountUseCase {
  final AccountRepo _accountRepo;
  const FetchAccountUseCaseImp(this._accountRepo);

  @override
  Future<List<AccountModels>> fetchAccountUseCase() async {
    return await _accountRepo.getAllCardData();
  }
}
