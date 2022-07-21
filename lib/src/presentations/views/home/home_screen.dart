import 'package:bank_statements/src/config/app_routing.dart';
import 'package:bank_statements/src/core/app_keys.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/balance_controller.dart';
import '../../logic/card_controller.dart';
import '../../logic/transaction_controller.dart';
import 'widgets/home_bottom_sheet.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController? pageController;
  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.9);
  }

  @override
  Widget build(BuildContext context) {
    Get.lazyPut(() => CardController());
    Get.lazyPut(() => TransactionController());
    Get.lazyPut(() => BalanceController());
    Get.find<TransactionController>()
        .getData(id: pageController!.initialPage + 1);
    final theme = Theme.of(context);
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: SizedBox(
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 35, right: 24, bottom: 35),
                    child: Text(
                      'کارت ها',
                      style: theme.textTheme.headline6,
                    ),
                  ),
                  SizedBox(
                    height: 200,
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: GetBuilder<CardController>(
                        builder: (cardController) {
                          return PageView.builder(
                            controller: pageController,
                            reverse: true,
                            scrollDirection: Axis.horizontal,
                            itemCount: cardController.cardList.length + 1,
                            onPageChanged: (index) {
                              Get.find<TransactionController>()
                                  .getData(id: index + 1);
                            },
                            itemBuilder: (context, index) {
                              return index < cardController.cardList.length
                                  ? HomeCardSliderItem(
                                      theme: theme,
                                      cardList: cardController.cardList,
                                      index: index,
                                    )
                                  : Center(
                                      child: GestureDetector(
                                        onTap: () {
                                          navKey.currentState!
                                              .pushNamed('/cardadd');
                                        },
                                        child: Container(
                                          width: 350,
                                          height: 200,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 24),
                                          decoration: BoxDecoration(
                                            color: theme.colorScheme.secondary,
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.add,
                                                color: theme.primaryColor,
                                                size: 100,
                                              ),
                                              Text(
                                                'اضافه کردن کارت',
                                                style:
                                                    theme.textTheme.headline6,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: HomeBottomSheet(theme: theme),
        ),
      ),
    );
  }
}

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
                cardList[index].balance ?? '',
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
