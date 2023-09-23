import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'common/enums/index.dart';
import 'common/extensions/on_list.dart';
import 'common/model/search_field_Item.dart';
import 'common/model/suggestion_decoration.dart';

/// A widget that displays a searchfield and a list of suggestions
/// when the searchfield is brought into focus
/// see [example/lib/country_search.dart]
///

final bool _isIos = defaultTargetPlatform == TargetPlatform.iOS;

class SearchFieldAutoComplete<T> extends StatefulWidget {
  final FocusNode? focusNode;

  /// List of suggestions for the searchfield.
  /// each suggestion should have a unique searchKey
  ///
  /// ```dart
  /// ['ABC', 'DEF', 'GHI', 'JKL']
  ///   .map((e) => SearchFieldListItem(e, child: Text(e)))
  ///   .toList(),
  /// ```
  final List<SearchFieldItem<T>> suggestions;

  /// Callback when the suggestion is selected.
  final Function(SearchFieldItem<T>)? onSuggestionTap;

  /// Callback when the searchfield is searched.
  /// The callback should return a list of SearchFieldListItem based on custom logic which will be
  /// shown as suggestions.
  /// If the callback is not specified, the searchfield will show suggestions which contains the
  /// search text.
  final List<SearchFieldItem<T>>? Function(String)? onSearchTextChanged;

  /// Defines whether to enable the searchfield defaults to `true`
  final bool? enabled;

  /// Defines whether to show the searchfield as readOnly
  final bool readOnly;

  /// Callback when the Searchfield is submitted
  ///  it returns the text from the searchfield
  final Function(String)? onSubmit;

  /// Hint for the [SearchFieldAutoComplete].
  final String? hint;

  /// Define a [TextInputAction] that is called when the field is submitted
  final TextInputAction? textInputAction;

  /// The initial value to be selected for [SearchFieldAutoComplete]. The value
  /// must be present in [suggestions].
  ///
  /// When not specified, [hint] is shown instead of `initialValue`.
  final SearchFieldItem<T>? initialValue;

  /// Specifies [TextStyle] for search input.
  final TextStyle? searchStyle;

  /// Specifies [TextStyle] for suggestions when no child is provided.
  final TextStyle? suggestionStyle;

  /// Specifies [InputDecoration] for search input [TextField].
  ///
  /// When not specified, the default value is [InputDecoration] initialized
  /// with [hint].
  final InputDecoration? searchInputDecoration;

  /// defaults to SuggestionState.expand
  final Suggestion suggestionState;

  /// Specifies the [SuggestionAction] called on suggestion tap.
  final SuggestionAction? suggestionAction;

  /// Specifies [SuggestionDecoration] for suggestion list. The property can be used to add [BoxShadow], [BoxBorder]
  /// and much more. For more information, checkout [BoxDecoration].
  ///
  /// Default value,
  ///
  /// ```dart
  /// BoxDecoration(
  ///   color: Theme.of(context).colorScheme.surface,
  ///   boxShadow: [
  ///     BoxShadow(
  ///       color: onSurfaceColor.withOpacity(0.1),
  ///       blurRadius: 8.0, // soften the shadow
  ///       spreadRadius: 2.0, //extend the shadow
  ///       offset: Offset(
  ///         2.0,
  ///         5.0,
  ///       ),
  ///     ),
  ///   ],
  /// )
  /// ```
  final SuggestionDecoration? suggestionsDecoration;

  /// Specifies [BoxDecoration] for items in suggestion list. The property can be used to add [BoxShadow],
  /// and much more. For more information, checkout [BoxDecoration].
  ///
  /// Default value,
  ///
  /// ```dart
  /// BoxDecoration(
  ///   border: Border(
  ///     bottom: BorderSide(
  ///       color: widget.marginColor ??
  ///         onSurfaceColor.withOpacity(0.1),
  ///     ),
  ///   ),
  /// )
  /// ```
  final BoxDecoration? suggestionItemDecoration;

  /// Specifies height for each suggestion item in the list.
  ///
  /// When not specified, the default value is `35.0`.
  final double itemHeight;

  /// Specifies the color of margin between items in suggestions list.
  ///
  /// When not specified, the default value is `Theme.of(context).colorScheme.onSurface.withOpacity(0.1)`.
  final Color? marginColor;

  /// Specifies the number of suggestions that can be shown in viewport.
  ///
  /// When not specified, the default value is `5`.
  /// if the number of suggestions is less than 5, then [maxSuggestionsInViewPort]
  /// will be the length of [suggestions]
  final int maxSuggestionsInViewPort;

  /// Specifies the `TextEditingController` for [SearchFieldAutoComplete].
  final TextEditingController? controller;

  /// Keyboard Type for SearchField
  final TextInputType? inputType;

  /// `validator` for the [SearchFieldAutoComplete]
  /// to make use of this validator, The
  /// SearchField widget needs to be wrapped in a Form
  /// and pass it a Global key
  /// and write your validation logic in the validator
  /// you can define a global key
  ///
  ///  ```dart
  ///  Form(
  ///   key: _formKey,
  ///   child: SearchField(
  ///     suggestions: _statesOfIndia,
  ///     validator: (state) {
  ///       if (!_statesOfIndia.contains(state) || state.isEmpty) {
  ///         return 'Please Enter a valid State';
  ///       }
  ///       return null;
  ///     },
  ///   )
  /// ```
  /// You can then validate the form by calling
  /// the validate function of the form
  ///
  /// `_formKey.currentState.validate();`
  ///
  ///
  ///
  final String? Function(String?)? validator;

  /// Defines whether to show the scrollbar always or only when scrolling.
  /// defaults to `true`
  final bool scrollbarAlwaysVisible;

  /// suggestion List offset from the searchfield
  /// The top left corner of the searchfield is the origin (0,0)
  final Offset? offset;

  /// An optional method to call with the final value when the form is saved via FormState.save.
  final void Function(String?)? onSaved;

  /// Widget to show when the search returns
  /// empty results.
  /// defaults to [SizedBox.shrink]
  final Widget emptyWidget;

  /// Function that implements the comparison criteria to filter out suggestions.
  /// The 2 parameters are the input text and the `suggestionKey` passed to each `SearchFieldListItem`
  /// which should return true or false to filter out the suggestion.
  /// by default the comparator shows the suggestions that contain the input text
  /// in the `suggestionKey`
  ///
  /// @deprecated use [onSearchTextChanged] instead
  final bool Function(String inputText, String suggestionKey)? comparator;

  /// Defines whether to enable autoCorrect defaults to `true`
  final bool autoCorrect;

  /// input formatter for the searchfield
  final List<TextInputFormatter>? inputFormatters;

  /// suggestion direction defaults to [SuggestionDirection.up]
  final SuggestionDirection suggestionDirection;

  /// text capitalization defaults to [TextCapitalization.none]
  final TextCapitalization textCapitalization;

  SearchFieldAutoComplete(
      {Key? key,
      required this.suggestions,
      this.autoCorrect = true,
      this.controller,
      this.emptyWidget = const SizedBox.shrink(),
      this.focusNode,
      this.hint,
      this.initialValue,
      this.inputFormatters,
      this.inputType,
      this.itemHeight = 35.0,
      this.marginColor,
      this.maxSuggestionsInViewPort = 5,
      this.enabled,
      this.readOnly = false,
      this.onSearchTextChanged,
      this.onSaved,
      this.onSubmit,
      this.offset,
      this.onSuggestionTap,
      this.searchInputDecoration,
      this.searchStyle,
      this.scrollbarAlwaysVisible = true,
      this.suggestionStyle,
      this.suggestionsDecoration,
      this.suggestionDirection = SuggestionDirection.down,
      this.suggestionState = Suggestion.expand,
      this.suggestionItemDecoration,
      this.suggestionAction,
      this.textCapitalization = TextCapitalization.none,
      this.textInputAction,
      this.validator,
      @Deprecated('use `onSearchTextChanged` instead.') this.comparator})
      : assert(
            (initialValue != null &&
                    suggestions.containsObject(initialValue)) ||
                initialValue == null,
            'Initial value should either be null or should be present in suggestions list.'),
        super(key: key);

  @override
  _SearchFieldAutoCompleteState<T> createState() =>
      _SearchFieldAutoCompleteState();
}

class _SearchFieldAutoCompleteState<T>
    extends State<SearchFieldAutoComplete<T>> {
  final StreamController<List<SearchFieldItem<T>?>?> suggestionStream =
      StreamController<List<SearchFieldItem<T>?>?>.broadcast();

  FocusNode? _focus;
  bool isSuggestionExpanded = false;
  TextEditingController? searchController;

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

  void initialize() {
    if (widget.focusNode != null) {
      _focus = widget.focusNode;
    } else {
      _focus = FocusNode();
    }
    _focus!.addListener(() {
      if (mounted) {
        setState(() {
          isSuggestionExpanded = _focus!.hasFocus;
        });
      }
      if (isSuggestionExpanded) {
        _overlayEntry = _createOverlay();
        if (widget.initialValue == null) {
          if (widget.suggestionState == Suggestion.expand) {
            Future.delayed(const Duration(milliseconds: 100), () {
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

  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    searchController = widget.controller ?? TextEditingController();
    initialize();
    WidgetsBinding.instance.addPostFrameCallback((_) {
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
    });
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

  Widget _suggestionsBuilder() {
    return StreamBuilder<List<SearchFieldItem<T>?>?>(
      stream: suggestionStream.stream,
      builder: (context, AsyncSnapshot<List<SearchFieldItem<T>?>?> snapshot) {
        if (snapshot.data == null || !isSuggestionExpanded) {
          return const SizedBox();
        } else if (snapshot.data!.isEmpty) {
          return widget.emptyWidget;
        } else {
          if (snapshot.data!.length > widget.maxSuggestionsInViewPort) {
            _totalHeight = widget.itemHeight * widget.maxSuggestionsInViewPort;
          } else if (snapshot.data!.length == 1) {
            _totalHeight = widget.itemHeight;
          } else {
            _totalHeight = snapshot.data!.length * widget.itemHeight;
          }
          final onSurfaceColor = Theme.of(context).colorScheme.onSurface;

          final Widget listView = ListView.builder(
            reverse: widget.suggestionDirection == SuggestionDirection.up,
            padding: EdgeInsets.zero,
            controller: _scrollController,
            itemCount: snapshot.data!.length,
            physics: snapshot.data!.length == 1
                ? const NeverScrollableScrollPhysics()
                : const ScrollPhysics(),
            itemBuilder: (context, index) => TextFieldTapRegion(
              child: GestureDetector(
                onTap: () {
                  searchController!.text = snapshot.data![index]!.searchKey;
                  searchController!.selection = TextSelection.fromPosition(
                    TextPosition(offset: searchController!.text.length),
                  );

                  // suggestion action to switch focus to next focus node
                  if (widget.suggestionAction != null) {
                    if (widget.suggestionAction == SuggestionAction.next) {
                      _focus!.nextFocus();
                    } else if (widget.suggestionAction ==
                        SuggestionAction.unfocus) {
                      _focus!.unfocus();
                    }
                  }

                  // hide the suggestions
                  suggestionStream.sink.add(null);
                  if (widget.onSuggestionTap != null) {
                    widget.onSuggestionTap!(snapshot.data![index]!);
                  }
                },
                child: Container(
                  height: widget.itemHeight,
                  width: double.infinity,
                  alignment: Alignment.centerLeft,
                  decoration: widget.suggestionItemDecoration?.copyWith(
                        border: widget.suggestionItemDecoration?.border ??
                            Border(
                              bottom: BorderSide(
                                color: widget.marginColor ??
                                    onSurfaceColor.withOpacity(0.1),
                              ),
                            ),
                      ) ??
                      BoxDecoration(
                        border: index == snapshot.data!.length - 1
                            ? null
                            : Border(
                                bottom: BorderSide(
                                  color: widget.marginColor ??
                                      onSurfaceColor.withOpacity(0.1),
                                ),
                              ),
                      ),
                  child: snapshot.data![index]!.child ??
                      Text(
                        snapshot.data![index]!.searchKey,
                        style: widget.suggestionStyle,
                      ),
                ),
              ),
            ),
          );

          return AnimatedContainer(
            duration: widget.suggestionDirection == SuggestionDirection.up
                ? Duration.zero
                : const Duration(milliseconds: 300),
            height: _totalHeight,
            alignment: Alignment.centerLeft,
            decoration: widget.suggestionsDecoration ??
                BoxDecoration(
                  color: _isIos
                      ? CupertinoTheme.of(context).primaryColor
                      : Theme.of(context).primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: onSurfaceColor.withOpacity(0.1),
                      blurRadius: 8.0,
                      spreadRadius: 2.0,
                      offset: const Offset(2.0, 5.0),
                    ),
                  ],
                ),
            child: RawScrollbar(
              thumbVisibility: widget.scrollbarAlwaysVisible,
              controller: _scrollController,
              padding: EdgeInsets.zero,
              child: listView,
            ),
          );
        }
      },
    );
  }

  /// Decides whether to show the suggestions
  /// on top or bottom of Searchfield
  /// User can have more control by manually specifying the offset
  Offset? getYOffset(
      Offset textFieldOffset, Size textFieldSize, int suggestionsCount) {
    if (mounted) {
      final size = MediaQuery.of(context).size;
      final isSpaceAvailable = size.height >
          textFieldOffset.dy + textFieldSize.height + _totalHeight;
      if (widget.suggestionDirection == SuggestionDirection.down) {
        return Offset(0, textFieldSize.height);
      } else if (widget.suggestionDirection == SuggestionDirection.up) {
        // search results should not exceed maxSuggestionsInViewPort
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

  OverlayEntry _createOverlay() {
    final textFieldRenderBox =
        key.currentContext!.findRenderObject() as RenderBox;
    final textFieldsize = textFieldRenderBox.size;
    final offset = textFieldRenderBox.localToGlobal(Offset.zero);
    var yOffset = Offset.zero;
    return OverlayEntry(
      builder: (context) => StreamBuilder<List<SearchFieldItem?>?>(
        stream: suggestionStream.stream,
        builder: (context, AsyncSnapshot<List<SearchFieldItem?>?> snapshot) {
          late var count = widget.maxSuggestionsInViewPort;
          if (snapshot.data != null) {
            count = snapshot.data!.length;
          }
          yOffset = getYOffset(offset, textFieldsize, count) ?? Offset.zero;
          return Positioned(
            left: offset.dx,
            width: textFieldsize.width,
            child: CompositedTransformFollower(
              offset: widget.offset ?? yOffset,
              link: _layerLink,
              child: Card(child: _suggestionsBuilder()),
            ),
          );
        },
      ),
    );
  }

  final LayerLink _layerLink = LayerLink();
  late double _totalHeight;
  GlobalKey key = GlobalKey();
  bool _isDirectionCalculated = false;
  Offset _offset = Offset.zero;
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    if (widget.suggestions.length > widget.maxSuggestionsInViewPort) {
      _totalHeight = widget.itemHeight * widget.maxSuggestionsInViewPort;
    } else {
      _totalHeight = widget.suggestions.length * widget.itemHeight;
    }

    return CompositedTransformTarget(
      link: _layerLink,
      child: Builder(
        builder: (context) {
          if (_isIos) {
            return CupertinoTextFormFieldRow(
              key: key,
              enabled: widget.enabled,
              autocorrect: widget.autoCorrect,
              readOnly: widget.readOnly,
              onFieldSubmitted: widget.onSubmit,
              onTap: _onTapField,
              onSaved: widget.onSaved,
              inputFormatters: widget.inputFormatters,
              controller: widget.controller ?? searchController,
              focusNode: _focus,
              validator: widget.validator,
              style: widget.searchStyle,
              textInputAction: widget.textInputAction,
              textCapitalization: widget.textCapitalization,
              keyboardType: widget.inputType,
              placeholder: widget.hint,
              onChanged: _onChangeField,
            );
          } else {
            return TextFormField(
              key: key,
              enabled: widget.enabled,
              autocorrect: widget.autoCorrect,
              readOnly: widget.readOnly,
              onFieldSubmitted: widget.onSubmit,
              onTap: _onTapField,
              onSaved: widget.onSaved,
              inputFormatters: widget.inputFormatters,
              controller: widget.controller ?? searchController,
              focusNode: _focus,
              validator: widget.validator,
              style: widget.searchStyle,
              textInputAction: widget.textInputAction,
              textCapitalization: widget.textCapitalization,
              keyboardType: widget.inputType,
              decoration: widget.searchInputDecoration
                      ?.copyWith(hintText: widget.hint) ??
                  InputDecoration(hintText: widget.hint),
              onChanged: _onChangeField,
            );
          }
        },
      ),
    );
  }

  void _onChangeField(query) {
    var searchResult = <SearchFieldItem<T>>[];
    if (widget.onSearchTextChanged != null) {
      searchResult = widget.onSearchTextChanged!(query) ?? [];
    } else {
      if (query.isEmpty) {
        _createOverlay();
        suggestionStream.sink.add(widget.suggestions);
        return;
      }
      for (final suggestion in widget.suggestions) {
        if (widget.comparator != null) {
          if (widget.comparator!(query, suggestion.searchKey)) {
            searchResult.add(suggestion);
          }
        } else if (suggestion.searchKey
            .toLowerCase()
            .contains(query.toLowerCase())) {
          searchResult.add(suggestion);
        }
      }
    }
    suggestionStream.sink.add(searchResult);
  }

  void _onTapField() {
    /// only call if SuggestionState = [Suggestion.expand]
    if (!isSuggestionExpanded && widget.suggestionState == Suggestion.expand) {
      suggestionStream.sink.add(widget.suggestions);
      if (mounted) {
        setState(() {
          isSuggestionExpanded = true;
        });
      }
    }
  }
}
