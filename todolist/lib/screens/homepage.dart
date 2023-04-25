import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:hive/hive.dart';
import 'package:todolist/model/database.dart';
import 'package:todolist/widgets/todoCard.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  TextEditingController titleController = TextEditingController(text: "");
  TextEditingController descriptionController = TextEditingController(text: "");
  Database db = Database();

  @override
  void initState() {
    super.initState();
    db.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showForm(context, null);
        },
        backgroundColor: Colors.white,
        child: Icon(
          Icons.add,
          color: Colors.cyan,
        ),
      ),
      backgroundColor: Color.fromARGB(255, 28, 62, 1),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
              child: Text(
                "TO-DO",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                    fontWeight: FontWeight.w800),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: db.tasks.length,
                itemBuilder: (context, index) {
                  return todoCard(
                      isChecked: db.tasks[index]["isChecked"],
                      onChanged: (p0) {
                        setState(() {
                          db.editTask({
                            "isChecked": !db.tasks[index]["isChecked"],
                            "title": db.tasks[index]["title"],
                            "description": db.tasks[index]["description"]
                          }, db.tasks[index]["key"]);
                        });
                      },
                      title: db.tasks[index]["title"],
                      description: db.tasks[index]["description"],
                      onPressedDelete: () {
                        setState(() {
                          db.removeTask(db.tasks[index]["key"]);
                        });
                      },
                      onPressedEdit: () {
                        showForm(context, db.tasks[index]);
                      });
                }),
          )
        ],
      ),
    );
  }

  void showForm(BuildContext context, Map<String, dynamic>? task) {
    if (task != null) {
      titleController.text = task["title"];
      descriptionController.text = task["description"];
    } else {
      titleController.clear();
      descriptionController.clear();
    }

    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Column(
            children: [
              TextFormField(
                controller: titleController,
              ),
              TextFormField(
                controller: descriptionController,
              ),
              Container(
                color: Colors.black,
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (task != null) {
                        db.editTask({
                          "isChecked": task["isChecked"],
                          "title": titleController.text,
                          "description": descriptionController.text
                        }, task["key"]);
                      } else {
                        db.addTask({
                          "isChecked": false,
                          "title": titleController.text,
                          "description": descriptionController.text,
                        });
                      }
                    });
                  },
                  child: Text("Adicionar"),
                ),
              )
            ],
          );
        });
  }
}
