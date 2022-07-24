import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../../config/app_routing.dart';
import '../../../../data/model/bank_account.dart';
import '../../../logic/balance_controller.dart';

class HomeCardSliderItem extends StatelessWidget {
  final ThemeData theme;
  final List<AccountModels> cardList;
  final int index;
  const HomeCardSliderItem({
    Key? key,
    required this.theme,
    required this.cardList,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Get.find<BalanceController>().cacheCardData(cardList[index]);
          AppRoute.appRoute.navigateTo(context, '/carddetail/${index + 1}');
        },
        child: Container(
          width: 350,
          height: 200,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          decoration: BoxDecoration(
            color: theme.colorScheme.secondary,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                cardList[index].balance?.seRagham() ?? '',
                style: theme.textTheme.subtitle1!.copyWith(letterSpacing: 1.2),
              ),
              const SizedBox(height: 60),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Icon(Icons.copy, color: theme.primaryColor, size: 18),
                  const SizedBox(width: 10),
                  Text(
                    cardList[index].cardNumber ?? '',
                    style: theme.textTheme.subtitle2,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    cardList[index].cvv2 ?? '',
                    style: theme.textTheme.bodyText2,
                    textDirection: TextDirection.ltr,
                  ),
                  Text(
                    cardList[index].cardDate ?? '',
                    style: theme.textTheme.bodyText2,
                    textDirection: TextDirection.ltr,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
