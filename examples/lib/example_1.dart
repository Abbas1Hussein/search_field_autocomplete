import 'package:flutter/material.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

void main() {
  runApp(const Example1());
}

class Example1 extends StatelessWidget {
  const Example1({super.key});

  List<SearchFieldAutoCompleteItem<String>> get suggestions {
    return [
      SearchFieldAutoCompleteItem<String>('Apple', item: 'apple'),
      SearchFieldAutoCompleteItem<String>('Banana', item: 'banana'),
      SearchFieldAutoCompleteItem<String>('Cherry', item: 'cherry'),
      SearchFieldAutoCompleteItem<String>('Date', item: 'date'),
      SearchFieldAutoCompleteItem<String>('Fig', item: 'fig'),
      SearchFieldAutoCompleteItem<String>('Grapes', item: 'grapes'),
      SearchFieldAutoCompleteItem<String>('Kiwi', item: 'kiwi'),
      SearchFieldAutoCompleteItem<String>('Lemon', item: 'lemon'),
      SearchFieldAutoCompleteItem<String>('Mango', item: 'mango'),
      SearchFieldAutoCompleteItem<String>('Orange', item: 'orange'),
      SearchFieldAutoCompleteItem<String>('Peach', item: 'peach'),
      SearchFieldAutoCompleteItem<String>('Pear', item: 'pear'),
      SearchFieldAutoCompleteItem<String>('Pineapple', item: 'pineapple'),
      SearchFieldAutoCompleteItem<String>('Strawberry', item: 'strawberry'),
      SearchFieldAutoCompleteItem<String>('Watermelon', item: 'watermelon'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Search Field AutoComplete Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchFieldAutoComplete<String>(
              suggestions: suggestions,
              onSuggestionSelected: (selectedItem) {
                // Handle the selected suggestion.
                print("Selected: ${selectedItem.searchKey}");
              },
              searchStyle: const TextStyle(fontSize: 18),
              suggestionStyle: const TextStyle(fontSize: 16),
              hint: 'Search fruits',
              maxSuggestionsInViewPort: 5,
            ),
          ),
        ),
      ),
    );
  }
}
