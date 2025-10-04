import 'package:flutter/material.dart';
import 'package:two_gis_hackaton/theme/dgis_theme_extension.dart';

extension XBuildContextContext on BuildContext {
  ThemeExtension dgisTheme() {
    return Theme.of(this).extension<DgisThemeExtension>()!;
  }
}
