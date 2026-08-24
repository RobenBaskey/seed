import 'package:flutter/material.dart';

import '../constants/app_radius.dart';
import '../constants/app_spacing.dart';

/// Standard surface container: rounded corners, hairline border, and
/// (when [onTap] is set) a ripple — used anywhere content needs to sit
/// on an elevated surface (list rows, dashboard tiles, form sections).
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(AppSpacing.cardPadding),
    this.margin,
    this.onTap,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final EdgeInsetsGeometry? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final cardTheme = Theme.of(context).cardTheme;
    final shape = cardTheme.shape as RoundedRectangleBorder?;
    final radius = (shape?.borderRadius as BorderRadius?) ?? BorderRadius.circular(AppRadius.card);

    return Container(
      margin: margin,
      decoration: BoxDecoration(
        color: cardTheme.color,
        borderRadius: radius,
        border: shape?.side != null ? Border.fromBorderSide(shape!.side) : null,
      ),
      clipBehavior: Clip.antiAlias,
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}
