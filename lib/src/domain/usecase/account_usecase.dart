import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class AccountUseCase {
  Future<int> createExecute(AccountModels accountModels);
}
