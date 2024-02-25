import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

void main() {
  runApp(
    const CupertinoApp(
      theme: CupertinoThemeData(
        brightness: Brightness.light
      ),
      localizationsDelegates: [
        DefaultMaterialLocalizations.delegate,
        DefaultWidgetsLocalizations.delegate,
      ],
      home: Example3(),
    ),
  );
}

class Example3 extends StatelessWidget {
  const Example3({super.key});

  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
     // appBar: AppBar(title: const Text('SearchField AutoComplete Example3')),
      child:  Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SearchFieldAutoComplete<String>(
            appearance: Appearance.cupertino,
            suggestions: List.generate(
              26, // 26 letters in the alphabet
              (index) {
                final letter = String.fromCharCode('A'.codeUnitAt(0) + index);
                return SearchFieldAutoCompleteItem(
                  searchKey: letter,
                  value: 'value $letter',
                );
              },
            ),
            onSuggestionSelected: (searchFieldItem) {
              print(searchFieldItem.searchKey);
            },
            sorter: alphabeticalSorter,
          ),
        ),
      ),
    );
  }
}

/// Sort suggestions alphabetically.
List<SearchFieldAutoCompleteItem<String>> alphabeticalSorter(
  String query,
  List<SearchFieldAutoCompleteItem<String>> suggestions,
) {
  final filteredItems = suggestions.where((suggestion) {
    final searchKey = suggestion.searchKey.toLowerCase();
    final userValue = query.trim().toLowerCase();
    final isMatch = userValue.isNotEmpty && searchKey.contains(userValue);
    return isMatch;
  }).toList();

  return filteredItems;
}
