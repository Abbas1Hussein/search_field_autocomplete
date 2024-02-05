import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../search_field_autocomplete.dart';

/// A widget for displaying a list of suggestions.
class SuggestionWidget<T> extends StatelessWidget {
  /// The style for suggestion items.
  final TextStyle? suggestionStyle;

  /// The height of each suggestion item.
  final double itemHeight;

  /// The List<SearchFieldAutoCompleteItem> of the suggestion data.
  final List<SearchFieldAutoCompleteItem<T>?>? data;

  /// The direction in which suggestions are displayed (up or down).
  final SuggestionDirection suggestionDirection;

  /// The scroll controller for the suggestion list.
  final ScrollController? scrollController;

  /// A builder for customizing the appearance of suggestion items.
  final SuggestionItemBuilder<T>? suggestionItemBuilder;

  /// Check if the platform is iOS.
  final bool isIOS;

  final SuggestionSelected<T> onSuggestionSelected;

  /// Constructor for the SuggestionWidget.
  const SuggestionWidget({
    Key? key,
    this.scrollController,
    this.suggestionItemBuilder,
    required this.onSuggestionSelected,
    required this.suggestionDirection,
    required this.itemHeight,
    required this.data,
    required this.isIOS,
    this.suggestionStyle,
  })  : assert(
          !(suggestionItemBuilder != null && suggestionStyle != null),
          'You cannot use both suggestionItemBuilder and suggestionStyle at the same time.',
        ),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.transparent,
      elevation: 0.0,
      borderRadius: BorderRadius.zero,
      type: MaterialType.transparency,
      color: Colors.transparent,
      child: ScrollConfiguration(
        behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
        child: ListView.builder(
          reverse: suggestionDirection == SuggestionDirection.up,
          padding: const EdgeInsets.all(2.0),
          controller: scrollController,
          itemCount: data!.length,
          physics: data!.length == 1
              ? const NeverScrollableScrollPhysics()
              : const ScrollPhysics(),
          itemBuilder: (context, index) {
            final SearchFieldAutoCompleteItem<T> searchFieldItem =
                data![index]!;
            return InkWell(
              borderRadius: BorderRadius.circular(16.0),
              splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
              mouseCursor: SystemMouseCursors.click,
              onTap: () => onSuggestionSelected(searchFieldItem),
              child: suggestionItemBuilder != null
                  ? suggestionItemBuilder!(context, searchFieldItem)
                  : Container(
                      height: itemHeight,
                      width: double.infinity,
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.all(8.0),
                      child: searchFieldItem.child ??
                          Text(
                            searchFieldItem.searchKey,
                            style: suggestionStyle ??
                                _defaultSuggestionStyle(context),
                          ),
                    ),
            );
          },
        ),
      ),
    );
  }

  TextStyle? _defaultSuggestionStyle(BuildContext context) {
    if (isIOS) {
      final cupertinoTheme = CupertinoTheme.of(context);
      return cupertinoTheme.textTheme.textStyle;
    } else {
      return null;
    }
  }
}
