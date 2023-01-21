import 'package:enum_to_string/enum_to_string.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:to_do_app/data/models/tasks/tasks_model.dart';

import '../../../shared/components/constants.dart';

part 'main_state.dart';

class MainCubit extends Cubit<MainState> {
  MainCubit() : super(TodoInitial());

  static MainCubit get(context) => BlocProvider.of(context);

  // -------------- Dark Mode --------------
  void switchToDarkMode(bool darkMode) {}

  // -------------- Bottom Sheet --------------
  int currentIndex = 0;
  bool isHome = true;

  void changeScreen(index) {
    isHome = !isHome;
    currentIndex = index;
    emit(AppChangeScreen());
  }

  // ---------------- Add Category ----------------
  bool itsAdd = true;
  bool isPickedAdd = false;

  // ignore: prefer_typing_uninitialized_variables
  var addCategory = categoryPicked.none;
  late Color addPickedColor = Colors.white;

  void addPickCategory(var pickedCategory, var color) {
    itsAdd ? itsAdd = false : null;
    addCategory = pickedCategory;
    addPickedColor = color;
    if (isPickedAdd == false) {
      isPickedAdd = !isPickedAdd;
    } else {
      isPickedAdd = !isPickedAdd;
      isPickedAdd = !isPickedAdd;
    }
    emit(AppChangeScreen());
  }

  // ---------------- Update Category ----------------
  bool isPickedUpdate = false;

  var updateCategory = categoryPicked.none;
  late Color updatePickedColor = Colors.white;

  void updatePickCategory(var pickedCategory, var color) {
    updateCategory = pickedCategory;
    updatePickedColor = color;
    if (isPickedUpdate == false) {
      isPickedUpdate = !isPickedUpdate;
    } else {
      isPickedUpdate = !isPickedUpdate;
      isPickedUpdate = !isPickedUpdate;
    }
    emit(AppChangeScreen());
  }

  /* -------------- Database Handle -------------- */
  /* -------------- Database Handle -------------- */
  /* -------------- Database Handle -------------- */

  Database? database;

  createDatabase() async {
    database = await openDatabase("todo.db", version: 1,
        onCreate: (Database database, int version) {
      database.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY,title TEXT,date TEXT, time TEXT,description TEXT,category BLOB,color INTEGER,status TEXT)");
      print("database created");
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print("database opened");
    });
  }

  void getDataFromDatabase(database) async {
    isPickedUpdate = true;
    allTasks = [];
    doneTasks = [];
    try {
      database!.rawQuery("SELECT * FROM tasks").then((value) {
        value.forEach((element) {
          if (element["status"] == "new") {
            allTasks.add(TaskModel(
              id: element["id"],
              title: element["title"],
              date: element["date"],
              time: element["time"],
              description: element["description"],
              category: element["category"],
              color: element["color"],
              status: element["status"],
            ));
          } else if (element["status"] == "done") {
            doneTasks.add(TaskModel(
              id: element["id"],
              title: element["title"],
              date: element["date"],
              time: element["time"],
              description: element["description"],
              category: element["category"],
              color: element["color"],
              status: element["status"],
            ));
          }
          sortCategories(element, element['category']);
        });
        emit(GetAllDataFromDatabase());
      }).catchError((error) {
        print(error);
      });
    } catch (UnhandledException) {
      print("database is empty");
    }
  }

  void sortCategories(Map task, String taskCategory) {
    switch (taskCategory) {
      case "categoryPicked.daily":
        dailyTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      case "categoryPicked.personal":
        personalTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      case "categoryPicked.home":
        homeTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      case "categoryPicked.work":
        workTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      case "categoryPicked.priority":
        priorityTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      case "categoryPicked.shopping":
        shoppingTasks.add(
          TaskModel(
            id: task["id"],
            title: task["title"],
            date: task["date"],
            time: task["time"],
            description: task["description"],
            category: task["category"],
            color: task["color"],
            status: task["status"],
          ),
        );
        break;
      default:
        return;
    }
  }

  getSpecificDataFromDatabase({required int index}) async {
    editTasks = [];

    try {
      await database!
          .rawQuery("SELECT * FROM tasks WHERE id = $index")
          .then((value) {
        value.forEach((element) {
          editTasks.add(
            TaskModel(
              id: int.parse(element["id"].toString()),
              title: element['title'].toString(),
              date: element['date'].toString(),
              time: element['time'].toString(),
              description: element['description'].toString(),
              category: element['category'].toString(),
              color: int.parse(element['color'].toString()),
              status: element['status'].toString(),
            ),
          );
          print("editTasks: $editTasks");
        });
      }).catchError((error) {
        print(error);
      });
    } catch (UnhandledException) {
      print("database is empty");
    }
  }

  insertDatabase({
    required String title,
    required String time,
    required String date,
    required String description,
    required categoryPicked category,
    required int color,
  }) async {
    await database?.transaction((txn) async {
      await txn
          .rawInsert(
              "INSERT INTO tasks(title,date,time,description,category,color,status) VALUES('$title','$date','$time','$description','$category','$color','new')")
          .then((value) {
        getDataFromDatabase(database);
        print("$value insert successfully");
        emit(InsertToDatabase());
      });
    });
  }

  void updateDatabase(
      {required int id,
      required String title,
      required String time,
      required String date,
      required String description,
      required categoryPicked category,
      required int color,
      String status = "new"}) async {
    print(color);
    var cate = EnumToString.convertToString(category);
    cate = "categoryPicked." + cate;
    await database!.rawUpdate(
        "UPDATE tasks SET title = ?, time = ?, date = ?, description = ?, category = ?,color = ?, status = ? WHERE id = ?",
        [
          title,
          time,
          date,
          description,
          cate,
          color,
          status,
          '$id'
        ]).then((value) {
      print("updated");
      // getDataFromDatabase(database);
      emit(UpdateDatabase());
      editTasks = [];
    });
  }

  void deleteFromTable({required int id}) async {
    await database!
        .rawDelete("DELETE FROM tasks WHERE id = ?", ['$id']).then((value) {
      getDataFromDatabase(database);
      emit(DeleteFromDatabase());
    });
  }

  deleteTheDatabase() async {
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'todo1.db');
    await deleteDatabase(path).then((value) {
      print("deleted");
      emit(DeleteDatabase());
    });
  }
}
