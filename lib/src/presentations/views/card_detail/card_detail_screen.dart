import 'package:bank_statements/src/presentations/components/register_button.dart';
import 'package:bank_statements/src/presentations/logic/transaction_controller.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:get/get.dart';

import '../../../core/app_keys.dart';
import 'widgets/animated_list_item.dart';
import 'widgets/history_item.dart';

class CardDetailScreen extends StatefulWidget {
  final String id;
  const CardDetailScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final List<Map<String, dynamic>> _items = [{}];

  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TabBar(
                onTap: (index) {
                  setState(() {});
                },
                mouseCursor: SystemMouseCursors.click,
                padding: const EdgeInsets.only(top: 35),
                controller: tabController,
                isScrollable: true,
                unselectedLabelColor: Colors.white,
                unselectedLabelStyle: theme.textTheme.subtitle2,
                labelStyle: theme.textTheme.subtitle2!.copyWith(fontSize: 26),
                indicator: UnderlineTabIndicator(
                  borderSide: BorderSide(
                    color: theme.primaryColor,
                    width: 2,
                  ),
                ),
                overlayColor: MaterialStateProperty.all(theme.primaryColor),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 15),
                tabs: const [
                  Text('تراکنش'),
                  Text('تاریخچه'),
                ],
              ),
              tabController!.index == 0
                  ? Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton.icon(
                            onPressed: () {
                              _items
                                  .insert(_items.indexOf(_items.last) + 1, {});
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.add,
                              color: theme.primaryColor,
                            ),
                            label: Text(
                              'اضافه',
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                          const SizedBox(width: 42),
                          TextButton.icon(
                            onPressed: () {
                              _items.removeAt(_items.indexOf(_items.last));
                              setState(() {});
                            },
                            icon: Icon(
                              Icons.close,
                              color: theme.primaryColor,
                            ),
                            label: Text(
                              'حذف',
                              style: theme.textTheme.bodyText1,
                            ),
                          ),
                        ],
                      ),
                    )
                  : const SizedBox(),
              Expanded(
                child: SizedBox(
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: tabController,
                      children: [
                        Form(
                          key: formKey,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          child: SingleChildScrollView(
                            child: Column(
                              children: List.generate(_items.length, (index) {
                                return AnimatedListItem(
                                  theme: theme,
                                  index: index,
                                  itemList: _items,
                                  onChange: (value) {},
                                );
                              }),
                            ),
                          ),
                        ),
                        TransactionHistory(
                          theme: theme,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: tabController!.index == 0 &&
                  MediaQuery.of(context).viewInsets.bottom == 0
              ? RegisterButton(
                  lable: 'ثبت',
                  theme: theme,
                  onPress: () {
                    if (formKey.currentState!.validate()) {
                      Get.find<TransactionController>().addTransaction(
                        cardId: widget.id,
                        value: _items,
                      );
                    }
                  },
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({
    Key? key,
    required this.theme,
  }) : super(key: key);

  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: RegisterButton(
                  lable: 'ثبت',
                  theme: theme,
                  onPress: () {},
                ),
              ),
              Expanded(
                child: RegisterButton(
                  lable: 'ثبت',
                  theme: theme,
                  onPress: () {},
                ),
              )
            ],
          ),
          SizedBox(
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'واریز',
                      style: theme.textTheme.subtitle2,
                    ),
                    Text(
                      '1000000'.seRagham(),
                      style: theme.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
                VerticalDivider(
                  color: theme.primaryColor,
                  thickness: 2,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'برداشت',
                      style: theme.textTheme.subtitle2,
                    ),
                    Text(
                      '1000000'.seRagham(),
                      style: theme.textTheme.bodyText2!
                          .copyWith(fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: GetBuilder<TransactionController>(
              builder: (transaction) {
                return ListView.builder(
                  itemCount: transaction.transactionList.length,
                  itemBuilder: (context, index) {
                    return TransactionHistoryItem(
                      theme: theme,
                      index: index,
                      transaction: transaction,
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
