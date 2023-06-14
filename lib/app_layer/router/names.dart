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
