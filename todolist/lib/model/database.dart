import 'package:hive/hive.dart';

class Database {
  var myBox = Hive.box("todoapp");

  List tasks = [];

  void refresh() {
    var data = myBox.keys.map((key) {
      var task = myBox.get(key);
      return {
        "key": key,
        "isChecked": task["isChecked"],
        "title": task["title"],
        "description": task["description"]
      };
    }).toList();
    tasks = data.toList();
  }

  void addTask(Map<String, dynamic> task) {
    myBox.add(task);
    refresh();
  }

  void removeTask(int id) {
    myBox.delete(id);
    refresh();
  }

  void editTask(Map<String, dynamic> task, int id) {
    myBox.put(id, task);
    refresh();
  }
}
