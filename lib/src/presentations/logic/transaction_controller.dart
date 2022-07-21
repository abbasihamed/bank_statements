import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/core/app_keys.dart';
import 'package:bank_statements/src/data/model/transaction.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase.dart';
import 'package:bank_statements/src/presentations/logic/balance_controller.dart';
import 'package:bank_statements/src/presentations/logic/card_controller.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class TransactionController extends GetxController {
  final trasactionUsecase = injection.get<TransactionUseCase>();

  int _totalIn = 0;
  int _totalOut = 0;

  List<Transaction> _transactionList = [];

  List<Transaction> get transactionList => _transactionList;
  String get totalIn => _totalIn.toString().seRagham();
  String get totalOut => _totalOut.toString().seRagham();

  void addTransaction({
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

  void getData({required int id}) async {
    final response = await trasactionUsecase.getWithIdExecute(id);
    _transactionList = response;
    calculateTransAction(transaction: _transactionList);
    update();
  }

  void calculateTransAction({List<Transaction>? transaction}) {
    _totalIn = 0;
    _totalOut = 0;
    if (transaction != null) {
      for (var element in transaction) {
        if (element.transactionMode == 'in') {
          _totalIn += int.parse(element.transactionBalance ?? "0");
        } else {
          _totalOut += int.parse(element.transactionBalance ?? "0");
        }
      }
    }
  }

  String detecMode(String balance, String mode) {
    if (mode == 'in') {
      return '+ ${balance.seRagham()}';
    } else {
      return '- ${balance.seRagham()}';
    }
  }
}
