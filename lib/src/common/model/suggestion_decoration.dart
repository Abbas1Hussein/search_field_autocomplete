import 'package:flutter/widgets.dart';

class SuggestionDecoration {
  /// padding around the suggestion list
  final EdgeInsetsGeometry padding;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow>? boxShadow;
  final Gradient? gradient;
  final BoxShape shape;
  final Color? color;
  final Border? border;

  SuggestionDecoration({
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.boxShadow,
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.color,
    this.border,
  });

  BoxDecoration toBoxDecoration() {
    return BoxDecoration(
      color: color,
      gradient: gradient,
      borderRadius: borderRadius,
      border: border,
      shape: shape,
      boxShadow: boxShadow,
    );
  }
}
