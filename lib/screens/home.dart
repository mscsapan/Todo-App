import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/controller/controller.dart';
import 'package:todo_app/database/data_controller.dart';
import 'package:todo_app/model/todo_model.dart';
import 'package:todo_app/views/todo_view.dart';
import 'package:todo_app/views/user_input.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DatabaseController dataController = DatabaseController.databaseController;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController desController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // var time = DateFormat.yMMM().format(DateTime.now());
    return Scaffold(
      appBar: AppBar(
        title: const Text('AllTodo'),
        centerTitle: true,
      ),
      body: Consumer<StateController>(
        builder: (context, stateController, _) {
          return FutureBuilder<List<TodoModel>>(
            future: stateController.getQueryTodoList(),
            builder: (context, AsyncSnapshot<List<TodoModel>> snapshot) {
              if (!snapshot.hasData) {
                return const Center(child: Text('Loading..'));
              }
              return snapshot.data!.isEmpty
                  ? const Center(child: Text('No Data Available'))
                  : ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        final model = snapshot.data![index];
                        return TodoView(
                          id: model.id!,
                          title: model.title,
                          description: model.description,
                          time: model.time,
                        );
                      },
                    );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          showDialog(
              context: context,
              builder: (context) {
                return UserInput(
                    titleController: titleController,
                    descriptionController: desController);
              });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
