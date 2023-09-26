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
    return SearchFieldAutoComplete<String>(
      suggestions: [
        SearchFieldAutoCompleteItem<String>('Apple', item: 'apple'),
        SearchFieldAutoCompleteItem<String>('Banana', item: 'banana'),
        SearchFieldAutoCompleteItem<String>('Cherry', item: 'cherry'),
        SearchFieldAutoCompleteItem<String>('Date', item: 'date'),
        SearchFieldAutoCompleteItem<String>('Fig', item: 'fig'),
        // Add more suggestions as needed
      ],
      onSuggestionSelected: (value) {
        // Handle the selected suggestion
        print('Selected: $value');
      },
    );
    return MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('SearchField AutoComplete Example'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchFieldAutoComplete<String>(
              placeholder: 'Search fruits',
              suggestions: suggestions,
              suggestionsDecoration: SuggestionDecoration(
                padding: const EdgeInsets.all(8.0),
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
