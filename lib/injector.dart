import 'package:bank_statements/src/data/repository/account_repository_imp.dart';
import 'package:bank_statements/src/domain/repository/account_repository.dart';
import 'package:bank_statements/src/domain/usecase/create_account_usecase.dart';
import 'package:bank_statements/src/domain/usecase/create_account_usecase_imp.dart';
import 'package:bank_statements/src/domain/usecase/fetch_account_usecase_imp.dart';
import 'package:bank_statements/src/domain/usecase/fetch_acount_usecase.dart';
import 'package:get_it/get_it.dart';

import 'src/data/local/bank_database.dart';
import 'src/data/local/bank_database_imp.dart';

final injection = GetIt.instance;

void setup() {
  injection.registerSingleton<BankDatabase>(BankAccountDatabaseImp());

  injection.registerSingleton<AccountRepo>(AccountRepoImp(injection()));

  injection.registerSingleton<CreateAccountUseCase>(
      CreateAccountUsecaseImp(injection()));

  injection.registerSingleton<FetchAccountUseCase>(
      FetchAccountUseCaseImp(injection()));
}
