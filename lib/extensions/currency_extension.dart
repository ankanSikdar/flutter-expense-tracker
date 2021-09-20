import 'dart:io';

import 'package:intl/intl.dart';

final formatter = NumberFormat.compactSimpleCurrency(
    locale: Platform.localeName, decimalDigits: 2);

extension CurrencyParsing on double {
  String parseCurrency() {
    return formatter.format(this);
  }
}

String getCurrencySymbol() {
  return formatter.currencySymbol;
}
