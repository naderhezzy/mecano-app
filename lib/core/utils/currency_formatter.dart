import 'package:intl/intl.dart';

class CurrencyFormatter {
  CurrencyFormatter._();

  static final _tndFormat = NumberFormat.currency(
    locale: 'fr_TN',
    symbol: 'TND',
    decimalDigits: 3,
  );

  static String formatTND(double amount) => _tndFormat.format(amount);

  static String formatTNDCompact(double amount) {
    if (amount >= 1000) {
      return '${(amount / 1000).toStringAsFixed(1)}K TND';
    }
    return formatTND(amount);
  }
}
