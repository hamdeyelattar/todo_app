import 'package:booksapp/shared/cubit/todo_cubit.dart';
import 'package:booksapp/shared/cubit/todo_cubit.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../widgets/components.dart';

// ignore: must_be_immutable
class HomeLayout extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => TodoCubit()..createDatabase(),
      child: BlocConsumer<TodoCubit, TodoState>(
        listener: (BuildContext context, TodoState state) {
          if (state is TodoInsertDatabaseState) {
            Navigator.pop(context);
          }
        },
        builder: (BuildContext context,TodoState state) {
        
          TodoCubit cubit = TodoCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              condition: true,
              builder: (context) => cubit.screens[cubit.currentIndex],
              fallback: (context) => Center(
                child:  CircularProgressIndicator(),
              ),
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
              if (cubit.isBottomSheetShown) {
                if (formKey.currentState!.validate()) {
                  cubit.insertToDatabase(
                    title: titleController.text,
                    time: timeController.text,
                    date: dateController.text,
                  );
                }
              }

                //   insertToDatabase(
                //     date: dateController.text,
                //     time: timeController.text,
                //     title: titleController.text,
                //   ).then((value) {
                //     getDataFromDatabse(database).then((value) {
                //       Navigator.pop(context);
                //     });
                //   });
                // }
                else {
                  scaffoldKey.currentState!
                      .showBottomSheet(
                        (context) => Container(
                          padding: EdgeInsets.all(20),
                          color: Colors.white,
                          child: Form(
                            key: formKey,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                defalutFormfeild(
                                  controller: titleController,
                                  type: TextInputType.text,
                                  valdiate: (value) {
                                    if (value!.isEmpty) {
                                      return 'title must not be empty';
                                    }
                                  },
                                  label: 'Task Title',
                                  prefix: Icons.title,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defalutFormfeild(
                                  controller: timeController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showTimePicker(
                                      context: context,
                                      initialTime: TimeOfDay.now(),
                                    ).then((value) {
                                      timeController.text =
                                          value!.format(context).toString();
                                      print(value.format(context));
                                    });
                                  },
                                  valdiate: (value) {
                                    if (value!.isEmpty) {
                                      return 'time must not be empty';
                                    }
                                  },
                                  label: 'Task Time',
                                  prefix: Icons.watch_later_outlined,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                defalutFormfeild(
                                  controller: dateController,
                                  type: TextInputType.datetime,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2025-05-03'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value!);
                                    });
                                  },
                                  valdiate: (value) {
                                    if (value!.isEmpty) {
                                      return 'date must not be empty';
                                    }
                                  },
                                  label: 'Task Date',
                                  prefix: Icons.calendar_today,
                                ),
                              ],
                            ),
                          ),
                        ),
                        elevation: 30,
                      )
                      .closed
                      .then((value) {
                    cubit.ChangeBottomSheetState(
                        icon: Icons.edit, isShow: false);
                  });
                  cubit.ChangeBottomSheetState(icon: Icons.add, isShow: true);
                }

                // insertToDatabase();
                // async {
                //   // try {
                //   //   var name = await getName();
                //   //   print(name);
                //   //   throw('some error!!!!!');
                //   // } catch (error) {
                //   //   print('error ${error.toString()}');
                //   // }
                //   getName().then((value) {
                //     print(value);
                //     print('mohamed');
                //   });
              },
              child: Icon(cubit.fabIcon),
            ),
            bottomNavigationBar: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                elevation: 25,
                currentIndex: TodoCubit.get(context).currentIndex,
                onTap: (index) {
                  cubit.ChangeIndex(index);
                },
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.menu),
                    label: 'Tasks',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.check),
                    label: 'Done',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.archive_outlined),
                    label: 'Archived',
                  ),
                ]),
          );
        },
      ),
    );
  }

  // Future<String> getName() async {
  //   return 'hamdey';
  // }
}
