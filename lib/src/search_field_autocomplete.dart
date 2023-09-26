import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'common/enums/index.dart';
import 'common/extensions.dart';
import 'common/model/index.dart';
import 'common/typedef.dart';
import 'widgets/empty_suggestions.dart';
import 'widgets/suggestions.dart';

/// A flag to check if the current platform is iOS.
final bool _isIOS = defaultTargetPlatform == TargetPlatform.iOS;

const _kItemHeight = 40.0;
const _kMaxSuggestionsInViewPort = 5;
const _kEdgeInsets = EdgeInsets.all(8.0);

/// A widget that displays a search field with autocomplete suggestions.
class SearchFieldAutoComplete<T> extends StatefulWidget {
  /// The [FocusNode] for managing the focus of the search field.
  final FocusNode? focusNode;

  /// A list of suggestions for the SearchFieldAutoComplete.
  /// Each suggestion should have a unique searchKey.
  final List<SearchFieldAutoCompleteItem<T>> suggestions;

  /// A custom sorter function for sorting search suggestions.
  ///
  /// This function is responsible for sorting and filtering the search suggestions
  /// based on the user's input. It allows you to implement custom sorting logic
  /// for the suggestions.
  ///
  /// The [sorter] function takes two parameters:
  /// - [value]: A string representing the user's input.
  /// - [suggestions]: A list of [SearchFieldAutoCompleteItem<T>] representing the search suggestions.
  ///
  /// The function should return a sorted list of suggestions based on the provided [value].
  ///
  /// ```dart
  /// SearchFieldAutoComplete<MyItemType>(
  ///   sorter: (query, suggestions) {
  ///     // You can customize the sorting logic here.
  ///     // Sort and filter suggestions based on 'value'.
  ///     // Return the sorted list of suggestions.
  ///   },
  /// )
  /// ```
  /// For more details and examples, see:
  /// [GitHub Repository](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/examples/lib/example_3.dart)
  final SuggestionItemSorter<T>? sorter;

  /// The height of each suggestion item in the list.
  final double itemHeight;

  /// The number of suggestions to display in the viewport.
  /// Defaults to 5, but adapts if suggestions are fewer.
  final int maxSuggestionsInViewPort;

  /// The TextEditingController for the SearchFieldAutoComplete.
  final TextEditingController? controller;

  /// The keyboard type for the search field.
  final TextInputType? inputType;

  /// The offset for the suggestion list from the SearchFieldAutoComplete.
  final Offset? offset;

  /// The widget to display when the search returns empty results.
  /// when retrieve 'null' will display --> [DefaultEmptySuggestionsWidget].
  ///
  /// For more details and examples, see:
  /// [GitHub Repository](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/examples/lib/example_2.dart)
  final Widget? Function(String value)? emptyBuilder;

  /// Controls whether to enable auto-correction, defaults to `true`.
  final bool autoCorrect;

  /// The direction in which suggestions appear, defaults to [SuggestionDirection.down].
  final SuggestionDirection suggestionDirection;

  /// An optional suffix icon to be displayed on the right side of the [TextField].
  final Icon? suffixIcon;

  /// A callback function that is triggered when the [suffixIcon] is tapped.
  final VoidCallback? onSuffixTap;

  /// Insets to apply to the [suffixIcon]. You can use this to control the spacing around the [suffixIcon].
  final EdgeInsetsGeometry suffixInsets;

  /// The [TextStyle] for the search input.
  final TextStyle? searchStyle;

  /// The [TextStyle] for suggestions when no child is provided.
  final TextStyle? suggestionStyle;

  /// The state of suggestions, defaults to SuggestionState.expand.
  final Suggestion suggestionState;

  /// The action to perform when a suggestion is tapped.
  final SuggestionAction? suggestionAction;

  /// The decoration for the suggestion list, including properties like [BoxShadow].
  final SuggestionDecoration? suggestionsDecoration;

  /// A custom builder for individual suggestion items.
  ///
  /// This property allows you to provide a function that builds and customizes the decoration
  /// of each suggestion item in the list. The function provides two parameters:
  ///
  /// - `searchFieldItem`: The [SearchFieldAutoCompleteItem<T>] representing the suggestion item.
  /// - `index`: An integer representing the index of the suggestion item in the list.
  final SuggestionItemBuilder<T>? suggestionItemBuilder;

  /// A callback function when a suggestion is tapped.
  final SuggestionSelected<T>? onSuggestionSelected;

  /// A flag to enable or disable the SearchFieldAutoComplete.
  final bool? enabled;

  /// A callback function when the SearchFieldAutoComplete is [submitted].
  final ValueChanged<String?>? onSubmitted;

  /// A callback function when the SearchFieldAutoComplete is [changed].
  final ValueChanged<String?>? onChanged;

  /// A callback function when the SearchFieldAutoComplete is [Tap].
  final VoidCallback? onTap;

  /// The hint text displayed in the search field.
  final String? placeholder;

  /// The initial value to be selected for the SearchFieldAutoComplete.
  /// It must be present in [suggestions].
  final SearchFieldAutoCompleteItem<T>? initialValue;

  /// Represents optional properties for a scrollbar.
  final ScrollbarProperties? scrollbarProperties;

  SearchFieldAutoComplete({
    Key? key,
    required this.suggestions,
    this.autoCorrect = true,
    this.controller,
    this.emptyBuilder,
    this.enabled,
    this.focusNode,
    this.placeholder,
    this.initialValue,
    this.inputType,
    this.itemHeight = _kItemHeight,
    this.maxSuggestionsInViewPort = _kMaxSuggestionsInViewPort,
    this.onChanged,
    this.onSuggestionSelected,
    this.onSubmitted,
    this.onSuffixTap,
    this.onTap,
    this.offset,
    this.scrollbarProperties,
    this.searchStyle,
    this.sorter,
    this.suggestionAction,
    this.suggestionDirection = SuggestionDirection.down,
    this.suggestionItemBuilder,
    this.suggestionState = Suggestion.expand,
    this.suggestionStyle,
    this.suggestionsDecoration,
    this.suffixIcon,
    this.suffixInsets = const EdgeInsetsDirectional.fromSTEB(0, 0, 5, 2),
  })  : assert(
            (initialValue != null &&
                    suggestions.containsObject(initialValue)) ||
                initialValue == null,
            'Initial value should either be null or should be present in suggestions list.'),
        super(key: key);

  @override
  _SearchFieldAutoCompleteState<T> createState() =>
      _SearchFieldAutoCompleteState<T>();
}

class _SearchFieldAutoCompleteState<T>
    extends State<SearchFieldAutoComplete<T>> {
  /// A stream controller for managing suggestion updates.
  final StreamController<List<SearchFieldAutoCompleteItem<T>?>?>
      suggestionStream =
      StreamController<List<SearchFieldAutoCompleteItem<T>?>?>.broadcast();

  /// The focus node for the search field.
  FocusNode? _focus;

  /// Flag to track if suggestions are expanded.
  bool isSuggestionExpanded = false;

  /// The TextEditingController for the search input.
  TextEditingController? searchController;

  /// Represents an overlay entry used to display content above the main widget hierarchy.
  OverlayEntry? _overlayEntry;

  /// A LayerLink is used for creating overlays in Flutter.
  final LayerLink _layerLink = LayerLink();

  /// _totalHeight will store a numeric value representing the total height.
  double _totalHeight = 0.0;

  /// GlobalKey is a key that is unique across the entire app for identifying widgets.
  final GlobalKey key = GlobalKey();

  /// A boolean flag to indicate whether a direction has been calculated.
  bool _isDirectionCalculated = false;

  /// Offset is used to store the position in a 2D coordinate space.
  Offset _offset = Offset.zero;

  /// ScrollController is used to control the scroll position of a scrollable widget.
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _initializeSearchController();
    _initializeFocus();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (mounted) {
          _overlayEntry = _createOverlay();
          if (widget.initialValue == null ||
              widget.initialValue!.searchKey.isEmpty) {
            suggestionStream.sink.add(null);
          } else {
            searchController!.text = widget.initialValue!.searchKey;
            suggestionStream.sink.add([widget.initialValue]);
          }
        }
      },
    );
  }

  void _initializeFocus() {
    _focus = widget.focusNode ?? FocusNode();

    _focus!.addListener(() {
      if (mounted) {
        setState(() {
          isSuggestionExpanded = _focus!.hasFocus;
        });
      }

      // If the field gains focus, show the overlay with suggestions.
      if (isSuggestionExpanded) {
        _overlayEntry = _createOverlay();
        if (widget.initialValue == null) {
          if (widget.suggestionState == Suggestion.expand) {
            Future.delayed(const Duration(milliseconds: 80), () {
              suggestionStream.sink.add(widget.suggestions);
            });
          }
        }
        Overlay.of(context).insert(_overlayEntry!);
      } else {
        if (_overlayEntry != null && _overlayEntry!.mounted) {
          _overlayEntry?.remove();
        }
      }
    });
  }

  void _initializeSearchController() {
    searchController = widget.controller ?? TextEditingController();

    if (!_isIOS) {
      searchController?.addListener(() {
        setState(() {});
      });
    }
  }

  @override
  void didUpdateWidget(covariant SearchFieldAutoComplete<T> oldWidget) {
    if (oldWidget.controller != widget.controller) {
      searchController = widget.controller ?? TextEditingController();
    }
    if (oldWidget.suggestions != widget.suggestions) {
      suggestionStream.sink.add(widget.suggestions);
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void didChangeDependencies() {
    if (_overlayEntry != null && _overlayEntry!.mounted) {
      updateOverlayPositionAndSize();
    }
    super.didChangeDependencies();
  }

  /// Update the overlay position and size.
  /// when screen size changed.
  void updateOverlayPositionAndSize() {
    if (key.currentContext != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      Future(
        () {
          _overlayEntry = _createOverlay();
          Overlay.of(context).insert(_overlayEntry!);
        },
      );
    }
  }

  /// Create the overlay for displaying suggestions.
  OverlayEntry _createOverlay() {
    final textFieldRenderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final textFieldSize = textFieldRenderBox.size;
    final offset = textFieldRenderBox.localToGlobal(Offset.zero);
    var yOffset = Offset.zero;
    return OverlayEntry(
      builder: (context) {
        return StreamBuilder<List<SearchFieldAutoCompleteItem?>?>(
          stream: suggestionStream.stream,
          builder: (context,
              AsyncSnapshot<List<SearchFieldAutoCompleteItem?>?> snapshot) {
            late var count = widget.maxSuggestionsInViewPort;
            if (snapshot.data != null) {
              count = snapshot.data!.length;
            }
            yOffset = getYOffset(offset, textFieldSize, count) ?? Offset.zero;
            return Positioned(
              left: offset.dx,
              width: textFieldSize.width,
              child: CompositedTransformFollower(
                offset: widget.offset ?? yOffset,
                link: _layerLink,
                child: _suggestionsBuilder(),
              ),
            );
          },
        );
      },
    );
  }

  /// Determines the Y offset for displaying suggestions either above or below the [SearchFieldAutoComplete].
  ///
  /// Users can manually specify the offset for more control over the suggestion placement.
  Offset? getYOffset(
      Offset textFieldOffset, Size textFieldSize, int suggestionsCount) {
    if (mounted) {
      final size = MediaQuery.of(context).size;
      final isSpaceAvailable = size.height >
          textFieldOffset.dy + textFieldSize.height + _totalHeight;
      if (widget.suggestionDirection == SuggestionDirection.down) {
        return Offset(0, textFieldSize.height);
      } else if (widget.suggestionDirection == SuggestionDirection.up) {
        if (suggestionsCount > widget.maxSuggestionsInViewPort) {
          return Offset(
              0, -(widget.itemHeight * widget.maxSuggestionsInViewPort));
        } else {
          return Offset(0, -(widget.itemHeight * suggestionsCount));
        }
      } else {
        if (!_isDirectionCalculated) {
          _isDirectionCalculated = true;
          if (isSpaceAvailable) {
            _offset = Offset(0, textFieldSize.height);
            return _offset;
          } else {
            if (suggestionsCount > widget.maxSuggestionsInViewPort) {
              _offset = Offset(
                  0, -(widget.itemHeight * widget.maxSuggestionsInViewPort));
              return _offset;
            } else {
              _offset = Offset(0, -(widget.itemHeight * suggestionsCount));
              return _offset;
            }
          }
        } else {
          return _offset;
        }
      }
    }
    return null;
  }

  Widget _suggestionsBuilder() {
    return StreamBuilder<List<SearchFieldAutoCompleteItem<T>?>?>(
      stream: suggestionStream.stream,
      builder: (context,
          AsyncSnapshot<List<SearchFieldAutoCompleteItem<T>?>?> snapshot) {
        if (snapshot.data == null || !isSuggestionExpanded) {
          return const SizedBox();
        } else if (snapshot.data!.isEmpty) {
          final emptySuggestionsWidget = DefaultEmptySuggestionsWidget(searchController?.text ?? '', isIOS: _isIOS);
          if (widget.emptyBuilder != null) {
            return widget.emptyBuilder!(searchController?.text ?? '') ??
                emptySuggestionsWidget;
          } else if (searchController?.text != null &&
              searchController!.text.isNotEmpty) {
            return emptySuggestionsWidget;
          }
          return const SizedBox.shrink();
        } else {
          if (snapshot.data!.length > widget.maxSuggestionsInViewPort) {
            _totalHeight = widget.itemHeight * widget.maxSuggestionsInViewPort;
          } else if (snapshot.data!.length == 1) {
            _totalHeight = widget.itemHeight + _kMaxSuggestionsInViewPort;
          } else {
            _totalHeight = snapshot.data!.length * widget.itemHeight;
          }

          final SuggestionWidget<T> suggestionWidget = SuggestionWidget(
            itemHeight: widget.itemHeight,
            data: snapshot.data,
            isIos: _isIOS,
            suggestionItemBuilder: widget.suggestionItemBuilder,
            scrollController: _scrollController,
            suggestionStyle: widget.suggestionStyle,
            suggestionDirection: widget.suggestionDirection,
            onSuggestionSelected: _onSuggestionSelected,
          );

          return AnimatedContainer(
            duration: widget.suggestionDirection == SuggestionDirection.up
                ? Duration.zero
                : const Duration(milliseconds: 100),
            height: _totalHeight,
            alignment: Alignment.centerLeft,
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 2.0),
            margin: widget.suggestionsDecoration?.padding ?? _kEdgeInsets,
            decoration: widget.suggestionsDecoration?.boxDecoration ??
                _defaultSuggestionDecoration,
            child: TextFieldTapRegion(
              child: Builder(builder: (context) {
                if (_isIOS) {
                  return CupertinoScrollbar(
                    thumbVisibility:
                        widget.scrollbarProperties?.scrollbarAlwaysVisible,
                    controller: _scrollController,
                    thickness: widget.scrollbarProperties?.scrollbarDecoration
                            ?.thickness ??
                        CupertinoScrollbar.defaultThickness,
                    scrollbarOrientation:
                        widget.scrollbarProperties?.scrollbarOrientation,
                    notificationPredicate:
                        widget.scrollbarProperties?.notificationPredicate,
                    radius: widget
                            .scrollbarProperties?.scrollbarDecoration?.radius ??
                        CupertinoScrollbar.defaultRadius,
                    child: suggestionWidget,
                  );
                }
                return RawScrollbar(
                  thumbVisibility:
                      widget.scrollbarProperties?.scrollbarAlwaysVisible,
                  controller: _scrollController,
                  thickness: widget
                      .scrollbarProperties?.scrollbarDecoration?.thickness,
                  scrollbarOrientation:
                      widget.scrollbarProperties?.scrollbarOrientation,
                  notificationPredicate:
                      widget.scrollbarProperties?.notificationPredicate ??
                          defaultScrollNotificationPredicate,
                  radius:
                      widget.scrollbarProperties?.scrollbarDecoration?.radius,
                  padding: EdgeInsets.zero,
                  child: suggestionWidget,
                );
              }),
            ),
          );
        }
      },
    );
  }

  BoxDecoration? get _defaultSuggestionDecoration {
    final boxDecoration = BoxDecoration(
      borderRadius: BorderRadius.circular(_kEdgeInsets.horizontal),
    );
    if (_isIOS) {
      return boxDecoration.copyWith(color: CupertinoColors.tertiarySystemFill);
    } else {
      final color = Theme.of(context).cardColor;
      return boxDecoration.copyWith(color: color, boxShadow: elevations);
    }
  }

  void _onSuggestionSelected(SearchFieldAutoCompleteItem<T> searchFieldItem) {
    widget.onSuggestionSelected?.call(searchFieldItem);

    // Hide the suggestion on stream.
    suggestionStream.sink.add(null);
    isSuggestionExpanded = false;

    // Set the search controller's text to the selected search key and place the cursor at the end.
    searchController!.text = searchFieldItem.searchKey;
    searchController!.selection = TextSelection.fromPosition(
      TextPosition(offset: searchController!.text.length),
    );

    // Perform an action based on the provided suggestion action.
    if (widget.suggestionAction != null) {
      if (widget.suggestionAction == SuggestionAction.next) {
        _focus!.nextFocus();
      } else if (widget.suggestionAction == SuggestionAction.unfocus) {
        _focus!.unfocus();
      }
    }

    // Delay showing the suggestion again to provide a smoother user experience
    // and address a specific issue.
    Future.delayed(
      const Duration(milliseconds: 100),
      () => isSuggestionExpanded = true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return CompositedTransformTarget(
      link: _layerLink,
      child: Builder(
        builder: (context) {
          if (_isIOS) {
            return CupertinoSearchTextField(
              key: key,
              onSubmitted: widget.onSubmitted,
              enabled: widget.enabled,
              autocorrect: widget.autoCorrect,
              controller: widget.controller ?? searchController,
              focusNode: _focus,
              style: widget.searchStyle,
              keyboardType: widget.inputType,
              placeholder: widget.placeholder,
              suffixIcon: widget.suffixIcon ??
                  const Icon(CupertinoIcons.xmark_circle_fill),
              onSuffixTap: widget.onSuffixTap,
              suffixInsets: widget.suffixInsets,
              onTap: _onTapField,
              onChanged: _onChangeField,
            );
          } else {
            return TextField(
              key: key,
              enabled: widget.enabled,
              autocorrect: widget.autoCorrect,
              onSubmitted: widget.onSubmitted,
              controller: widget.controller ?? searchController,
              focusNode: _focus,
              style: widget.searchStyle,
              textInputAction: TextInputAction.search,
              keyboardType: widget.inputType,
              decoration: InputDecoration(
                hintText: widget.placeholder ??
                    MaterialLocalizations.of(context).searchFieldLabel,
                enabledBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.grey),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: const BorderSide(color: Colors.blue),
                  borderRadius: BorderRadius.circular(32.0),
                ),
                contentPadding: _kEdgeInsets,
                suffixIcon: Builder(
                  builder: (context) {
                    final validate = searchController?.text != null &&
                        searchController!.text.trim().isNotEmpty;
                    if (widget.suffixIcon != null) {
                      return Padding(
                        padding: widget.suffixInsets,
                        child: IconButton(
                          onPressed: widget.onSuffixTap,
                          icon: widget.suffixIcon!,
                        ),
                      );
                    } else if (validate) {
                      return Padding(
                        padding: widget.suffixInsets,
                        child: IconButton(
                          onPressed: () {
                            widget.onSuffixTap?.call();
                            searchController?.clear();
                            suggestionStream.sink.add(null);
                          },
                          icon: const Icon(Icons.close, color: Colors.grey),
                        ),
                      );
                    } else {
                      return const SizedBox.shrink();
                    }
                  },
                ),
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
              ),
              onTap: _onTapField,
              onChanged: _onChangeField,
            );
          }
        },
      ),
    );
  }

  void _onTapField() {
    widget.onTap?.call();

    if (!isSuggestionExpanded && widget.suggestionState == Suggestion.expand) {
      suggestionStream.sink.add(widget.suggestions);
      if (mounted) {
        setState(() {
          isSuggestionExpanded = true;
        });
      }
    }
  }

  void _onChangeField(String value) {
    widget.onChanged?.call(value);

    final List<SearchFieldAutoCompleteItem<T>> searchResult =
        widget.sorter?.call(value, widget.suggestions) ??
            _defaultItemSorter(value, widget.suggestions);

    suggestionStream.sink.add(searchResult);
  }

  /// The default item sorter.
  ///
  /// This sorter will filter the items based on their search key.
  List<SearchFieldAutoCompleteItem<T>> _defaultItemSorter(
    String text,
    List<SearchFieldAutoCompleteItem<T>> items,
  ) {
    text = text.trim();
    if (text.isEmpty) return items;

    return items.where((element) {
      return element.searchKey.toLowerCase().contains(text.toLowerCase());
    }).toList();
  }

  @override
  void dispose() {
    suggestionStream.close();
    _scrollController.dispose();

    if (widget.controller == null) searchController!.dispose();

    if (widget.focusNode == null) _focus!.dispose();

    if (_overlayEntry != null && _overlayEntry!.mounted) {
      _overlayEntry?.remove();
    }

    super.dispose();
  }
}
