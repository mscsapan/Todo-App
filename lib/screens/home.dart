import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/database/data_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/views/input_view.dart';

class Home extends StatelessWidget {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final DatabaseController databaseController =
      DatabaseController.databaseController;

  Future openDialog(BuildContext context) {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Alert Dialog Box'),
            content: InputView(
              titleController: titleController,
              descriptionController: descriptionController,
            ),
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              TextButton(
                  onPressed: () async {
                    databaseController
                        .insertTodo(
                          TodoModel(
                            title: titleController.text.trim(),
                            description: descriptionController.text.trim(),
                            time: DateTime.now(),
                          ),
                        )
                        .whenComplete(() => print('Insert Success'));
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK')),
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('All Todo')),
      body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
          width: double.infinity,
          child: Consumer<StateController>(
            builder: (BuildContext context, controller, _) {
              return FutureBuilder<List<TodoModel>>(
                  future: controller.getQueryTodoList(),
                  builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
                    return snapshot.hasData
                        ? ListView.builder(
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, index) {
                              final TodoModel model = snapshot.data![index];
                              return ListTile(
                                title: Text(model.title.toString()),
                                subtitle: Text(model.description.toString()),
                                trailing: Text(model.time!.minute.toString()),
                              );
                            })
                        : const Center(
                            child: Text(
                              'No Data Found',
                              style: TextStyle(fontSize: 30.0),
                            ),
                          );
                  });
            },
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () => openDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }
}
