import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class CreateAccountUseCase {
  Future<int> createExecute(AccountModels accountModels);
}
