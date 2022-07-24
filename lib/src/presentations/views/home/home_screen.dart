import 'package:bank_statements/src/config/app_routing.dart';
import 'package:bank_statements/src/core/app_keys.dart';
import 'package:bank_statements/src/data/model/bank_account.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/constants.dart';
import '../../logic/balance_controller.dart';
import '../../logic/card_controller.dart';
import '../../logic/transaction_controller.dart';
import 'widgets/card_slider_item.dart';
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
        .getData(id: pageController!.initialPage + 1, date: current);
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
                                  .getData(id: index + 1, date: current);
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
