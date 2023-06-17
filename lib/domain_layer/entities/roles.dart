import 'package:assignment/l10n/l10n.dart';

enum ASRoles { productDesigner, flutterDeveloper, qaTester, productOwner }

extension ASRolesConverterManager on ASRoles {
  String name(AppLocalizations localization) {
    switch (this) {
      case ASRoles.productDesigner:
        return localization.productDesigner;
      case ASRoles.flutterDeveloper:
        return localization.flutterDeveloper;
      case ASRoles.qaTester:
        return localization.qaTester;
      case ASRoles.productOwner:
        return localization.productOwner;
    }
  }
}
