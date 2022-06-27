import 'package:flutter/material.dart';

import '../../../core/app_key.dart';

class CardDetailScreen extends StatefulWidget {
  const CardDetailScreen({Key? key}) : super(key: key);

  @override
  State<CardDetailScreen> createState() => _CardDetailScreenState();
}

class _CardDetailScreenState extends State<CardDetailScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;

  final _items = ["Item 0"];
  void _addItem() {
    _items.insert(0, "Item ${_items.length + 1}");
    animKey.currentState!
        .insertItem(0, duration: const Duration(milliseconds: 300));
  }

  void _removeItem(int index, BuildContext context) {
    animKey.currentState!.removeItem(index, (_, animation) {
      return SizeTransition(
        sizeFactor: animation,
        child: AnimatedListItem(
          theme: Theme.of(context),
          index: index,
        ),
      );
    }, duration: const Duration(milliseconds: 300));
    _items.removeAt(index);
  }

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
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: _addItem,
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
                        _removeItem(0, context);
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
              ),
              Expanded(
                child: SizedBox(
                  height: size.height,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        AnimatedList(
                          key: animKey,
                          initialItemCount: _items.length,
                          itemBuilder: (context, index, animation) {
                            return SizeTransition(
                              sizeFactor: animation,
                              child:
                                  AnimatedListItem(theme: theme, index: index),
                            );
                          },
                        ),
                        Container(),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
          floatingActionButton: tabController!.index == 0 &&
                  MediaQuery.of(context).viewInsets.bottom == 0
              ? Container(
                  height: 50,
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin:
                      const EdgeInsets.only(left: 24, right: 24, bottom: 12),
                  decoration: BoxDecoration(
                    color: theme.primaryColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    'ثبت',
                    style: theme.textTheme.subtitle1!.copyWith(fontSize: 26),
                  ),
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }
}

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
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
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
          const SizedBox(height: 10),
          SizedBox(
            height: 50,
            width: double.infinity,
            child: Center(
              child: TextField(
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'مبلغ',
                  hintStyle:
                      theme.textTheme.bodyText2!.copyWith(color: Colors.grey),
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
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1,
                        decoration: InputDecoration(
                          hintText: '1401/03/09',
                          hintStyle: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.grey),
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
                ),
                const SizedBox(width: 24),
                Expanded(
                  child: SizedBox(
                    height: 50,
                    width: double.infinity,
                    child: Center(
                      child: TextField(
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyText1,
                        decoration: InputDecoration(
                          hintText: '15:08',
                          hintStyle: theme.textTheme.bodyText2!
                              .copyWith(color: Colors.grey),
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
                ),
              ],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: Center(
              child: TextField(
                maxLines: 3,
                style: theme.textTheme.bodyText1,
                decoration: InputDecoration(
                  hintText: 'توضیحات',
                  hintStyle:
                      theme.textTheme.bodyText2!.copyWith(color: Colors.grey),
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
        ],
      ),
    );
  }
}
