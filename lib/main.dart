import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'package:to_do_app/logic/cubit/theme/theme_cubit.dart';
import 'package:to_do_app/presentation/router/app_router.dart';
import 'package:to_do_app/presentation/styles/theme/app_themes.dart';
import 'package:to_do_app/shared/bloc_observer.dart';

void main() {
  BlocOverrides.runZoned(
    () {
      runApp(MyApp(
        appRouter: AppRouter(),
      ));
    },
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.appRouter}) : super(key: key);
  final AppRouter appRouter;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => MainCubit()..createDatabase(),
        ),
        BlocProvider(
          create: (context) => ThemeCubit(),
        ),
      ],
      child: TodoMaterial(),
    );
  }
}

class TodoMaterial extends StatefulWidget {
  @override
  State<TodoMaterial> createState() => _TodoMaterialState();
}

class _TodoMaterialState extends State<TodoMaterial>
    with WidgetsBindingObserver {
  //---------- For following the system mode ------------
  // @override
  // void initState() {
  //   WidgetsBinding.instance!.addObserver(this);
  // }
  //
  // @override
  // void didChangePlatformBrightness() {
  //   context.read<ThemeCubit>().updateAppTheme(false);
  // }
  //
  // @override
  // void dispose() {}

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode:
          context.select((ThemeCubit themeCubit) => themeCubit.state.themeMode),
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
