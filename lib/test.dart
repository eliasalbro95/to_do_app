import 'package:sqflite/sqflite.dart';
Database? database;

void createDatabase() {
  openDatabase(
    "todoapp.db",
    version: 1,
    onCreate: (
      Database database,
      int version,
    ) {
      database.execute(
          "CREATE TABLE tasks(id INTEGER PRIMARY KEY, title TEXT, date TEXT,time TEXT, status TEXT)");
      print("Database created");
    },
    onOpen: (database) {
      print("database opened");
    },
  );
}

insertToDatabase({
  required String title,
  required String time,
  required String date,
}) async {
  await database?.transaction((txn) async {
    await txn
        .rawInsert(
            "INSERT INTO tasks(title,date,time,status) VALUES('$title','$date','$time','new',)")
        .then((value) {
      print("$value inserted successfully!");
    }).catchError((error) {
      print("Error when inserting new task ${error.toString()}");
    });
  });
}



void main(){
createDatabase();
}
