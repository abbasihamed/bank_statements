import 'package:shamsi_date/shamsi_date.dart';

DateTime date = DateTime.now();

final Jalali jalaliDate = date.toJalali();

 final String current =
      '${jalaliDate.year}/${jalaliDate.month}/${jalaliDate.day}';
