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

class _AnimatedListItemState extends State<AnimatedListItem>
    with SingleTickerProviderStateMixin {
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController balanceController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();

  late Animation<double> _animation;
  late AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
    cardNumberController.dispose();
    balanceController.dispose();
    dateController.dispose();
    timeController.dispose();
    descriptionController.dispose();
  }

  String val = 'in';
  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) => Opacity(
        opacity: _animation.value,
        child: Container(
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
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BankRadioButton(
                      theme: widget.theme,
                      title: 'واریز',
                      value: 'in',
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {});
                        val = value!;
                      },
                    ),
                    BankRadioButton(
                      theme: widget.theme,
                      title: 'برداشت',
                      value: 'out',
                      groupValue: val,
                      onChanged: (value) {
                        setState(() {});
                        val = value!;
                      },
                    ),
                  ],
                ),
              ),
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
                  balanceController.text = value.seRagham().trim();
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
        ),
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
      'transactionMode': val,
    };
    widget.onChange!(widget.itemList);
  }
}

class BankRadioButton<T> extends StatelessWidget {
  const BankRadioButton({
    Key? key,
    required this.theme,
    required this.title,
    required this.onChanged,
    required this.value,
    required this.groupValue,
  }) : super(key: key);

  final ThemeData theme;
  final String title;
  final String value;
  final String groupValue;
  final ValueChanged<String?>? onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Radio(
          value: value,
          groupValue: groupValue,
          onChanged: onChanged,
          activeColor: theme.primaryColor,
        ),
        Text(
          title,
          style: theme.textTheme.bodyText1,
        )
      ],
    );
  }
}
