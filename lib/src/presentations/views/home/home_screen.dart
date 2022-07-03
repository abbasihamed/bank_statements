import 'package:bank_statements/src/config/app_routing.dart';
import 'package:bank_statements/src/core/app_keys.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../logic/card_controller.dart';
import '../../logic/transaction_controller.dart';

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
                            onPageChanged: (index) {},
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
            child: Column(
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
                        'امروز، 20 آذر',
                        style: theme.textTheme.bodyText1,
                      ),
                      Column(
                        children: [
                          Text(
                            '+ 30,000,000',
                            style: theme.textTheme.bodyText2,
                            textDirection: TextDirection.ltr,
                          ),
                          const SizedBox(height: 5),
                          Text(
                            '- 10,000,000',
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
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '+ 30,000,000',
                                      style: theme.textTheme.bodyText2,
                                      textDirection: TextDirection.ltr,
                                    ),
                                    Text(
                                      '10:05',
                                      style: theme.textTheme.bodyText2,
                                      textDirection: TextDirection.ltr,
                                    ),
                                  ],
                                ),
                                Text(
                                  '6037 9919 2194 4646',
                                  style: theme.textTheme.bodyText2,
                                  textDirection: TextDirection.ltr,
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Duis posuere ligula augue, quis porta mi facilisis non. Sed consequat maximus velit non ornare. Etiam eu urna et nunc convallis rhoncus',
                              style: theme.textTheme.bodyText2,
                              overflow: TextOverflow.fade,
                            ),
                            const SizedBox(height: 5),
                            TextButton.icon(
                              onPressed: () {},
                              icon:
                                  Icon(Icons.close, color: theme.primaryColor),
                              label: Text(
                                'حذف',
                                style: theme.textTheme.subtitle2,
                              ),
                            ),
                          ],
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return Divider(
                          thickness: 1,
                          color: theme.primaryColor,
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
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
