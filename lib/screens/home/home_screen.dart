import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_tutorial/constants.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _controller = TextEditingController();

  // Each task: {"title": String, "isDone": bool}
  List<Map<String, dynamic>> todos = [];
  bool isLoading = false;
  // without using Stream (Realtime) Database
  // Future selectAllData () async {
  //   setState(() {
  //     isLoading = !isLoading ;
  //   });

  // with stream , so we don't need write function after each operation [ insert , update , delete ]
  // todos = await Supabase.instance.client.from(Consts.kDatabaseName).select().order("created_at" ,ascending: false  ) ;
  //   setState(() {
  //     isLoading = !isLoading ;
  //   });
  // }

  Future selectAllData() async {
    Supabase.instance.client
        .from(Consts.kDatabaseName)
        .stream(primaryKey: ['id'])
        .listen((event) {
          setState(() {
            isLoading = !isLoading;
          });
          log("the event values is : ${event.toString()}");
            todos = event;
          setState(() {
            isLoading = !isLoading;
          });
        });
  }

  Future insertData(String title, bool isDone) async {
    await Supabase.instance.client.from(Consts.kDatabaseName).insert({
      "title": title,
      "isDone": isDone,
    });
    // selectAllData() ;
  }

  Future updateData(int id, bool isDone) async {
    await Supabase.instance.client
        .from(Consts.kDatabaseName)
        .update({"isDone": isDone})
        .eq('id', id);
    // selectAllData() ;
  }

  Future deleteItem(int id) async {
    await Supabase.instance.client
        .from(Consts.kDatabaseName)
        .delete()
        .eq('id', id);
    // selectAllData() ;
  }

  @override
  void initState() {
    super.initState();

    selectAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Todo App"), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Input Row
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      labelText: "Enter task",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    insertData(_controller.text, false);
                    _controller.clear();
                  },
                  child: const Text("Add"),
                ),
              ],
            ),
            const SizedBox(height: 16),
            // Task List
            Expanded(
              child: 
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  :
                   ListView.builder(
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        return Card(
                          child: ListTile(
                            leading: Checkbox(
                              value: todos[index]["isDone"],
                              onChanged: (value) {
                                updateData(todos[index]['id'], value!);
                              },
                            ),
                            title: Text(
                              todos[index]["title"],
                              style: TextStyle(
                                decoration: todos[index]["isDone"]
                                    ? TextDecoration.lineThrough
                                    : TextDecoration.none,
                                color: todos[index]["isDone"]
                                    ? Colors.grey
                                    : Colors.black,
                              ),
                            ),
                            trailing: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.red),
                              onPressed: () {
                                deleteItem(todos[index]['id']);
                              },
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
