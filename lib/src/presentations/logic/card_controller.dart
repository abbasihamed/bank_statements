import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:bank_statements/src/domain/usecase/card_usecase.dart';
import 'package:get/get.dart';

import '../../core/app_keys.dart';

class CardController extends GetxController {
  final cardUseCase = injection.get<CardUseCase>();

  bool isError = false;

  List<AccountModels> _cardList = [];

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
    await cardUseCase.createExecute(
        AccountModels(
          accountNumber: accountNumber,
          cardNumber: cardNumber.replaceAll(' ', ''),
          ibanNumber: iban,
          cvv2: cvv2,
          cardDate: date,
          balance: balance.replaceAll(',', ''),
        ),
      );
      navKey.currentState!.pop();
      getAllCard();
    } catch (e) {
      isError = true;
    }
  }

  getAllCard() async {
    final response = await cardUseCase.fetchAccountUseCase();
    _cardList = response;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAllCard();
  }
}
