import 'package:flutter/cupertino.dart';

import '../../search_field_autocomplete.dart';

/// building a suggestion item widget.
typedef SuggestionItemBuilder<T> = Widget Function(
  BuildContext context,
  SearchFieldAutoCompleteItem<T> searchFieldItem,
);

/// handling the selection of a suggestion.
typedef SuggestionSelected<T> = void Function(
  SearchFieldAutoCompleteItem<T> searchFieldItem,
);

/// sorting and filtering suggestion items based on user input.
typedef SuggestionItemSorter<T> = List<SearchFieldAutoCompleteItem<T>> Function(
  String value,
  List<SearchFieldAutoCompleteItem<T>> items,
);
