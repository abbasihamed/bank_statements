class AccountModels {
  final int? id;
  final String? accountNumber;
  final String? cardNumber;
  final String? ibanNumber;
  final String? cvv2;
  final String? cardDate;
  final String? balance;

  const AccountModels(
      {this.id,
      this.accountNumber,
      this.cardNumber,
      this.ibanNumber,
      this.cvv2,
      this.cardDate,
      this.balance});

  factory AccountModels.fromMap(Map<String, dynamic> data) {
    return AccountModels(
      id: data['id'],
      accountNumber: data['accountNumber'],
      cardNumber: data['cardNumber'],
      ibanNumber: data['ibanNumber'],
      cvv2: data['cvv2'],
      cardDate: data['cardDate'],
      balance: data['balance'],
    );
  }
  Map<String, dynamic> toMap(final AccountModels accountModels) {
    return {
      'account_number': accountModels.accountNumber,
      'card_number': accountModels.cardNumber,
      'iban_number': accountModels.ibanNumber,
      'cvv2': accountModels.cvv2,
      'card_date': accountModels.cardDate,
      'balance': accountModels.balance
    };
  }
}
