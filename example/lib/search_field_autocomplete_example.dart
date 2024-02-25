import 'package:flutter/material.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

void main() {
  runApp(const Example1());
}

class Example1 extends StatelessWidget {
  const Example1({super.key});

  List<SearchFieldAutoCompleteItem<String>> get suggestions {
    return const [
      SearchFieldAutoCompleteItem<String>(searchKey: 'Apple', value: 'apple', child: Text('1')),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Banana', value: 'banana'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Cherry', value: 'cherry'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Date', value: 'date'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Fig', value: 'fig'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Grapes', value: 'grapes'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Kiwi', value: 'kiwi'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Lemon', value: 'lemon'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Mango', value: 'mango'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Orange', value: 'orange'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Peach', value: 'peach'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Pear', value: 'pear'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Pineapple', value: 'pineapple'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Strawberry', value: 'strawberry'),
      SearchFieldAutoCompleteItem<String>(searchKey: 'Watermelon', value: 'watermelon'),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(title: const Text('SearchField AutoComplete Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchFieldAutoComplete<String>(
              placeholder: 'Search fruits',
              suggestions: suggestions,
              suggestionsDecoration: SuggestionDecoration(
                marginSuggestions: const EdgeInsets.all(8.0),
                color: Colors.greenAccent,
                borderRadius: BorderRadius.circular(16.0),
              ),
              onSuggestionSelected: (selectedItem) {
                print("selected: ${selectedItem.searchKey}");
              },
              suggestionItemBuilder: (context, searchFieldItem) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    searchFieldItem.searchKey,
                    style: TextStyle(color: Colors.blueGrey.shade900),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
