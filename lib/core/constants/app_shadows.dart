import 'package:flutter/material.dart';

/// Centralized elevation shadows. Tinted from the darkest neutral
/// (rather than pure black) so elevated surfaces read as soft and
/// professional instead of harsh — deliberately subtle, since this app
/// is often viewed in bright outdoor light where heavy shadows just look
/// like noise.
class AppShadows {
  const AppShadows._();

  static const List<BoxShadow> sm = [
    BoxShadow(color: Color(0x14141A15), blurRadius: 4, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> md = [
    BoxShadow(color: Color(0x1A141A15), blurRadius: 12, offset: Offset(0, 4)),
    BoxShadow(color: Color(0x0F141A15), blurRadius: 2, offset: Offset(0, 1)),
  ];

  static const List<BoxShadow> lg = [
    BoxShadow(color: Color(0x26141A15), blurRadius: 24, offset: Offset(0, 8)),
  ];
}
