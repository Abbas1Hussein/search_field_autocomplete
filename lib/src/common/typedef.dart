import '../../search_field_autocomplete.dart';

/// building a suggestion item widget.
typedef SuggestionItemDecorationBuilder<T> = SuggestionDecoration Function(
    SearchFieldAutoCompleteItem<T> searchFieldItem, int index);

/// building search suggestions based on the user's input.
typedef SearchBuilder<T> = List<SearchFieldAutoCompleteItem<T>> Function(
    String value);

/// handling the selection of a suggestion.
typedef SuggestionSelected<T> = void Function(
    SearchFieldAutoCompleteItem<T> searchFieldItem);
