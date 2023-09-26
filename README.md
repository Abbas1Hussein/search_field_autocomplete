[![pub package](https://img.shields.io/pub/v/search_field_autocomplete.svg)](https://pub.dartlang.org/packages/search_field_autocomplete)
[![GitHub](https://img.shields.io/github/license/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/LICENSE)
[![GitHub stars](https://img.shields.io/github/stars/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/stargazers)
[![GitHub forks](https://img.shields.io/github/forks/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/network)


`search_field_autocomplete` is a Flutter package that provides a customizable search field with autocomplete suggestions. It is designed to make it easy to implement autocomplete functionality in your Flutter applications.

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

## Example

Here's a simple example of how to use `SearchFieldAutoComplete`:


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

## Example

For a more detailed example of how to use this package, check out the [example](examples) directory in this repository.

## Contributing

Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or create a pull request on GitHub.

## License

This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
```
