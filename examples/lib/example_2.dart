import 'package:flutter/material.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

void main() {
  runApp(const Example2());
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final TextEditingController controller = TextEditingController();

  late List<User> users;

  @override
  void initState() {
    loadUsers();
    super.initState();
  }

  void loadUsers() {
    users = List.generate(
      100,
      (index) => User(
        gamerTag: 'GamerTag ${index + 1}',
        id: index + 1,
        imageUrl: 'https://via.placeholder.com/50', // Example image URL
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final itemHeight = MediaQuery.sizeOf(context).height * 0.06;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Search Field AutoComplete Example')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SearchFieldAutoComplete<User>(
              controller: controller,
              suggestions: users.map((user) {
                return SearchFieldAutoCompleteItem<User>(
                  user.gamerTag,
                  item: user,
                );
              }).toList(),
              onSuggestionSelected: (selectedItem) {
                // Handle the selected suggestion.
                final selectedUser = selectedItem.item!;
                print("Selected Gamer Tag: ${selectedUser.gamerTag}");
                print("User ID: ${selectedUser.id}");
              },
              onSubmitted: (query) {
                // Perform a custom action when the user submits the search query.
                print("Search Query Submitted: $query");
              },
              onChanged: (value) {
                print(value);
              },
              onTap: () {
                print('object');
              },
              suffixIcon: controller.text.trim().isNotEmpty
                  ? const Icon(Icons.close)
                  : null,
              onSuffixTap: () {
                controller.clear();
                setState(() {});
              },
              hint: 'Search gamer tags',
              searchStyle: const TextStyle(fontSize: 18),
              suggestionStyle: const TextStyle(fontSize: 16),
              itemHeight: itemHeight,
              suggestionItemBuilder: (context, suggestionItem) {
                return Container(
                  padding: const EdgeInsets.all(8.0),
                  height: itemHeight,
                  child: Row(
                    children: [
                      const CircleAvatar(),
                      const SizedBox(width: 16.0),
                      Text(suggestionItem.searchKey),
                    ],
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

class User {
  final String gamerTag;
  final int id;
  final String imageUrl;

  User({required this.gamerTag, required this.id, required this.imageUrl});
}
