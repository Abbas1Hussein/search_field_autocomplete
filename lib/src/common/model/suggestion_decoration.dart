import 'package:flutter/widgets.dart';

/// The decoration properties for customizing the appearance,
/// of individual suggestions in the autocomplete list.
class SuggestionDecoration extends BoxDecoration {
  const SuggestionDecoration({
    super.color,
    super.border,
    super.borderRadius,
    super.boxShadow,
    super.gradient,
    super.backgroundBlendMode,
    this.marginSuggestions,
    this.paddingSuggestions,
  });

  /// Empty space to surround the [SuggestionDecoration].
  final EdgeInsetsGeometry? marginSuggestions;

  /// Empty space to inscribe inside the [SuggestionDecoration].
  final EdgeInsetsGeometry? paddingSuggestions;
}
