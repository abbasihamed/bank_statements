import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BankTextField extends StatelessWidget {
  final ThemeData theme;
  final String hintText;
  final Function(String) onChange;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatter;
  final TextInputType? textInputType;
  final TextAlign? textAlign;
  final EdgeInsets? padding;
  final int? maxLine;
  final TextDirection? textDirection;
  final String? suffixText;
  final FocusNode? focusNode;
  final String? Function(String?)? validator;
  const BankTextField({
    Key? key,
    required this.theme,
    required this.hintText,
    required this.onChange,
    this.controller,
    this.inputFormatter,
    this.textInputType = TextInputType.text,
    this.padding = const EdgeInsets.only(top: 22),
    this.textAlign = TextAlign.start,
    this.suffixText,
    this.maxLine = 1,
    this.textDirection = TextDirection.ltr,
    this.focusNode,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding!,
      child: SizedBox(
        height: maxLine != null ? null : 50,
        width: double.infinity,
        child: Center(
          child: TextFormField(
            validator: validator,
            controller: controller,
            onChanged: onChange,
            focusNode: focusNode,
            textAlign: textAlign!,
            maxLines: maxLine,
            style: theme.textTheme.bodyText1,
            inputFormatters: inputFormatter,
            textDirection: textDirection,
            keyboardType: textInputType,
            cursorColor: Colors.white,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle:
                  theme.textTheme.bodyText2!.copyWith(color: Colors.grey),
              suffixText: suffixText,
              suffixStyle: theme.textTheme.bodyText2,
              errorStyle:
                  theme.textTheme.overline!.copyWith(color: theme.errorColor),
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
