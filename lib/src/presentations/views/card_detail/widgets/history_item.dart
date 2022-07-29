import 'package:flutter/material.dart';

import '../../../logic/transaction_controller.dart';

class TransactionHistoryItem extends StatelessWidget {
  final ThemeData theme;
  final int index;
  final TransactionController transaction;

  const TransactionHistoryItem({
    Key? key,
    required this.theme,
    required this.index,
    required this.transaction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    transaction.detecMode(
                      transaction.transactionList[index].transactionBalance!,
                      transaction.transactionList[index].transactionMode!,
                    ),
                    style: theme.textTheme.bodyText2,
                    textDirection: TextDirection.ltr,
                  ),
                  Text(
                    '${transaction.transactionList[index].transactionDate} - ${transaction.transactionList[index].transactionTime}',
                    style: theme.textTheme.bodyText2,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              Text(
                transaction.transactionList[index].transactionCard ?? '',
                style: theme.textTheme.bodyText2,
                textDirection: TextDirection.ltr,
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            height: 120,
            child: Align(
              alignment: Alignment.topLeft,
              child: Text(
                transaction.transactionList[index].description!,
                style: theme.textTheme.bodyText2,
                overflow: TextOverflow.fade,
              ),
            ),
          ),
          const SizedBox(height: 5),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.close, color: theme.primaryColor),
            label: Text(
              'حذف',
              style: theme.textTheme.subtitle2,
            ),
          ),
        ],
      ),
    );
  }
}
