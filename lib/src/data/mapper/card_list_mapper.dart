import 'package:bank_statements/src/data/model/bank_account.dart';

class CardListMapper {
  static List<AccountModels> toList(List<Map<String, dynamic>> data) {
    final value = data.map((e) {
     return AccountModels(
          accountNumber: e['account_number'],
          cardNumber: e['card_number'],
          ibanNumber: e['iban_number'],
          cvv2: e['cvv2'],
          cardDate: e['card_date'],
          balance: e['balance']);
    }).toList();
    return value;
  }
}
