import 'package:bank_statements/injector.dart';
import 'package:bank_statements/src/data/model/transaction.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase.dart';
import 'package:get/get.dart';

class TransactionController extends GetxController {
  final trasactionUsecase = injection.get<TransactionUseCase>();

  addTransaction({required String cardId}) async {
    final response = await trasactionUsecase.createExecute(
      Transaction(
        cardId: int.parse(cardId),
        description: 'This is a desription',
        transactionBalance: '200000',
        transactionDate: '10/30',
        transactionMode: 'in',
        transactionTime: '13:10',
      ),
    );
    print(response);
  }

  getData({required int id}) async {
    final response = await trasactionUsecase.getWithIdExecute(id);
    print(response);
  }
}
