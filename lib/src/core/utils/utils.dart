import 'package:intl/intl.dart';

extension StringExtension on String {
  String capitalize() =>
      "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
}

NumberFormat currencyFormat = NumberFormat.currency(
  locale: "es_CO",
  decimalDigits: 0,
  symbol: "",
);

String convertIntIntoCurrency(double amount) => currencyFormat.format(amount);

bool _isWithinTimeRange({required int startHour, required int endHour}) {
  final currentHour = DateTime.now().hour;

  return currentHour >= startHour && currentHour < endHour;
}

bool canEnableExpressExperience() =>
    _isWithinTimeRange(startHour: 10, endHour: 16);
