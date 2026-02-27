import 'package:intl/intl.dart';

class Format {
  static final _currency = NumberFormat.decimalPattern('ar');

  static String price(double value) {
    // في اليمن غالباً يتم عرض السعر بدون فاصلة عشرية
    final v = value.round();
    return '${_currency.format(v)} ر.ي';
  }
}
