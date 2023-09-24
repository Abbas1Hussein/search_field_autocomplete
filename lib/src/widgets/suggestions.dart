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

  /// A decoration for customizing a suggestion items.
  final SuggestionDecoration? suggestionItemDecoration;

  /// A builder for customizing the appearance of suggestion items.
  final SuggestionItemBuilder<T>? suggestionItemBuilder;

  /// Check if the platform is iOS.
  final bool isIos;

  final SuggestionSelected<T> onSuggestionSelected;

  /// Constructor for the SuggestionWidget.
  const SuggestionWidget({
    Key? key,
    this.scrollController,
    this.suggestionItemBuilder,
    this.suggestionItemDecoration,
    required this.onSuggestionSelected,
    required this.suggestionDirection,
    required this.itemHeight,
    required this.data,
    required this.isIos,
    this.suggestionStyle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: ListView.builder(
        reverse: suggestionDirection == SuggestionDirection.up,
        padding: EdgeInsets.zero,
        controller: scrollController,
        itemCount: data!.length,
        physics: data!.length == 1
            ? const NeverScrollableScrollPhysics()
            : const ScrollPhysics(),
        itemBuilder: (context, index) {
          final SearchFieldAutoCompleteItem<T> searchFieldItem = data![index]!;
          return InkWell(
            borderRadius: BorderRadius.circular(8.0),
            splashFactory: InkSparkle.constantTurbulenceSeedSplashFactory,
            mouseCursor: SystemMouseCursors.click,
            onTap: () => onSuggestionSelected(searchFieldItem),
              child: Builder(
              builder: (context) {
                if (suggestionItemBuilder != null){
                return suggestionItemBuilder!(context,searchFieldItem);
                }
                return Container(
                  height: itemHeight,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  margin: suggestionItemDecoration?.padding,
                  decoration: suggestionItemDecoration?.toBoxDecoration(),
                  child: searchFieldItem.child ?? Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          child: Text(
                            searchFieldItem.searchKey,
                            style: suggestionStyle ??
                                (isIos
                                    ? CupertinoTheme.of(context)
                                        .textTheme
                                        .textStyle
                                    : Theme.of(context).textTheme.bodySmall),
                          ),
                        ),
                      ),
                );
              },
            ),
          );
        },
      ),
    );
  }

}
