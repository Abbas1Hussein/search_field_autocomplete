import 'package:flutter/widgets.dart';

/// A  properties for customizing the appearance and behavior of a scrollbar.
class ScrollbarProperties {
  /// Creates a new instance of [ScrollbarProperties].
  ///
  /// The [scrollbarAlwaysVisible] parameter determines whether the scrollbar
  /// should always be visible or only when scrolling. The default is `true`.
  ///
  /// The [scrollbarDecoration] parameter allows you to provide custom decoration
  /// for the scrollbar. If `null`, the default decoration will be used.
  ///
  /// The [scrollbarOrientation] parameter specifies the orientation of the scrollbar
  /// (vertical or horizontal). If `null`, the orientation will be determined automatically.
  ///
  /// The [notificationPredicate] parameter allows you to provide a predicate function
  /// to determine whether to show the scrollbar for a specific notification.
  const ScrollbarProperties({
    this.scrollbarDecoration,
    this.scrollbarAlwaysVisible = true,
    this.scrollbarOrientation,
    this.notificationPredicate,
  });

  /// Controls whether to always show the scrollbar or only when scrolling.
  final bool scrollbarAlwaysVisible;

  /// Custom decoration for the scrollbar.
  final ScrollbarDecoration? scrollbarDecoration;

  /// The orientation of the scrollbar (vertical or horizontal).
  final ScrollbarOrientation? scrollbarOrientation;

  /// A predicate function to determine whether to show the scrollbar for a specific notification.
  final ScrollNotificationPredicate? notificationPredicate;

}

/// The decoration properties of a scrollbar.
class ScrollbarDecoration {
  /// Creates a new instance of [ScrollbarDecoration].
  ///
  /// The [thickness] parameter specifies the thickness of the scrollbar. The default
  /// is `6.0`.
  ///
  /// The [radius] parameter allows you to specify the radius of the scrollbar corners.
  /// If `null`, no rounded corners will be applied.
  const ScrollbarDecoration({this.thickness = 6.0, this.radius = Radius.zero});

  /// The thickness of the scrollbar.
  final double thickness;

  /// The radius of the scrollbar corners.
  final Radius? radius;
}

