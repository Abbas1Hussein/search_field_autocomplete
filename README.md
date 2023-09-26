[//]: # ([![pub package]&#40;https://img.shields.io/pub/v/search_field_autocomplete.svg&#41;]&#40;https://pub.dartlang.org/packages/search_field_autocomplete&#41;)

[//]: # ([![GitHub]&#40;https://img.shields.io/github/license/Abbas1Hussein/search_field_autocomplete&#41;]&#40;https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/LICENSE&#41;)

[//]: # ([![GitHub stars]&#40;https://img.shields.io/github/stars/Abbas1Hussein/search_field_autocomplete&#41;]&#40;https://github.com/Abbas1Hussein/search_field_autocomplete/stargazers&#41;)

[//]: # ([![GitHub forks]&#40;https://img.shields.io/github/forks/Abbas1Hussein/search_field_autocomplete&#41;]&#40;https://github.com/Abbas1Hussein/search_field_autocomplete/network&#41;)


`search_field_autocomplete` is a Flutter package that provides a customizable search field with autocomplete suggestions. It is designed to make it easy to implement autocomplete functionality in your Flutter applications.

![dark_cupertino](https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/12207714-662d-4081-a4a7-1f77eb83dbd0)
![light_material](https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/3f9888c2-0ef9-41d6-8153-d64cb012f65c)

<div align="center">
  <img src="https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/12207714-662d-4081-a4a7-1f77eb83dbd0" width="45%" />
  <img src="https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/3f9888c2-0ef9-41d6-8153-d64cb012f65c" width="45%" />
</div>

## Features

- Display autocomplete suggestions as the user types.
- Customize the appearance of the suggestion list.
- Control the number of suggestions displayed in the viewport.
- Support for iOS-style search fields (Cupertino) and Material Design search fields.
- Customize sorting and filtering of suggestions.
- Optional scrollbar for long suggestion lists.
- Callbacks for handling user interactions with suggestions.
- Highly customizable with various styling options.

## Usage
import the package in your Dart code:

```dart
import 'package:search_field_autocomplete/search_field_autocomplete.dart';
```

```dart
SearchFieldAutoComplete<String>(
      suggestions: [
        SearchFieldAutoCompleteItem<String>('Apple', item: 'apple'),
        SearchFieldAutoCompleteItem<String>('Banana', item: 'banana'),
        SearchFieldAutoCompleteItem<String>('Cherry', item: 'cherry'),
        SearchFieldAutoCompleteItem<String>('Date', item: 'date'),
        SearchFieldAutoCompleteItem<String>('Fig', item: 'fig'),
      ],
      onSuggestionSelected: (value) {
        // Handle the selected suggestion
        print('Selected: $value');
      },
);

```
- For more details and examples, see:
- [Example 1](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/examples/lib/example_1.dart)

## Important Parameters

### `focusNode`
- The [FocusNode] for managing the focus of the search field.

### `suggestions`
- A list of suggestions for the SearchFieldAutoComplete. Each suggestion should have a unique searchKey.

### `sorter`
- A custom sorter function for sorting search suggestions. This function is responsible for sorting and filtering the search suggestions based on the user's input. The [sorter] function takes two parameters:
- [value]: A string representing the user's input.
- [suggestions]: A list of [SearchFieldAutoCompleteItem<T>] representing the search suggestions. The function should return a sorted list of suggestions based on the provided [value].
- The function should return a sorted list of suggestions based on the provided [value].
     
   ```dart
     SearchFieldAutoComplete<T>(
     sorter: (query, suggestions) {
       // You can customize the sorting logic here.
       // Sort and filter suggestions based on 'value'.
       // Return the sorted list of suggestions.
     },
   )
   ```
- For more details and examples, see:
- [Example 3](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/examples/lib/example_3.dart)
  
### `itemHeight`
- The height of each suggestion item in the list.

### `maxSuggestionsInViewPort`
- The number of suggestions to display in the viewport. Defaults to 5, but adapts if suggestions are fewer.

### `controller`
- The TextEditingController for the SearchFieldAutoComplete.

### `inputType`
- The keyboard type for the search field.

### `offset`
- The offset for the suggestion list from the SearchFieldAutoComplete.

### `emptyBuilder`
- The widget to display when the search returns empty results.
- when retrieve 'null' will display --> [DefaultEmptySuggestionsWidget](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/lib/src/widgets/empty_suggestions.dart).

![Dark](https://blogger.googleusercontent.com/img/a/AVvXsEgKNah3dY9DrQNBxd8oH7lqLIzkIzOnBwXB4JbAJaceWD-rr14LM5jzQQbukBf_Rt1QbyNiOuTnuhfyO47QXHYXSu5jVL_lY5P34OQibzZRpUA0rVcG0gBbrREU8QgoCfpUBqVRpINaJ9udhdQyAvc7iAtnKlb5zKC4-D08EA_SSyK5MOjb1wt9Irt7x2Q)

![Light](https://blogger.googleusercontent.com/img/a/AVvXsEiVHCq1gi-PQWgRlKAqYWzmj2u_dslUTRsiIkre_WPndzh64RCbt9eF3kI18HaGEauJUgYCjwka9uaTRGfLkiKYVc5Jsth9IgjWM8eR2lo5gAsnH6Krq2CyS8YTrCPzFYXl0NwWlt6fSP6OE9Q-bjzJlwUcbWajmEA24BQeSV_xioNxxZNP_pAleoQhNTU)

- Messages `noResultFound` and `try Different Search term` will be displayed in different languages based on the user's locale.

- For more details and examples, see:
- [Example 2](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/examples/lib/example_2.dart)

### `autoCorrect`
- Controls whether to enable auto-correction, defaults to `true`.

### `suggestionDirection`
- The direction in which suggestions appear, defaults to [SuggestionDirection.down].

### `suffixIcon`
- An optional suffix icon to be displayed on the right side of the [TextField].

### `onSuffixTap`
- A callback function that is triggered when the [suffixIcon] is tapped.

### `suffixInsets`
- Insets to apply to the [suffixIcon]. You can use this to control the spacing around the [suffixIcon].

### `searchStyle`
- The [TextStyle] for the search input.

### `suggestionStyle`
- The [TextStyle] for suggestions when no child is provided.

### `suggestionState`
- The state of suggestions, defaults to SuggestionState.expand.

### `suggestionAction`
- The action to perform when a suggestion is tapped.

### `suggestionsDecoration`
- The decoration for the suggestion list, including properties like [BoxShadow].

### `suggestionItemBuilder`
-This property allows you to provide a function that builds and customizes widget of each suggestion item in the list. The function provides two parameters.

### `onSuggestionSelected`
- A callback function when a suggestion is tapped.

### `enabled`
- A flag to enable or disable the SearchFieldAutoComplete.

### `onSubmitted`
- A callback function when the SearchFieldAutoComplete is submitted.

### `onChanged`
- A callback function when the SearchFieldAutoComplete is changed.

### `onTap`
- A callback function when the SearchFieldAutoComplete is tapped.

### `placeholder`
- The hint text displayed in the search field.

### `initialValue`
- The initial value to be selected for the SearchFieldAutoComplete. It must be present in [suggestions].

### `scrollbarProperties`
- Represents optional properties for a scrollbar.

## Example
For a more detailed example of how to use this package, check out the [example](examples) directory in this repository.

## Contributing
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or create a pull request on GitHub.

## License
This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

