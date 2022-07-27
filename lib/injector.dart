import 'package:bank_statements/src/data/local/transaction_database.dart';
import 'package:bank_statements/src/data/repository/account_repository_imp.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';
import 'package:bank_statements/src/domain/repository/transaction_repository.dart';
import 'package:bank_statements/src/domain/usecase/card_usecas_imp.dart';
import 'package:bank_statements/src/domain/usecase/card_usecase.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase.dart';
import 'package:bank_statements/src/domain/usecase/transaction_usecase_imp.dart';
import 'package:get_it/get_it.dart';

import 'src/data/local/card_database.dart';
import 'src/data/local/bank_database_imp.dart';
import 'src/data/repository/transaction_repository_imp.dart';

final injection = GetIt.instance;

void setup() {
  injection.registerSingleton<CardDatabase>(BankAccountDatabaseImp());

  injection.registerSingleton<TransactionDatabase>(BankAccountDatabaseImp());

  injection.registerSingleton<AccountRepo>(AccountRepoImp(injection()));
  injection.registerSingleton<TransactionRepository>(
      TransactionRepositoryImp(injection()));

  injection.registerSingleton<CardUseCase>(CardUseCaseImp(injection()));
  injection.registerSingleton<TransactionUseCase>(
      TransactionUsecaseImp(injection()));
}
