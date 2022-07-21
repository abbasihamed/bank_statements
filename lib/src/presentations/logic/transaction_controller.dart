import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/core/app_keys.dart';
import 'package:bank_statements/src/data/model/transaction.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase.dart';
import 'package:bank_statements/src/presentations/logic/balance_controller.dart';
import 'package:bank_statements/src/presentations/logic/card_controller.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final trasactionUsecase = injection.get<TransactionUseCase>();

  List<Transaction> _transactionList = [];

  List<Transaction> get transactionList => _transactionList;

  addTransaction({
    required String cardId,
    required List<Map<String, dynamic>> value,
  }) async {
    for (var element in value) {
      Get.find<BalanceController>().calculateBalance(
        mode: element['transactionMode'],
        balance: element['transactionBalance'].toString().replaceAll(',', ''),
      );
      await trasactionUsecase.createExecute(
        Transaction(
          cardId: int.parse(cardId),
          transactionCard: element['transactionCard'],
          description: element['description'],
          transactionBalance:
              element['transactionBalance'].toString().replaceAll(',', ''),
          transactionDate: element['transactionDate'],
          transactionMode: element['transactionMode'],
          transactionTime: element['transactionTime'],
        ),
      );
    }
    Get.find<BalanceController>().setBalance(id: int.parse(cardId));
    Get.find<CardController>().getAllCard();
    getData(id: int.parse(cardId));
    navKey.currentState!.pop();
  }

  getData({required int id}) async {
    final response = await trasactionUsecase.getWithIdExecute(id);
    _transactionList = response;
    update();
  }
}
