import 'package:bank_statements/src/presentations/logic/validators.dart';
import 'package:flutter/material.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../components/banck_textfields.dart';

typedef DataCallBack = Function(List<Map<String, dynamic>>? value);

class AnimatedListItem extends StatefulWidget {
  const AnimatedListItem({
    Key? key,
    required this.theme,
    required this.index,
    this.onChange,
    this.itemList,
  }) : super(key: key);

  final ThemeData theme;
  final int index;
  final DataCallBack? onChange;
  final List<Map<String, dynamic>>? itemList;

  @override
  State<AnimatedListItem> createState() => _AnimatedListItemState();
}

class _AnimatedListItemState extends State<AnimatedListItem> {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: widget.theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          BankTextField(
            controller: cardNumberController,
            padding: const EdgeInsets.only(top: 10),
            theme: widget.theme,
            hintText: 'شماره کارت / حساب ...',
            onChange: (value) {
              returnData();
            },
            validator: (_) => FormValidators.validator
                .empityValidation(cardNumberController.text),
          ),
          BankTextField(
            controller: balanceController,
            padding: const EdgeInsets.only(top: 10),
            theme: widget.theme,
            hintText: 'مبلغ',
            onChange: (value) {
              balanceController.text =
                                        value.seRagham().trim();
              var currentPos = TextSelection.fromPosition(
                  TextPosition(offset: balanceController.text.length));
              balanceController.selection = currentPos;
              returnData();
            },
            validator: (_) => FormValidators.validator
                .empityValidation(balanceController.text),
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: BankTextField(
                    controller: dateController,
                    padding: const EdgeInsets.only(top: 10),
                    theme: widget.theme,
                    textAlign: TextAlign.center,
                    hintText: '1401/03/09',
                    onChange: (value) {
                      returnData();
                    },
                    validator: (_) => FormValidators.validator
                        .empityValidation(dateController.text),
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: BankTextField(
                    controller: timeController,
                    padding: const EdgeInsets.only(top: 10),
                    theme: widget.theme,
                    textAlign: TextAlign.center,
                    hintText: '15:08',
                    onChange: (value) {
                      returnData();
                    },
                    validator: (_) => FormValidators.validator
                        .empityValidation(timeController.text),
                  ),
                ),
              ],
            ),
          ),
          BankTextField(
            controller: descriptionController,
            padding: const EdgeInsets.only(top: 10),
            theme: widget.theme,
            maxLine: 3,
            textDirection: TextDirection.rtl,
            hintText: 'توضیحات',
            onChange: (value) {
              returnData();
            },
          ),
        ],
      ),
    );
  }

  returnData() {
    widget.itemList![widget.index] = {
      'description': descriptionController.text.trim(),
      'transactionCard': cardNumberController.text.trim(),
      'transactionBalance': balanceController.text.trim(),
      'transactionTime': timeController.text.trim(),
      'transactionDate': dateController.text.trim(),
      'transactionMode': 'in',
    };
    widget.onChange!(widget.itemList);
  }
}
