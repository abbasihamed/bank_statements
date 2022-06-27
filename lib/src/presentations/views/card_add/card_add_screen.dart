import 'package:bank_statements/src/presentations/logic/ad_card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

class CardAddScreen extends StatefulWidget {
  const CardAddScreen({Key? key}) : super(key: key);

  @override
  State<CardAddScreen> createState() => _CardAddScreenState();
}

class _CardAddScreenState extends State<CardAddScreen> {
  final MaskTextInputFormatter _cardMask =
      MaskTextInputFormatter(mask: '#### #### #### ####');
  final TextEditingController _balancController = TextEditingController();
  String? _cardNumber;
  String? _balance;
  String? _date;
  String? _cvv2;
  String? _accountNumber;
  String? _iban;
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
    Get.lazyPut(() => AddCardController());
    return SafeArea(
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.9,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.only(top: 100),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.secondary,
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32),
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      child: Center(
                          child: Container(
                        margin: EdgeInsets.only(
                            top: MediaQuery.of(context).viewInsets.bottom != 0
                                ? 80
                                : 0),
                        height: size.height * 0.5,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              BankTextField(
                                theme: theme,
                                hintText: 'شماره کارت',
                                inputFormatter: [_cardMask],
                                onChange: (value) {
                                  _cardNumber =
                                      value.charRagham(separator: " ").trim();
                                  setState(() {});
                                },
                              ),
                              BankTextField(
                                theme: theme,
                                hintText: 'شماره حساب',
                                onChange: (value) {
                                  _accountNumber = value.trim();
                                },
                              ),
                              BankTextField(
                                theme: theme,
                                hintText: 'شماره شبا',
                                onChange: (value) {
                                  _iban = value.trim();
                                },
                              ),
                              BankTextField(
                                theme: theme,
                                controller: _balancController,
                                hintText: 'موجودی فعلی',
                                onChange: (value) {
                                  _balancController.text =
                                      value.seRagham().trim();
                                  _balance = value.seRagham().trim();
                                  var currentPos = TextSelection.fromPosition(
                                      TextPosition(
                                          offset:
                                              _balancController.text.length));
                                  _balancController.selection = currentPos;
                                  setState(() {});
                                },
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: BankTextField(
                                      theme: theme,
                                      hintText: '1401/03/29',
                                      onChange: (value) {
                                        _date = value.trim();
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 34),
                                  Expanded(
                                    child: BankTextField(
                                      theme: theme,
                                      hintText: 'CVV2',
                                      onChange: (value) {
                                        _cvv2 = value.trim();
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )),
                    ),
                  ),
                  Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    child: Container(
                      width: 350,
                      height: 200,
                      margin: const EdgeInsets.symmetric(horizontal: 24),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 24),
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
                            _balance ?? '',
                            style: theme.textTheme.subtitle1!
                                .copyWith(letterSpacing: 1.2),
                          ),
                          const SizedBox(height: 60),
                          Text(
                            _cardNumber ?? '',
                            style: theme.textTheme.subtitle2,
                            textDirection: TextDirection.ltr,
                          ),
                          const SizedBox(height: 24),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                _cvv2 ?? '',
                                style: theme.textTheme.bodyText2,
                                textDirection: TextDirection.ltr,
                              ),
                              Text(
                                _date ?? '',
                                style: theme.textTheme.bodyText2,
                                textDirection: TextDirection.ltr,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
              ? GestureDetector(
                  onTap: () {
                    Get.find<AddCardController>().addCard(
                      cardNumber: _cardNumber!,
                      accountNumber: _accountNumber!,
                      iban: _iban!,
                      balance: _balance!,
                      cvv2: _cvv2!,
                      date: _date!,
                    );
                  },
                  child: Container(
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

class BankTextField extends StatelessWidget {
  final ThemeData theme;
  final String hintText;
  final Function(String) onChange;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  const BankTextField({
    Key? key,
    required this.theme,
    required this.hintText,
    required this.onChange,
    this.controller,
    this.inputFormatter,
    this.textInputType,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 22),
      child: SizedBox(
        height: 50,
        width: double.infinity,
        child: Center(
          child: TextField(
            controller: controller,
            onChanged: onChange,
            style: theme.textTheme.bodyText1,
            inputFormatters: inputFormatter,
            textDirection: TextDirection.ltr,
            keyboardType: textInputType ?? TextInputType.number,
            decoration: InputDecoration(
              hintText: hintText,
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
    );
  }
}