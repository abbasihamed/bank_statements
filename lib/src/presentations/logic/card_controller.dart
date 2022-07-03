import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/usecase/create_account_usecase.dart';
import 'package:bank_statements/src/domain/usecase/fetch_acount_usecase.dart';
import 'package:get/get.dart';

import '../../core/app_keys.dart';

class CardController extends GetxController {
  final accountUseCase = injection.get<CreateAccountUseCase>();
  final fetchCards = injection.get<FetchAccountUseCase>();

  bool isError = false;

  final List<AccountModels> _cardList = [];

  List<AccountModels> get cardList => _cardList;

  addCard({
    required String cardNumber,
    required String accountNumber,
    required String iban,
    required String balance,
    required String cvv2,
    required String date,
  }) async {
    try {
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
      navKey.currentState!.pop();
      getAllCard();
    } catch (e) {
      isError = true;
    }
  }

  getAllCard() async {
    final value = await fetchCards.fetchAccountUseCase();
    _cardList.clear();
    for (var element in value) {
      _cardList.add(element);
    }
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCard();
  }
}
