enum ASRoutesNames {
  home,
  edit,
}

extension ASRoutesNamesConverter on ASRoutesNames {
  String get path {
    switch (this) {
      case ASRoutesNames.home:
        return "/";
      case ASRoutesNames.edit:
        return "/edit";
    }
  }
}

ASRoutesNames getASRoutesNames(String? path) {
  switch (path) {
    case "/":
      return ASRoutesNames.home;
    case "/edit":
      return ASRoutesNames.edit;
    default:
      throw ('Unknown path: $path');
  }
}
