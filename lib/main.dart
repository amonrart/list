import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 25, 203, 5)),
        useMaterial3: true,
      ),
      home: const TodaApp(),
    );
  }
}

class TodaApp extends StatefulWidget {
  const TodaApp({
    super.key,
  });

  @override
  State<TodaApp> createState() => _TodaAppState();
}

class _TodaAppState extends State<TodaApp> {
  late TextEditingController _texteditController;
  late TextEditingController _detailController;
  final List<Map<String, String>> _myList = [];

  @override
  void initState() {
    super.initState();
    _texteditController = TextEditingController();
    _detailController = TextEditingController();
  }

  void addTodoHandle(BuildContext context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("Add new task"),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: _texteditController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(), labelText: "Task Title"),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _detailController,
                  decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: "Task Details"),
                ),
              ],
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      _myList.add({
                        'title': _texteditController.text,
                        'details': _detailController.text
                      });
                    });
                    _texteditController.clear();
                    _detailController.clear();
                    Navigator.pop(context);
                  },
                  child: const Text("Save"))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Todo"),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _myList.isEmpty
          ? const Center(
              child: Text('No tasks added yet!'),
            )
          : ListView.builder(
              itemCount: _myList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_myList[index]['title']!),
                  subtitle: Text(_myList[index]['details']!),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          addTodoHandle(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
