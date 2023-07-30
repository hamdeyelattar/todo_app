import 'package:booksapp/screens/widgets/components.dart';
import 'package:booksapp/shared/cubit/todo_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NewTasksScreen extends StatelessWidget {
  NewTasksScreen();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<TodoCubit, TodoState>(
      listener: (context, state) {
      
      },
      builder: (context, state) {
       var tasks = TodoCubit.get(context).tasks;
        return ListView.separated(
            itemBuilder: (context, index) => buildTaskItem(tasks[index]),
            separatorBuilder: (context, index) => Container(
                  width: double.infinity,
                  height: 2,
                  color: Colors.grey[300],
                ),
            itemCount: tasks.length);
      },
    );
  }
}
