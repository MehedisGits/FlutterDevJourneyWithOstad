import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/style.dart';

class ToDoHome extends StatefulWidget {
  const ToDoHome({super.key});

  @override
  State<ToDoHome> createState() => _ToDoHomeState();
}

class _ToDoHomeState extends State<ToDoHome> {
  List toDoList = [];
  String item = "";

  myOnChangeListener(content) {
    setState(() {
      item = content;
    });
  }

  addItem() {
    setState(() {
      toDoList.add({'item': item});
    });
  }

  deleteItem(index) {
    setState(() {
      toDoList.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'To-Do List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          children: [
            //Row for add Item
            Row(
              children: [
                Expanded(
                  flex: 7,
                  child: TextFormField(
                    onChanged: (content) {
                      myOnChangeListener(content);
                    },
                    decoration: AppInputDecoration('To-Do...'),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  flex: 2,
                  child: ElevatedButton(
                    onPressed: () {
                      addItem();
                    },
                    style: AppButtonStyle(),
                    child: const Text(
                      'Add',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 10), // Adding some space between rows
            Expanded(
              child: ListView.separated(
                itemCount: toDoList.length,
                itemBuilder: (context, index) {
                  return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      child: sizedBox50(Row(
                        children: [
                          Expanded(
                            flex: 8,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                  toDoList[index]['item'].toString() ?? ''),
                            ),
                          ),
                          Expanded(
                            flex: 2,
                            child: IconButton(
                              onPressed: () {
                                deleteItem(index);
                              },
                              icon: const Icon(
                                Icons.delete,
                                color: Colors.green,
                              ),
                            ),
                          )
                        ],
                      )));
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const Divider();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
