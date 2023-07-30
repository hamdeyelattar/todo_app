import 'package:bloc/bloc.dart';
import 'package:booksapp/screens/auth/archive_screen.dart';
import 'package:booksapp/screens/auth/done_screen.dart';
import 'package:booksapp/screens/auth/tasks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:sqflite/sqflite.dart';

part 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  TodoCubit() : super(TodoInitial());

  static TodoCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    NewTasksScreen(),
     DoneTaskScreen(),
     ArchivedScreen(),
  ];
  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void ChangeIndex(int index) {
    currentIndex = index;
    emit(TodoChangeBottomNavbBarState());
  }

  Database? database;
  // List<Map> tasks = [];
  List<Map> doneTasks = [];
  List<Map> archiveTasks = [];
  void createDatabase() {
    openDatabase(
      'todo.db',
      version: 1,
      onCreate: (database, version) {
        print('database created');
        database
            .execute(
                'CREATE TABLE tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)')
            .then((value) {
          print('table created');
        }).catchError((error) {
          print('Error When Creating Table ${error.toString()}');
        });
      },
      onOpen: (database) {
        getDataFromDatabse(database);
        print('database opened');
      },
    ).then((value) {
      database = value;
      emit(TodoCreateDatabaseState());
    });
  }
 List<Map> tasks = [];
  void insertToDatabase({
    required String title,
    required String time,
    required String date,
  }) async 
  {
    database!.transaction((txn) async {
      return txn.rawInsert(
        'INSERT INTO tasks(title,date,time,status) VALUES($title,$date,$time,"new")',
      )
          .then((value) {
        print('$value inserted success');

        emit(TodoInsertDatabaseState());

        getDataFromDatabse(database).then((value) {
          tasks = value;
          print(tasks);
          emit(TodoGetDatabaseState());
        });
      }).catchError((error) {
        print('Error when Inserting New Record ${error.toString()}');
      });
      
    });
  }

  Future<List<Map>> getDataFromDatabse(database) async {
    return await database!.rawQuery('SELECT * FROM tasks ');
  }

  bool isBottomSheetShown = false;
  IconData fabIcon = Icons.edit;

  void ChangeBottomSheetState({required IconData icon, required bool isShow}) {
    isBottomSheetShown = isShow;
    fabIcon = icon;
    emit(TodoChangeBottomSheetState());
  }
}
