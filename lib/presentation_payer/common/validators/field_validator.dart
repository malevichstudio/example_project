import 'package:assignment/l10n/l10n.dart';

class ASFieldRequiredValidator {
  static String? validateRequired(String? value, AppLocalizations localizations) {
    if (value == null || value.isEmpty) {
      return localizations.required;
    }
    return null;
  }
}
