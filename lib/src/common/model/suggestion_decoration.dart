import 'package:flutter/widgets.dart';

/// A class representing the decoration properties for customizing the appearance
/// of individual suggestions in the autocomplete list.
class SuggestionDecoration {
  /// The padding around the suggestions.
  final EdgeInsetsGeometry padding;

  /// The border radius of the suggestions.
  final BorderRadiusGeometry borderRadius;

  /// The list of box shadows for the suggestions.
  final List<BoxShadow>? boxShadow;

  /// The gradient to apply to the suggestions background.
  final Gradient? gradient;

  /// The shape of the suggestions. Defaults to [BoxShape.rectangle].
  final BoxShape shape;

  /// The background color of the suggestion item.
  final Color? color;

  /// The border of the suggestion item.
  final Border? border;

  /// Creates a [SuggestionDecoration] with the specified decoration properties.
  ///
  /// The [padding], [borderRadius], [boxShadow], [gradient], [shape], [color], and [border]
  /// are optional and can be customized to style the suggestion item.
  SuggestionDecoration({
    this.padding = EdgeInsets.zero,
    this.borderRadius = BorderRadius.zero,
    this.boxShadow,
    this.gradient,
    this.shape = BoxShape.rectangle,
    this.color,
    this.border,
  });

  /// Converts the [SuggestionDecoration] into a [BoxDecoration].
  ///
  /// This getter allows you to easily apply the decoration to the suggestions.
  ///
  /// ```dart
  /// SuggestionDecoration(
  ///   color: Colors.blue,
  ///   borderRadius: BorderRadius.circular(8.0),
  /// ).boxDecoration
  /// ```
  BoxDecoration get boxDecoration {
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
