import 'package:flutter/material.dart';

import '../../../components/banck_textfields.dart';

class AnimatedListItem extends StatelessWidget {
  const AnimatedListItem({
    Key? key,
    required this.theme,
    required this.index,
    this.itemList,
  }) : super(key: key);

  final ThemeData theme;
  final int index;

  final List? itemList;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 330,
      margin: const EdgeInsets.only(top: 14, bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      decoration: BoxDecoration(
        color: theme.colorScheme.secondary,
        borderRadius: BorderRadius.circular(32),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: TextField(
                onChanged: (value) {
                  print(value);
                },
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'شماره کارت / حساب ...',
                  hintStyle:
                      theme.textTheme.bodyText2!.copyWith(color: Colors.grey),
                  suffixIcon: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    color: theme.primaryColor,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                    borderSide: BorderSide(color: theme.primaryColor),
                  ),
                ),
              ),
            ),
          ),
          BankTextField(
            padding: const EdgeInsets.only(top: 10),
            theme: theme,
            hintText: 'مبلغ',
            onChange: (value) {},
          ),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: BankTextField(
                    padding: const EdgeInsets.only(top: 10),
                    theme: theme,
                    textAlign: TextAlign.center,
                    hintText: '1401/03/09',
                    onChange: (value) {},
                  ),
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: BankTextField(
                    padding: const EdgeInsets.only(top: 10),
                    theme: theme,
                    textAlign: TextAlign.center,
                    hintText: '15:08',
                    onChange: (value) {},
                  ),
                ),
              ],
            ),
          ),
          BankTextField(
            padding: const EdgeInsets.only(top: 10),
            theme: theme,
            maxLine: 3,
            textDirection: TextDirection.rtl,
            hintText: 'توضیحات',
            onChange: (value) {},
          ),
        ],
      ),
    );
  }
}
