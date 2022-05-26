import 'package:flutter/material.dart';
import 'package:todo_app/database/data_controller.dart';
import 'package:todo_app/model/todo_model.dart';

class UserInput extends StatelessWidget {
  UserInput(
      {Key? key,
      required this.titleController,
      required this.descriptionController})
      : super(key: key);
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DatabaseController data = DatabaseController.databaseController;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Todo'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: titleController,
            decoration: const InputDecoration(hintText: 'title'),
          ),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'description'),
          ),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black)),
                onPressed: () async {
                  await data
                      .insertTodo(
                    TodoModel(
                      title: titleController.text.trim(),
                      description: descriptionController.text.trim(),
                      time: DateTime.now(),
                    ),
                  )
                      .then((value) {
                    debugPrint('Todo Added Success');
                    debugPrint(titleController.text);
                    debugPrint(descriptionController.text);
                    titleController.text = ' ';
                    descriptionController.text = ' ';
                    Navigator.of(context).pop();
                  });
                },
                child: const Text('Save')),
          )
        ],
      ),
    );
  }
}
