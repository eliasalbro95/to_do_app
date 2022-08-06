import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'package:to_do_app/shared/components/constants.dart';
import '../../../shared/components/components.dart';
import '../../styles/colors.dart';

class EditTaskScreen extends StatelessWidget {
  EditTaskScreen(
      {Key? key,
      required this.title,
      required this.time,
      required this.date,
      required this.description,
      required this.pickedCategory,
      required this.colorPicked})
      : super(key: key) {
    titleController.text = title;
    timeController.text = time;
    dateController.text = date;
    descriptionController.text = description;
  }

  final String title;
  final String time;
  final String date;
  final String description;
  categoryPicked pickedCategory;
  int colorPicked;
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  var descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit, MainState>(
      listener: (context, state) {},
      builder: (context, state) {
        final mainCubit = MainCubit.get(context);
        return Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            centerTitle: true,
            // backgroundColor: Colors.white,
            toolbarHeight: 90.0,
            leading: Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: GestureDetector(
                onTap: () => Navigator.pop(context),
                child: SizedBox(
                  height: 10.0,
                  width: 10.0,
                  child: SvgPicture.asset(
                    "assets/icons/back_arrow.svg",
                    color: Theme.of(context).iconTheme.color,
                  ),
                ),
              ),
            ),
            title: Text(
              "Edit Task",
              style: Theme.of(context).textTheme.headline1,
            ),
            elevation: 0,
          ),
          body: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  Form(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      defaultTextField(
                        context: context,
                        controller: titleController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Title must not be empty";
                          }
                          return null;
                        },
                        label: 'Title',
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                        context: context,
                        controller: timeController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Time must not be empty";
                          }
                          return null;
                        },
                        onTap: () {
                          showTimePicker(
                                  builder: (context, Widget? child) {
                                    return child!;
                                  },
                                  context: context,
                                  initialTime: TimeOfDay.now())
                              .then((value) {
                            timeController.text = value!.format(context);
                          });
                        },
                        label: 'Time',
                      ),
                      const SizedBox(
                        height: 15.0,
                      ),
                      defaultTextField(
                        context: context,
                        controller: dateController,
                        validator: (String? value) {
                          if (value!.isEmpty) {
                            return "Date must not be empty";
                          }
                          return null;
                        },
                        onTap: () {
                          showDatePicker(
                                  builder: (context, Widget? child) {
                                    var brightness = Theme.of(context).brightness;
                                    bool isLight = brightness == Brightness.light;
                                    return Theme(
                                      data: isLight
                                          ? ThemeData.light().copyWith(
                                              colorScheme:
                                                  const ColorScheme.light(
                                                primary: dark,
                                                onPrimary: offWhite,
                                                surface: dark,
                                                onSurface: dark,
                                              ),
                                              buttonTheme: const ButtonThemeData(
                                                textTheme: ButtonTextTheme.accent,
                                              ),
                                              dialogBackgroundColor: offWhite,
                                            )
                                          : ThemeData.dark().copyWith(
                                              primaryColor:
                                                  darkThemeBackgroundColor,
                                              colorScheme: const ColorScheme.dark(
                                                  primary: Colors.white,
                                                  onPrimary:
                                                      darkThemeBackgroundColor,
                                                  surface:
                                                      darkThemeBackgroundColor,
                                                  onSurface: Colors.white),
                                              buttonTheme: const ButtonThemeData(
                                                textTheme: ButtonTextTheme.accent,
                                              ),
                                              textButtonTheme: TextButtonThemeData(
                                                  style: TextButton.styleFrom(
                                                      textStyle: const TextStyle(
                                                        color: Colors.white,
                                                        backgroundColor:
                                                            darkThemeSecondColor,
                                                      ),
                                                      shape: RoundedRectangleBorder(
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .transparent,
                                                            width: 1,
                                                            style: BorderStyle
                                                                .solid),
                                                        borderRadius:
                                                            BorderRadius.circular(
                                                                2),
                                                      ))),
                                              dialogBackgroundColor:
                                                  darkThemeSecondColor,
                                            ),
                                      child: child!,
                                    );
                                  },
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime.parse("2028-12-31"))
                              .then((value) {
                            dateController.text =
                                DateFormat.yMMMd().format(value!);
                          });
                        },
                        label: 'Date',
                      ),
                    ],
                  )),
                  const SizedBox(
                    height: 15.0,
                  ),
                  TextFormField(
                    controller: descriptionController,
                    maxLines: 8,
                    decoration: InputDecoration(
                      labelText: "Description",
                      labelStyle: Theme.of(context).textTheme.headline2,
                      // contentPadding: EdgeInsets.symmetric(vertical: 90.0)
                    ),
                  ),
                  const SizedBox(
                    height: 15.0,
                  ),
                  Wrap(
                    children: [
                      editCategoryContainer(
                          context: context,
                          color: Colors.blueAccent,
                          label: "Daily",
                          category: categoryPicked.daily,
                          onTap: () {
                            pickedCategory = categoryPicked.daily;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.daily, Colors.blueAccent);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory),
                      editCategoryContainer(
                          context: context,
                          color: Colors.deepPurple,
                          label: "Personal",
                          category: categoryPicked.personal,
                          onTap: () {
                            pickedCategory = categoryPicked.personal;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.personal, Colors.deepPurple);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory),
                      editCategoryContainer(
                          context: context,
                          color: Colors.amberAccent,
                          label: "Home",
                          category: categoryPicked.home,
                          onTap: () {
                            pickedCategory = categoryPicked.home;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.home, Colors.amberAccent);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory),
                      editCategoryContainer(
                          context: context,
                          color: Colors.greenAccent,
                          label: "Work",
                          category: categoryPicked.work,
                          onTap: () {
                            pickedCategory = categoryPicked.work;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.work, Colors.greenAccent);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory),
                      editCategoryContainer(
                          context: context,
                          color: Colors.red,
                          label: "Priority",
                          category: categoryPicked.priority,
                          onTap: () {
                            pickedCategory = categoryPicked.priority;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.priority, Colors.red);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory),
                      editCategoryContainer(
                          context: context,
                          color: Colors.purpleAccent,
                          label: "Shopping",
                          category: categoryPicked.shopping,
                          onTap: () {
                            pickedCategory = categoryPicked.shopping;
                            MainCubit.get(context).updatePickCategory(
                                categoryPicked.shopping, Colors.purpleAccent);
                          },
                          isSelected: MainCubit.get(context).isPickedUpdate,
                          selectedCategory: pickedCategory)
                    ],
                    direction: Axis.horizontal,
                    alignment: WrapAlignment.center,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: GestureDetector(
                      child: Container(
                        width: double.infinity,
                        height: 60.0,
                        child: Center(
                            child: Text(
                              "Update",
                              style: TextStyle(
                                fontSize: 24.0,
                                color: Theme.of(context).textTheme.headline3!.color,
                              ),
                            )),
                        decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Colors.deepPurple, Colors.greenAccent],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              // begin: const FractionalOffset(0.0, 1.0),
                              // end: const FractionalOffset(1.0, 0.0),
                              stops: [0.0, 5.0],
                              tileMode: TileMode.clamp,
                            ),
                            borderRadius: BorderRadius.circular(20)),
                      ),
                      onTap: () async {
                        mainCubit.updateDatabase(
                            id: editTasks[0].id,
                            title: titleController.text,
                            time: timeController.text,
                            date: dateController.text,
                            description: descriptionController.text,
                            category: mainCubit.updateCategory,
                            color: mainCubit.updatePickedColor.value);
                        titleController.text = '';
                        timeController.text = '';
                        dateController.text = '';
                        descriptionController.text = '';
                        mainCubit.addCategory = categoryPicked.none;
                        mainCubit.addPickedColor = Colors.white;
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
