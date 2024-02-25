[![pub package](https://img.shields.io/pub/v/search_field_autocomplete.svg)](https://pub.dartlang.org/packages/search_field_autocomplete) [![GitHub](https://img.shields.io/github/license/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/blob/main/LICENSE) [![GitHub stars](https://img.shields.io/github/stars/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/stargazers) [![GitHub forks](https://img.shields.io/github/forks/Abbas1Hussein/search_field_autocomplete)](https://github.com/Abbas1Hussein/search_field_autocomplete/network)

a flutter package that provides a customizable search field with autocomplete suggestions. It is designed to make it easy to implement autocomplete functionality in your Flutter applications.

<div>
  <img src="https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/746de5d6-8084-4565-bc8b-3cf71a73ae67" width="45%" />
  <img src="https://github.com/Abbas1Hussein/search_field_autocomplete/assets/112737126/4f4ba0b7-2bb4-49f5-91c5-7221e1902928" width="45%" />
</div>

## Features

- Display autocomplete suggestions as the user types.
- Support for iOS-style search fields (Cupertino) and Material Design search fields.
- Customize sorting and filtering of suggestions.
- Highly customizable with various styling options.

## Usage
import the package in your Dart code:

```dart
import 'package:search_field_autocomplete/search_field_autocomplete.dart';
```

```dart
SearchFieldAutoComplete<String>(
  suggestions: [
    SearchFieldAutoCompleteItem<String>(searchKey: 'Apple', value: 'apple'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Banana', value: 'banana'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Cherry', value: 'cherry'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Date', value: 'date'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Fig', value: 'fig'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Grapes', value: 'grapes'),
    SearchFieldAutoCompleteItem<String>(searchKey: 'Kiwi', value: 'kiwi'),
  ],
  onSuggestionSelected: (value) {
    // Handle the selected suggestion
    print('Selected: $value');
  },
);

```
## Contributing
Contributions are welcome! If you encounter any issues or have suggestions for improvements, please open an issue or create a pull request on GitHub.

## License
This package is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
