import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class AccountRepo {
  Future<List<AccountModels>> getAllData();
  Future<int> createCard(AccountModels accountModels);
}
