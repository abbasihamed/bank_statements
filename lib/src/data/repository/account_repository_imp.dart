import 'package:bank_statements/src/data/local/card_database.dart';
import 'package:bank_statements/src/data/mapper/card_list_mapper.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';

class AccountRepoImp implements AccountRepo {
  final CardDatabase _bankDatabase;
  const AccountRepoImp(this._bankDatabase);
  @override
  Future<int> createCard(AccountModels accountModels) async {
    return await _bankDatabase
        .insertCardData(accountModels.toMap(accountModels));
  }

  @override
  Future<List<AccountModels>> getAllCardData() async {
    final data = await _bankDatabase.getAllCardData();
    return CardListMapper.toList(data);
  }

  @override
  Future<void> updateBalance(AccountModels accountModels) async {
    await _bankDatabase.updateBalance(accountModels.toMap(accountModels));
  }
}
