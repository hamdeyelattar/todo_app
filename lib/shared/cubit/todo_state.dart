part of 'todo_cubit.dart';

@immutable
abstract class TodoState {}

class TodoInitial extends TodoState {}
class TodoChangeBottomNavbBarState extends TodoState {}
class TodoCreateDatabaseState extends TodoState {}
class TodoGetDatabaseState extends TodoState {}
class TodoInsertDatabaseState extends TodoState {}
 
 class TodoChangeBottomSheetState extends TodoState {}
