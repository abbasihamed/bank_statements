import 'package:bank_statements/src/data/local/bank_database.dart';
import 'package:bank_statements/src/data/mapper/card_list_mapper.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';

class AccountRepoImp implements AccountRepo {
  final BankDatabase _bankDatabase;
  const AccountRepoImp(this._bankDatabase);
  @override
  Future<int> createCard(AccountModels accountModels) async {
    return await _bankDatabase.insertData(accountModels.toMap(accountModels));
  }

  @override
  Future<List<AccountModels>> getAllData() async {
    final data = await _bankDatabase.getAllData();
    return CardListMapper.toList(data);
  }
}
