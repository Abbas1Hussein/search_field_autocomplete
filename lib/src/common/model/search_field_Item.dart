import 'package:flutter/widgets.dart';

class SearchFieldAutoCompleteItem<T> {
  const SearchFieldAutoCompleteItem({
    this.child,
    this.value,
    required this.searchKey,
  });
  /// The string to search for.
  final String searchKey;

  /// The value of the search item. This can be any type of object.
  final T? value;

  /// The widget to display in the search results overlay. If not specified, a
  /// [Text] widget with the default styling will appear instead.
  final Widget? child;


  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is SearchFieldAutoCompleteItem &&
            runtimeType == other.runtimeType &&
            searchKey == other.searchKey && child == other.child && value == other.value;
  }

  @override
  int get hashCode => searchKey.hashCode;
}
