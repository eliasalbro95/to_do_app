// import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'dart:math';

import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/presentation/modules/add_screen/create_new_task_screen.dart';
import 'package:to_do_app/presentation/modules/profile_screen/profile_screen.dart';
import 'package:to_do_app/shared/components/constants.dart';
import '../../shared/network/local/shared_preferences.dart';
import '../layout/home_layout.dart';
import '../modules/edit_screen/edit_task_screen.dart';
import '../modules/login_screen/login_screen.dart';
import '../modules/signup_screen/signup_screen.dart';

class AppRouter {


   static Route? onGenerateRoute(RouteSettings routeSettings) {
     bool? loggedIn;
     loggedIn = CacheHelper.getData(key: "loggedIn");
    switch (routeSettings.name) {
      case '/':
          return MaterialPageRoute(builder: (_) {
            // loggedIn = false;
            if(loggedIn !=null){
              if(loggedIn){
                return HomeLayout();
              }else{
                return LoginScreen();
              }
            }else{
             return LoginScreen();
            }
          } );
      case '/login':
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case '/signup':
        return MaterialPageRoute(builder: (_) => SignupScreen());
      case '/add':
        return MaterialPageRoute(builder: (_) => const CreateNewTaskScreen());
      case '/edit':
        return MaterialPageRoute(builder: (_) {
          var tempCategory;
          tempCategory = EnumToString.fromString(categoryPicked.values,
              editTasks[0].category.toString().substring(15));
          // print("Temp"+tempCategory);
          return EditTaskScreen(
            title: editTasks[0].title,
            time: editTasks[0].time,
            date: editTasks[0].date,
            description: editTasks[0].description,
            pickedCategory: tempCategory!,
            colorPicked: editTasks[0].color,
          );
        });
      case '/profile':
        return MaterialPageRoute(builder: (_) => const ProfileScreen());
      default:
        return null;
    }
  }
}
