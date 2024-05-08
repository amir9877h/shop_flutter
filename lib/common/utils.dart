import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

const defaultscrollphysics = BouncingScrollPhysics();

extension PriceLable on int {
  String get withPriceLable => this <= 0 ? 'رایگان' : '$separateByComma تومان';

  String get separateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
