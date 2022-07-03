import 'package:bank_statements/src/config/app_routing.dart';
import 'package:bank_statements/src/presentations/logic/card_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:persian_number_utility/persian_number_utility.dart';

import '../../../core/app_keys.dart';
import '../../components/banck_textfields.dart';
import '../../components/register_button.dart';
import '../../logic/validators.dart';
import 'widgets/top_card.dart';

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
  final FocusNode _accountNumberFocus = FocusNode();
  final FocusNode _balanceFocus = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;
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
                          child: GetBuilder<FormValidators>(
                              init: FormValidators(),
                              builder: (validator) {
                                return Form(
                                  key: _formKey,
                                  autovalidateMode: AutovalidateMode.always,
                                  child: Column(
                                    children: [
                                      BankTextField(
                                        theme: theme,
                                        hintText: 'شماره کارت',
                                        inputFormatter: [_cardMask],
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          _cardNumber = value
                                              .charRagham(separator: " ")
                                              .trim();
                                          changeFocus(
                                            focusNode: _accountNumberFocus,
                                            firstLength: _cardNumber!.length,
                                            secondLength: 19,
                                          );
                                          setState(() {});
                                        },
                                        validator: (_) =>
                                            validator.cardNumberValidation(
                                                _cardNumber ?? ""),
                                      ),
                                      BankTextField(
                                        theme: theme,
                                        focusNode: _accountNumberFocus,
                                        hintText: 'شماره حساب',
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          _accountNumber = value.trim();
                                        },
                                        validator: (_) =>
                                            validator.empityValidation(
                                                _accountNumber ?? '',
                                                input: 'شماره حساب'),
                                      ),
                                      BankTextField(
                                        theme: theme,
                                        hintText: 'شماره شبا',
                                        suffixText: 'IR',
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          _iban = value.trim();
                                          changeFocus(
                                            focusNode: _balanceFocus,
                                            firstLength: _iban!.length,
                                            secondLength: 24,
                                          );
                                        },
                                        validator: (_) => validator
                                            .cardIbanValidation(_iban ?? ''),
                                      ),
                                      BankTextField(
                                        theme: theme,
                                        focusNode: _balanceFocus,
                                        controller: _balancController,
                                        hintText: 'موجودی فعلی',
                                        textInputType: TextInputType.number,
                                        onChange: (value) {
                                          _balancController.text =
                                              value.seRagham().trim();
                                          _balance = value.seRagham().trim();
                                          var currentPos =
                                              TextSelection.fromPosition(
                                                  TextPosition(
                                                      offset: _balancController
                                                          .text.length));
                                          _balancController.selection =
                                              currentPos;
                                          validator
                                              .empityValidation(_balance ?? '');
                                          setState(() {});
                                        },
                                        validator: (_) => validator
                                            .empityValidation(_balance ?? ''),
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: BankTextField(
                                              theme: theme,
                                              textAlign: TextAlign.center,
                                              hintText: '03/29',
                                              textInputType:
                                                  TextInputType.number,
                                              onChange: (value) {
                                                _date = value.trim();
                                              },
                                              validator: (_) =>
                                                  validator.cardDateValidation(
                                                      _date ?? ''),
                                            ),
                                          ),
                                          const SizedBox(width: 34),
                                          Expanded(
                                            child: BankTextField(
                                              theme: theme,
                                              textAlign: TextAlign.center,
                                              hintText: 'CVV2',
                                              textInputType:
                                                  TextInputType.number,
                                              onChange: (value) {
                                                _cvv2 = value.trim();
                                              },
                                              validator: (_) =>
                                                  validator.empityValidation(
                                                      _cvv2 ?? ''),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                );
                              }),
                        ),
                      )),
                    ),
                  ),
                  TopCard(
                    theme: theme,
                    balance: _balance,
                    cardNumber: _cardNumber,
                    cvv2: _cvv2,
                    date: _date,
                  ),
                ],
              ),
            ),
          ),
          floatingActionButton: MediaQuery.of(context).viewInsets.bottom == 0
              ? RegisterButton(
                  onPress: () {
                    if (_formKey.currentState!.validate()) {
                      Get.find<CardController>().addCard(
                        cardNumber: _cardNumber!,
                        accountNumber: _accountNumber!,
                        iban: _iban!,
                        balance: _balance!,
                        cvv2: _cvv2!,
                        date: _date!,
                      );
                    }
                  },
                  lable: 'ثبت',
                  theme: theme,
                )
              : null,
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
        ),
      ),
    );
  }

  void changeFocus(
      {required FocusNode focusNode,
      required int firstLength,
      required int secondLength}) {
    if (firstLength == secondLength) {
      focusNode.requestFocus();
    }
  }
}
