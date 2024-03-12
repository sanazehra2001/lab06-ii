import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: SavedSuggestions(
        suggestions: List.generate(5, (index) => 'Suggestion $index'),
      ),
    );
  }
}

class SavedSuggestions extends StatefulWidget {
  final List<String> suggestions;

  const SavedSuggestions({Key? key, required this.suggestions})
      : super(key: key);

  @override
  State<SavedSuggestions> createState() => _SavedSuggestionsState();
}

class _SavedSuggestionsState extends State<SavedSuggestions> {
  late List<bool> _isSelected;
  late List<String> _selectedToDelete;

  @override
  void initState() {
    super.initState();
    _isSelected = List.generate(widget.suggestions.length, (_) => false);
    _selectedToDelete = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Syeda Sana Zehra Zaidi - 339278"),
        backgroundColor: Colors.blue,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 18,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              if (_isSelected.any((isSelected) => isSelected)) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Suggestions'),
                    content: const Text(
                        'Are you sure you want to delete the selected suggestions?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          // Add selected items to delete list
                          for (var i = 0; i < _isSelected.length; i++) {
                            if (_isSelected[i]) {
                              _selectedToDelete.add(widget.suggestions[i]);
                            }
                          }
                          // Remove selected items from suggestions list and update isSelected state
                          setState(() {
                            widget.suggestions.removeWhere((suggestion) =>
                                _selectedToDelete.contains(suggestion));
                            _isSelected = List.generate(
                                widget.suggestions.length, (_) => false);
                          });
                          Navigator.pop(context);
                        },
                        child: const Text('Yes'),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('No'),
                      ),
                    ],
                  ),
                );
              } else {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('No Item Selected'),
                  ),
                );
              }
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: widget.suggestions.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(widget.suggestions[index]),
            trailing: Checkbox(
              value: _isSelected[index],
              onChanged: (newValue) {
                setState(() {
                  _isSelected[index] = newValue!;
                });
              },
            ),
          );
        },
      ),
    );
  }
}
