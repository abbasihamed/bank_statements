import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/usecase/account_usecase.dart';
import 'package:get/get.dart';

class AddCardController extends GetxController {
  final accountUseCase = injection.get<AccountUseCase>();

  addCard({
    required String cardNumber,
    required String accountNumber,
    required String iban,
    required String balance,
    required String cvv2,
    required String date,
  }) async {
    final response = await accountUseCase.createExecute(
      AccountModels(
        accountNumber: accountNumber,
        cardNumber: cardNumber,
        ibanNumber: iban,
        cvv2: cvv2,
        cardDate: date,
        balance: balance,
      ),
    );
    print(response);
  }
}
