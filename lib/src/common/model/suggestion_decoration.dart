import 'package:flutter/widgets.dart';

class SuggestionDecoration extends BoxDecoration {
  /// padding around the suggestion list
  @override
  final EdgeInsetsGeometry padding;

  const SuggestionDecoration({
    this.padding = EdgeInsets.zero,
    Color? color,
    Border? border,
    BorderRadiusGeometry? borderRadius,
    List<BoxShadow>? boxShadow,
    Gradient? gradient,
    BoxShape shape = BoxShape.rectangle,
  }) : super(
          color: color,
          border: border,
          borderRadius: borderRadius,
          boxShadow: boxShadow,
          gradient: gradient,
          shape: shape,

        );
}
