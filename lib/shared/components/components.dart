import 'package:enum_to_string/enum_to_string.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do_app/data/models/tasks/tasks_model.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'constants.dart';

Widget defaultTextField(
        {required TextEditingController controller,
        required String? label,
        required String? Function(String?) validator,
        required String prefix,
        VoidCallback? onTap,
        required BuildContext context}) =>
    TextFormField(
        controller: controller,
        keyboardType: TextInputType.text,
        validator: validator,
        onTap: onTap,
        textAlignVertical: TextAlignVertical.center,
        style: Theme.of(context).textTheme.bodyText1,
        decoration: InputDecoration(
            contentPadding: const EdgeInsets.symmetric(vertical: 10.0),
            labelText: label,
            labelStyle: Theme.of(context).textTheme.headline2,
            focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).iconTheme.color!))));

Widget taskContainer(
    {required TaskModel model,
    required int index,
    required BuildContext context}) {
  var tempModel = model.category.toString().split(".");
  var tempCategory = EnumToString.fromString(
      categoryPicked.values, model.category.substring(15));
  return Slidable(
    startActionPane: ActionPane(
      motion: const ScrollMotion(),
      extentRatio: 1,
      children: [
        model.status == "done"
            ? Container()
            : SlidableAction(
                onPressed: (context) {
                  MainCubit.get(context).updateDatabase(
                      id: model.id,
                      title: model.title,
                      time: model.time,
                      date: model.date,
                      description: model.description,
                      category: tempCategory!,
                      color: model.color,
                      status: "done");
                },
                backgroundColor: Color(model.color),
                foregroundColor: Theme.of(context).primaryColor,
                icon: Icons.check_rounded,
                label: "Completed",
              ),
        SlidableAction(
          onPressed: (context) {
            MainCubit.get(context).getSpecificDataFromDatabase(index: model.id);
            Navigator.of(context).pushNamed("/edit");
          },
          backgroundColor: Color(model.color),
          foregroundColor: Theme.of(context).primaryColor,
          icon: Icons.edit,
          label: "Edit",
        ),
        SlidableAction(
          onPressed: (context) {
            MainCubit.get(context).deleteFromTable(id: model.id);
          },
          backgroundColor: Color(model.color),
          foregroundColor: Theme.of(context).primaryColor,
          icon: Icons.delete,
          label: "Delete",
        ),
      ],
    ),
    child: IntrinsicHeight(
      child: Container(
        color: Theme.of(context).primaryColor,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: 10.0,
                decoration: BoxDecoration(
                  color: Color(model.color),
                ),
              ),
            ),
            Expanded(
              flex: 45,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 30.0, vertical: 15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tempModel[1].toUpperCase(),
                      style:
                          TextStyle(color: Color(model.color), fontSize: 14.0),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Text(
                      model.title,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 15.0,
                    ),
                    Row(
                      children: [
                        Text(
                          "${model.date}",
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                        ),
                        Text(
                          " at ${model.time}",
                          style: const TextStyle(
                              color: Colors.grey, fontSize: 12.0),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 10,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: IconButton(
                  icon: const Icon(Icons.edit, color: Colors.grey, size: 30.0),
                  onPressed: () {
                    MainCubit.get(context)
                        .getSpecificDataFromDatabase(index: model.id);
                    Navigator.of(context).pushNamed("/edit");
                  },
                ),
              ),
            )
          ],
        ),
      ),
    ),
  );
}

// ---------------- Category ----------------

Widget editCategoryContainer({
  // Category Containers for update task screen
  required BuildContext context,
  required Color color,
  required String label,
  required categoryPicked category,
  required VoidCallback? onTap,
  required categoryPicked? selectedCategory,
  required bool isSelected,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).textTheme.headline3!.color),
              ),
              Icon(
                isSelected && selectedCategory == category
                    ? Icons.check_circle_outline_rounded
                    : null,
                size: 25.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected && selectedCategory == category
                ? color.withAlpha(255).withOpacity(0.5)
                : color,
          ),
        ),
        onTap: onTap,
      ),
    ); //daily

Widget addCategoryContainer({
  // Category Containers for add task screen
  required BuildContext context,
  required Color color,
  required String label,
  required categoryPicked category,
  required VoidCallback? onTap,
  required categoryPicked selectedCategory,
  required bool isSelected,
}) =>
    Padding(
      padding: const EdgeInsets.only(left: 8.0, top: 8.0, bottom: 8.0),
      child: GestureDetector(
        child: Container(
          padding: const EdgeInsets.all(10.0),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                label,
                style: TextStyle(
                    fontSize: 18.0,
                    color: Theme.of(context).textTheme.headline3!.color),
              ),
              Icon(
                isSelected && selectedCategory == category
                    ? Icons.check_circle_outline_rounded
                    : null,
                size: 25.0,
                color: Theme.of(context).iconTheme.color,
              ),
            ],
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20.0),
            color: isSelected && selectedCategory == category
                ? color.withAlpha(255).withOpacity(0.5)
                : color,
          ),
        ),
        onTap: onTap,
      ),
    );
