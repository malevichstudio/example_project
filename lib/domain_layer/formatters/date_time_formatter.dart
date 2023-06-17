import 'package:assignment/l10n/l10n.dart';
import 'package:intl/intl.dart';

class ASDateFormatter {
  final DateFormat formatter;

  ASDateFormatter({String pattern = 'd MMM y'}) : formatter = DateFormat(pattern, Intl.getCurrentLocale());

  String formatDatePicker({required DateTime? date, required AppLocalizations localization}) {
    if (date == null) {
      return localization.noDate;
    }
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate = DateTime(date.year, date.month, date.day);

    if (aDate == today) {
      return localization.today;
    } else {
      return formatter.format(aDate);
    }
  }
}
