import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/constants.dart';
import '../../../logic/transaction_controller.dart';

class HomeBottomSheet extends StatelessWidget {
  const HomeBottomSheet({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      backgroundColor: theme.backgroundColor,
      enableDrag: false,
      elevation: 5,
      onClosing: () {},
      builder: (context) {
        return Container(
          height: 420,
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: GetBuilder<TransactionController>(
              builder: (transaction) {
                return Column(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: Divider(
                        thickness: 3,
                        endIndent: 150,
                        indent: 150,
                        color: theme.primaryColor,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'امروز، ${jalaliDate.formatter.d} ${jalaliDate.formatter.mN}',
                            style: theme.textTheme.bodyText1,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                '+ ${transaction.totalIn}',
                                style: theme.textTheme.bodyText2,
                                textDirection: TextDirection.ltr,
                              ),
                              const SizedBox(height: 5),
                              Text(
                                '- ${transaction.totalOut}',
                                style: theme.textTheme.bodyText2,
                                textDirection: TextDirection.ltr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                          padding: const EdgeInsets.only(top: 34),
                          child: ListView.separated(
                            itemCount: transaction.transactionTodayList.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            transaction.detecMode(
                                              transaction
                                                  .transactionTodayList[index]
                                                  .transactionBalance!,
                                              transaction
                                                  .transactionTodayList[index]
                                                  .transactionMode!,
                                            ),
                                            style: theme.textTheme.bodyText2,
                                            textDirection: TextDirection.ltr,
                                          ),
                                          Text(
                                            transaction
                                                .transactionTodayList[index]
                                                .transactionTime!,
                                            style: theme.textTheme.bodyText2,
                                            textDirection: TextDirection.ltr,
                                          ),
                                        ],
                                      ),
                                      Text(
                                        transaction.transactionTodayList[index]
                                                .transactionCard ??
                                            '',
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
                                        transaction.transactionTodayList[index]
                                            .description!,
                                        style: theme.textTheme.bodyText2,
                                        overflow: TextOverflow.fade,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  TextButton.icon(
                                    onPressed: () {},
                                    icon: Icon(Icons.close,
                                        color: theme.primaryColor),
                                    label: Text(
                                      'حذف',
                                      style: theme.textTheme.subtitle2,
                                    ),
                                  ),
                                ],
                              );
                            },
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return Divider(
                                thickness: 1,
                                color: theme.primaryColor,
                              );
                            },
                          )),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
