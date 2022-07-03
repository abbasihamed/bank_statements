class Transaction {
  final int? id;
  final int? cardId;
  final String? transactionDate;
  final String? transactionTime;
  final String? transactionBalance;
  final String? transactionMode;
  final String? description;

  const Transaction({
    this.id,
    this.cardId,
    this.transactionDate,
    this.transactionTime,
    this.transactionBalance,
    this.transactionMode,
    this.description,
  });
}
