import 'package:flutter/material.dart';

abstract class DgisThemeExtension extends ThemeExtension<DgisThemeExtension> {
  

  @override
  ThemeExtension<DgisThemeExtension> copyWith() {
    // mock
    return this;
  }

  @override
  ThemeExtension<DgisThemeExtension> lerp(
    covariant ThemeExtension<ThemeExtension>? other,
    double t,
  ) {
    // mock
    return this;
  }
}
