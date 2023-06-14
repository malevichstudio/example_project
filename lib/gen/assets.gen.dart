/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsIconsGen {
  const $AssetsIconsGen();

  /// File path: assets/icons/arrow.png
  AssetGenImage get arrow => const AssetGenImage('assets/icons/arrow.png');

  /// File path: assets/icons/briefcase.png
  AssetGenImage get briefcase =>
      const AssetGenImage('assets/icons/briefcase.png');

  /// File path: assets/icons/calendar.png
  AssetGenImage get calendar =>
      const AssetGenImage('assets/icons/calendar.png');

  /// File path: assets/icons/trash.png
  AssetGenImage get trash => const AssetGenImage('assets/icons/trash.png');

  /// File path: assets/icons/user.png
  AssetGenImage get user => const AssetGenImage('assets/icons/user.png');

  /// List of all assets
  List<AssetGenImage> get values => [arrow, briefcase, calendar, trash, user];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesAppIconGen get appIcon => const $AssetsImagesAppIconGen();
  $AssetsImagesNoEmployeeGen get noEmployee =>
      const $AssetsImagesNoEmployeeGen();
}

class $AssetsImagesAppIconGen {
  const $AssetsImagesAppIconGen();

  /// File path: assets/images/app_icon/app_icon.png
  AssetGenImage get appIcon =>
      const AssetGenImage('assets/images/app_icon/app_icon.png');

  /// List of all assets
  List<AssetGenImage> get values => [appIcon];
}

class $AssetsImagesNoEmployeeGen {
  const $AssetsImagesNoEmployeeGen();

  /// File path: assets/images/no_employee/no_employee.png
  AssetGenImage get noEmployee =>
      const AssetGenImage('assets/images/no_employee/no_employee.png');

  /// List of all assets
  List<AssetGenImage> get values => [noEmployee];
}

class Assets {
  Assets._();

  static const $AssetsIconsGen icons = $AssetsIconsGen();
  static const $AssetsImagesGen images = $AssetsImagesGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
