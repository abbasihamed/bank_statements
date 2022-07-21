import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/usecase/update_balance_usecase.dart';
import 'package:get/get.dart';

class BalanceController extends GetxController {
  final updateBalance = injection.get<UpdateBalanceUseCase>();
  AccountModels? _accountModels;
  int _in = 0;
  int _out = 0;

  void cacheCardData(AccountModels accountModels) {
    _accountModels = accountModels;
  }

  void calculateBalance({required String mode, required String balance}) {
    if (mode == 'in') {
      _in += int.parse(balance);
    } else {
      _out += int.parse(balance);
    }
  }

  void setBalance({required int id}) {
    String newBalance =
        (int.parse(_accountModels!.balance!) + (_in - _out)).toString();
    updateBalance.updateBalance(
      AccountModels(
        id: id,
        balance: newBalance,
        accountNumber: _accountModels!.accountNumber,
        cardDate: _accountModels!.cardDate,
        cardNumber: _accountModels!.cardNumber,
        cvv2: _accountModels!.cvv2,
        ibanNumber: _accountModels!.ibanNumber,
      ),
    );
  }
}
