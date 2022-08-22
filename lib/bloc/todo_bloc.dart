import 'package:donev2/model/todo.dart';
import 'package:donev2/dao/todo_dao.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'dart:async';

import 'package:flutter/material.dart';

class TodoBloc extends ChangeNotifier {
  //Get instance of the Repository
  final _todoDao = TodoDao();

  //Stream controller is the 'Admin' that manages
  //the state of our stream of data like adding
  //new data, change the state of the stream
  //and broadcast it to observers/subscribers
  final _todoController = StreamController<List<Todo>?>.broadcast();
  final _categoryController =
      StreamController<List<Map<String, dynamic>>>.broadcast();
  final _groupController = StreamController<List<Todo>?>.broadcast();

  final formKey =
      GlobalKey<FormState>(); // The key for my forms on the add_screen page

  /// Getters for the stream
  get todos => _todoController.stream;
  get categories => _categoryController.stream;
  get group => _groupController.stream;

  TodoBloc() {
    getTodos();
    getCategories();
  }

  // This object holds the information on the 'Add Task' / 'Edit Task' Page
  Todo? currentTask;
  DateTime? time;
  String selected = '';
  int? _length;
  DateTime? myTime = DateTime.now();
  int? nextNumber;
  String? username = ' 👋';

  // I don't know why this works
  update({DateTime? value, TimeOfDay? value2}) {
    notifyListeners();
  }

  int? get length => _length;

  set length(int? length) {
    _length = length;
    notifyListeners();
  }

  // If a value is not present in storage we get a null value
  //int intValue = await prefs.getInt('intValue') ?? 0;

  verifyKey() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.containsKey('Name')) {
      getName();
    } else {
      editName();
    }
  }

  editName({String name = '👋'}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('Name', name);
  }

  getName() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    username = prefs.getString('Name');
    notifyListeners();
  }

  getTodos({String? query}) async {
    // (Sink) is a way of adding data reactively to the stream
    _todoController.sink.add(
      await _todoDao.getTodos(query: query, columns: []),
    );
  }

  getCategories({String? query}) async {
    _categoryController.sink.add(
      await _todoDao.getCategories(query: query),
    );
  }

  getGroup({required String category, String? query}) async {
    _groupController.sink.add(
      await _todoDao.fetchGroup(category: category, query: query),
    );
  }

  void getNext() async {
    nextNumber = await _todoDao.getNext();
    notifyListeners();
  }

  addTodo(Todo todo) async {
    await _todoDao.createTodo(todo);
    getTodos();
    getCategories();
  }

  updateTodo(Todo todo) async {
    await _todoDao.updateTodo(todo);
    getTodos();
    getCategories();
    getGroup(category: selected);
  }

  deleteTodoById(int id) async {
    _todoDao.deleteTodo(id);
    getTodos();
    getCategories();
    getGroup(category: selected);
  }

  deleteCategory(String category) async {
    _todoDao.deleteCategory(category);
    getTodos();
    getCategories();
  }

  @override
  dispose() {
    super.dispose();
    _todoController.close();
    _categoryController.close();
  }
}
