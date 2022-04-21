
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'package:to_do_app/presentation/layout/sidebar_menu/sidebar.dart';
import '../../shared/components/constants.dart';
import '../styles/colors.dart';

class HomeLayout extends StatefulWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  State<HomeLayout> createState() => _HomeLayoutState();
}

class _HomeLayoutState extends State<HomeLayout> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  var formKey = GlobalKey<FormState>();

  var titleController = TextEditingController();

  var timeController = TextEditingController();

  var dateController = TextEditingController();

  String text = '';

  @override
  Widget build(BuildContext context) {
    final mainCubit = MainCubit.get(context);
    return BlocConsumer<MainCubit, MainState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            key: scaffoldKey,
            /* -----------------------------------------
               ------------ App Bar Section ------------
               -----------------------------------------*/
            appBar: AppBar(
              centerTitle: true,
              toolbarHeight: 90.0,
              leadingWidth: 60.0,
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Image.asset(
                  'assets/logo/logo3.png',
                  height: 45.0,
                  width: 45.0,
                ),
              ),
              title: Text(
                "To Do App",
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                    padding: EdgeInsets.zero,
                    onPressed: () {
                      scaffoldKey.currentState!.openEndDrawer();
                    },
                    icon: Icon(Icons.menu_rounded,size: 45.0,color: Theme.of(context).iconTheme.color,)
                  ),
                )
              ],
              elevation: 0,
            ),
            endDrawer: const SideBarMenu(),
            /* -----------------------------------------
       -------------- Body Section -------------
       -----------------------------------------*/
            body: screens[mainCubit.currentIndex],
            // -------------- Floating Section -------------
            floatingActionButton: SizedBox(
              width: 65.0,
              height: 65.0,
              child: FloatingActionButton(
                heroTag: "Btn1",
                onPressed: () async {
                  Navigator.of(context).pushNamed("/add");
                },
                child: SizedBox(
                  height: 65.0,
                  width: 65.0,
                  child: Ink(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Colors.deepPurple, Colors.greenAccent],
                        begin: FractionalOffset(0.0, 1.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: const Icon(
                      Icons.add_rounded,color: Colors.white,
                      size: 50.0,
                    ),
                  ),
                ),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerDocked,
            bottomNavigationBar: BottomAppBar(
              notchMargin: 5,
              clipBehavior: Clip.antiAlias,
              shape: const CircularNotchedRectangle(),
              color: Colors.white,
              child: BottomNavigationBar(
                // backgroundColor: dark,
                unselectedItemColor: offWhite,
                type: BottomNavigationBarType.fixed,
                currentIndex: mainCubit.currentIndex,
                onTap: (index) => mainCubit.changeScreen(index),
                items: [
                  BottomNavigationBarItem(
                      activeIcon: ShaderMask(
                        shaderCallback: (Rect bounds) {
                          return const LinearGradient(
                            colors: [Colors.deepPurple, Colors.greenAccent],
                            begin: Alignment.bottomLeft,
                            end: Alignment.topRight,
                            stops: [0.0, 4.0],
                            tileMode: TileMode.clamp,
                          ).createShader(bounds);
                        },
                        child: Icon(Icons.home_rounded),
                      ),
                      icon: Icon(mainCubit.isHome
                          ? Icons.home_rounded
                          : Icons.home_outlined),
                      label: "Home"),
                  BottomNavigationBarItem(
                      activeIcon: ShaderMask(
                          shaderCallback: (Rect bounds) {
                            return const LinearGradient(
                              colors: [Colors.deepPurple, Colors.greenAccent],
                              begin: Alignment.bottomLeft,
                              end: Alignment.topRight,
                              stops: [0.0, 4.0],
                              tileMode: TileMode.clamp,
                            ).createShader(bounds);
                          },
                          child: const Icon(Icons.check_circle_rounded)),
                      icon: Icon(mainCubit.isHome
                          ? Icons.check_circle_outline_rounded
                          : Icons.check_circle_rounded),
                      label: "Done"),
                  // BottomNavigationBarItem(
                  //     icon: Icon(Icons.archive), label: "Archived"),
                ],
              ),
            ),
          );
        });
  }
}
