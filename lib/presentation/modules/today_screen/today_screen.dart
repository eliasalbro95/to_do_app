import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';

import '../../../shared/components/components.dart';
import '../../../shared/components/constants.dart';

class TodayScreen extends StatelessWidget {
  const TodayScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<MainCubit,MainState>(
      listener: (context, state) {
        if (state is UpdateDatabase){
          MainCubit.get(context).getDataFromDatabase(MainCubit.get(context).database);
        }
      },
      builder: (context, state) {
        return ListView.separated(
          itemBuilder: (context, index) =>
              taskContainer(model: allTasks[index],index: index,context: context),
          separatorBuilder: (context, index) => Container(),
          itemCount: allTasks.length,
        );
      },
    );
  }
}
