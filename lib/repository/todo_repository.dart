import 'dart:convert';

import 'package:flutter_application_dio/model/todo.dart';
import 'package:flutter_application_dio/repository/repository.dart';
import 'package:http/http.dart' as http;

class TodoRepository implements Repository {
  String dataUrl = 'https://jsonplaceholder.typicode.com';
  @override
  Future<String> deleteTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    var result = 'false';
    await http.delete(url).then((value) {
      return result = 'true';
    });
    return result;
  }

  @override
  Future<List<Todo>> getTodoList() async {
    List<Todo> todoList = [];
    var url = Uri.parse('$dataUrl/todos');
    var response = await http.get(url);
    // ignore: avoid_print
    print('Status code is: ${response.statusCode}');
    List body = json.decode(response.body);
    for (var i = 0; i < body.length; i++) {
      todoList.add(Todo.fromJson(body[i]));
    }
    return todoList;
  }

  @override
  Future<String> patchCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    await http.patch(url,
        body: {'completed': (!todo.completed!).toString()},
        headers: {'Authorization': 'your_token'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      // ignore: avoid_print
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }

  @override
  Future<String> postTodo(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/');
    var result = '';
    var response = await http.post(url, body: todo.toJson());
    return 'true';
  }

  @override
  Future<String> putCompleted(Todo todo) async {
    var url = Uri.parse('$dataUrl/todos/${todo.id}');
    String resData = '';
    await http.put(url,
        body: {'completed': (!todo.completed!).toString()},
        headers: {'Authorization': 'your_token'}).then((response) {
      Map<String, dynamic> result = json.decode(response.body);
      // ignore: avoid_print
      print(result);
      return resData = result['completed'];
    });
    return resData;
  }
}
