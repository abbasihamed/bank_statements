import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class UpdateBalanceUseCase {
  Future<void> updateBalance(AccountModels accountModels);
}
