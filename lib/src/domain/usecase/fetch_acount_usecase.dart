import 'package:bank_statements/src/data/model/bank_account.dart';

abstract class FetchAccountUseCase {
  Future<List<AccountModels>> fetchAccountUseCase();
}
