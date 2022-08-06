import 'package:flutter/material.dart';
import 'package:to_do_app/data/models/tasks/tasks_model.dart';
import 'package:to_do_app/presentation/modules/today_screen/today_screen.dart';
import '../../presentation/modules/done_screen/done_screen.dart';

// ---------------- Navigation ----------------
List<Widget> screens = [
  const TodayScreen(),
  DoneScreen(),
];

bool isSwitched = false;

// ---------------- Category ----------------

enum categoryPicked { daily, personal, home, work, priority, shopping, none }

List<TaskModel> dailyTasks = [];
List<TaskModel> personalTasks = [];
List<TaskModel> homeTasks = [];
List<TaskModel> workTasks = [];
List<TaskModel> priorityTasks = [];
List<TaskModel> shoppingTasks = [];

// ---------------- Database ----------------
List<TaskModel> allTasks = [];
List<TaskModel> editTasks = [];
List<TaskModel> doneTasks = [];


