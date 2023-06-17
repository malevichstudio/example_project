/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/services.dart';

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

  /// List of all assets
  List<AssetGenImage> get values => [arrow, briefcase, calendar, trash];
}

class $AssetsImagesGen {
  const $AssetsImagesGen();

  $AssetsImagesAppIconGen get appIcon => const $AssetsImagesAppIconGen();
  $AssetsImagesNoEmployeeGen get noEmployee =>
      const $AssetsImagesNoEmployeeGen();
}

class $AssetsSvgGen {
  const $AssetsSvgGen();

  /// File path: assets/svg/arrow_left.svg
  SvgGenImage get arrowLeft => const SvgGenImage('assets/svg/arrow_left.svg');

  /// File path: assets/svg/arrow_right.svg
  SvgGenImage get arrowRight => const SvgGenImage('assets/svg/arrow_right.svg');

  /// File path: assets/svg/triangle_dropdown.svg
  SvgGenImage get triangleDropdown =>
      const SvgGenImage('assets/svg/triangle_dropdown.svg');

  /// File path: assets/svg/user.svg
  SvgGenImage get user => const SvgGenImage('assets/svg/user.svg');

  /// List of all assets
  List<SvgGenImage> get values =>
      [arrowLeft, arrowRight, triangleDropdown, user];
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
  static const $AssetsSvgGen svg = $AssetsSvgGen();
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

class SvgGenImage {
  const SvgGenImage(this._assetName);

  final String _assetName;

  SvgPicture svg({
    Key? key,
    bool matchTextDirection = false,
    AssetBundle? bundle,
    String? package,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
    AlignmentGeometry alignment = Alignment.center,
    bool allowDrawingOutsideViewBox = false,
    WidgetBuilder? placeholderBuilder,
    String? semanticsLabel,
    bool excludeFromSemantics = false,
    SvgTheme theme = const SvgTheme(),
    ColorFilter? colorFilter,
    Clip clipBehavior = Clip.hardEdge,
    @deprecated Color? color,
    @deprecated BlendMode colorBlendMode = BlendMode.srcIn,
    @deprecated bool cacheColorFilter = false,
  }) {
    return SvgPicture.asset(
      _assetName,
      key: key,
      matchTextDirection: matchTextDirection,
      bundle: bundle,
      package: package,
      width: width,
      height: height,
      fit: fit,
      alignment: alignment,
      allowDrawingOutsideViewBox: allowDrawingOutsideViewBox,
      placeholderBuilder: placeholderBuilder,
      semanticsLabel: semanticsLabel,
      excludeFromSemantics: excludeFromSemantics,
      theme: theme,
      colorFilter: colorFilter,
      color: color,
      colorBlendMode: colorBlendMode,
      clipBehavior: clipBehavior,
      cacheColorFilter: cacheColorFilter,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
