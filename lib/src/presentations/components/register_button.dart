import 'package:flutter/material.dart';

class RegisterButton extends StatelessWidget {
  final ThemeData theme;

  final String lable;
  final VoidCallback? onPress;

  const RegisterButton({
    Key? key,
    required this.lable,
    required this.theme,
    this.onPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        height: 50,
        width: double.infinity,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 12),
        decoration: BoxDecoration(
          color: theme.primaryColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Text(
          lable,
          style: theme.textTheme.subtitle1!.copyWith(fontSize: 26),
        ),
      ),
    );
  }
}
