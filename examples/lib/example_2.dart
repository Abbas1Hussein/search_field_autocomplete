import 'package:flutter/material.dart';
import 'package:search_field_autocomplete/search_field_autocomplete.dart';

void main() {
  runApp(
    MaterialApp(
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      home: const Example2(),
    ),
  );
}

class Example2 extends StatefulWidget {
  const Example2({super.key});

  @override
  State<Example2> createState() => _Example2State();
}

class _Example2State extends State<Example2> {
  final TextEditingController controller = TextEditingController();

  late List<User> users;
  List<User> selectedUsers = []; // Track selected users

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
    final itemHeight = MediaQuery.of(context).size.height * 0.06;
    return Scaffold(
      appBar: AppBar(title: const Text('Search Field AutoComplete Example')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchFieldAutoComplete<User>(
                controller: controller,
                suggestions: users.map((user) {
                  return SearchFieldAutoCompleteItem<User>(user.gamerTag, item: user);
                }).toList(),

                sorter: (value, items) {
                  return items.where((element) {
                    return value.isNotEmpty && element.searchKey.contains(value.trim());
                  }).toList();
                },
                onSuggestionSelected: (selectedItem) {
                  // Handle the selected suggestion.
                  final selectedUser = selectedItem.item!;
                  print("Selected Gamer Tag: ${selectedUser.gamerTag}");
                  print("User ID: ${selectedUser.id}");
                  selectedUsers.add(selectedUser); // Add to selected list
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
                        CircleAvatar(
                          child: Text(suggestionItem.item!.id.toString()),
                        ),
                        const SizedBox(width: 16.0),
                        Text(suggestionItem.searchKey),
                      ],
                    ),
                  );
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedUsers.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {},
                        leading: CircleAvatar(
                          child: Text(selectedUsers[index].id.toString()),
                        ),
                        title: Text(selectedUsers[index].gamerTag),
                        // Add any additional information you want to display here
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
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
