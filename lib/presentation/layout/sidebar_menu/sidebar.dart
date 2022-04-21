import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'package:to_do_app/presentation/styles/theme/app_themes.dart';

import '../../../logic/cubit/theme/theme_cubit.dart';
import '../../../shared/components/constants.dart';

class SideBarMenu extends StatelessWidget {
  const SideBarMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mainCubit = MainCubit.get(context);
    final themeCubit = ThemeCubit.get(context);
    return Drawer(
      child: ListView(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              "Todo App",
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Theme.of(context).textTheme.headline3!.color),
            ),
            accountEmail: const Text(""),
            currentAccountPicture: Image.asset(
              'assets/logo/logo3.png',
              height: 45.0,
              width: 45.0,
            ),
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.deepPurple,
                  // Colors.yellow,
                  Colors.greenAccent
                  // const Color(0xFF3366FF),
                  // const Color(0xFF00CCFF),
                ],
                begin: const FractionalOffset(0.0, 2.0),
                end: const FractionalOffset(1.0, 0.0),
                stops: [0.0, 1.0],
                tileMode: TileMode.clamp,
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.dark_mode),
            title:
                Text('Dark Mode', style: Theme.of(context).textTheme.bodyText2),
            onTap: () => null,
            trailing: BlocConsumer<MainCubit, MainState>(
              listener: (context, state) {},
              builder: (context, state) {
                return Switch(
                    value: isSwitched,
                    onChanged: (value) {
                      isSwitched = value;
                      themeCubit.updateAppTheme(isSwitched);
                    });
              },
            ),
          ),
          ListTile(
            leading: const Icon(Icons.share),
            title: Text('Share', style: Theme.of(context).textTheme.bodyText2),
            onTap: () => null,
          ),
          ListTile(
            leading: const Icon(Icons.star),
            title:
                Text('Rate us', style: Theme.of(context).textTheme.bodyText2),
            onTap: () => null,
          ),
        ],
      ),
    );
  }
}
