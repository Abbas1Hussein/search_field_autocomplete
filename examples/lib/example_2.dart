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
  late List<User> users;

  Set<User> selectedUsers = {}; // Track selected users

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
        imageUrl: 'https://via.placeholder.com/50',
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('SearchField AutoComplete Example2')),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SearchFieldAutoComplete<User>(
                placeholder: 'Search gamer tags',
                suggestions: users.map((user) {
                  return SearchFieldAutoCompleteItem<User>(
                    user.gamerTag,
                    item: user,
                  );
                }).toList(),
                emptyBuilder: (value) {
                  /// Check if the input value has a length larger than or equal to 3.
                  /// If so, return null to use the default emptyWidget.
                  if (value.length >= 3) return null;

                  /// Otherwise, return [SizedBox.shrink] to display an empty widget.
                  return const SizedBox.shrink();
                },
                onSuggestionSelected: (selectedItem) {
                  final selectedUser = selectedItem.item!;
                  print("Selected Gamer Tag: ${selectedUser.gamerTag}");
                  print("User ID: ${selectedUser.id}");
                  setState(() {
                    selectedUsers.add(selectedUser);
                  });
                },
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: selectedUsers.length,
                padding: const EdgeInsets.all(8.0),
                itemBuilder: (context, index) {
                  final user = selectedUsers.elementAt(index);
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ListTile(
                        leading: CircleAvatar(child: Text(user.id.toString())),
                        title: Text(user.gamerTag),
                        trailing: IconButton(
                          onPressed: () {
                            setState(() {
                              selectedUsers.remove(user);
                            });
                          },
                          icon: const Icon(Icons.remove),
                        ),
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
