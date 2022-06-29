import 'package:get/get.dart';

class FormValidators extends GetxController {
  empityValidation(String value, {String? input}) {
    if (value.isEmpty) {
      return '${input ?? ''} نمی تواند خالی باشد';
    } else {
      return null;
    }
  }

  cardNumberValidation(String cardNumber) {
    if (cardNumber.isEmpty) {
      return empityValidation(cardNumber, input: 'شماره کارت');
    } else if (cardNumber.isNotEmpty && cardNumber.length < 19) {
      return 'شماره کارت معتبر نمی باشد';
    } else {
      return null;
    }
  }

  cardIbanValidation(String iban) {
    if (iban.isEmpty) {
      return empityValidation(iban, input: 'شبا');
    } else if (iban.length < 24) {
      return 'شماره شبا معتبر نمی باشد';
    } else {
      return null;
    }
  }

  cardDateValidation(String date) {
    if (date.contains('/')) {
      final value = date.split('/');
      if (int.parse(value[0]) > 12 && int.parse(value[1]) > 31) {
        return 'فرمت اشتباه است';
      } else {
        return null;
      }
    } else if (date.isEmpty) {
      return empityValidation(date, input: 'تاریخ');
    } else {
      return 'فرمت اشتباه است';
    }
  }
}
