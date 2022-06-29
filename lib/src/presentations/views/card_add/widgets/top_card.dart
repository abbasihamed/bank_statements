import 'package:flutter/material.dart';




class TopCard extends StatelessWidget {
  final ThemeData theme;
  final String? balance;
  final String? cardNumber;
  final String? cvv2;
  final String? date;
  const TopCard({
    Key? key,
    required this.theme,
    required this.balance,
    required this.cardNumber,
    required this.cvv2,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: 350,
        height: 200,
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
        decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(32),
            boxShadow: [
              BoxShadow(
                color: Colors.grey[900]!,
                blurRadius: 8,
                spreadRadius: 0,
                offset: const Offset(-0, 4),
              )
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              balance ?? '',
              style: theme.textTheme.subtitle1!.copyWith(letterSpacing: 1.2),
            ),
            const SizedBox(height: 60),
            Text(
              cardNumber ?? '',
              style: theme.textTheme.subtitle2,
              textDirection: TextDirection.ltr,
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cvv2 ?? '',
                  style: theme.textTheme.bodyText2,
                  textDirection: TextDirection.ltr,
                ),
                Text(
                  date ?? '',
                  style: theme.textTheme.bodyText2,
                  textDirection: TextDirection.ltr,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
