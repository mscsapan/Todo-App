import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/database/data_controller.dart';

class TodoView extends StatelessWidget {
  TodoView({
    Key? key,
    required this.id,
    required this.title,
    required this.description,
    required this.time,
  }) : super(key: key);
  final int id;
  final String title;
  final String description;
  final DateTime time;
  final DatabaseController data = DatabaseController.databaseController;

  @override
  Widget build(BuildContext context) {
    return Consumer<StateController>(
      builder: (context, state, _) {
        return Card(
          elevation: 5.0,
          margin: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
          child: ListTile(
            title: Text(title),
            subtitle: Row(
              children: [
                Text(description),
                const SizedBox(width: 12.0),
                Text(DateTime.now().toString())
              ],
            ),
            trailing: Consumer<StateController>(
              builder: (context, state, _) {
                return IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    state.deleteItem(id);
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }
}
