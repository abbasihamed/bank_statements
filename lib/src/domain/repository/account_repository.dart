import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class AccountRepo {
  Future<List<AccountModels>> getAllCardData();
  Future<int> createCard(AccountModels accountModels);
}
