import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/logic/cubit/main_cubit/main_cubit.dart';
import 'package:to_do_app/presentation/layout/sidebar_menu/sidebar.dart';
import 'package:to_do_app/shared/components/components.dart';
import 'package:to_do_app/shared/components/responsive.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';
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
    ResponsiveScreen responsiveScreen = ResponsiveScreen(context);
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
              leadingWidth: responsiveScreen.width * .146,
              // TODO: Add the firebase Picture
              leading: Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed('/profile');
                  },
                  // TODO: Go back to make it change if there is profile pic in the account
                  child: CircleAvatar(
                    radius: 30,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(30),
                        child: Image.asset(
                            "assets/profilePic/profile_icon_white.png",
                            scale: 10)),
                  ),
                ),
              ),
              title: Text(
                "Do it Simply",
                style: Theme.of(context).textTheme.headline1,
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 10.0),
                  child: IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        // scaffoldKey.currentState!.openEndDrawer();
                      },
                      icon: Icon(
                        Icons.notifications_outlined,
                        size: 30.0,
                        color: Theme.of(context).iconTheme.color,
                      )),
                )
              ],
              elevation: 0,
            ),
            endDrawer: const SideBarMenu(),
            /* -----------------------------------------
       -------------- Body Section -------------
       -----------------------------------------*/
            body: (allTasks.length == 0 && mainCubit.currentIndex == 0) ||
                    (doneTasks.length == 0 && mainCubit.currentIndex == 1)
                ? Center(
                    child: Stack(
                      alignment: Alignment.center,
                      children: [
                        Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Flexible(
                              child: Opacity(
                                opacity: 0.6,
                                child: SizedBox(
                                    height: responsiveScreen.height * .20,
                                    child: waves()),
                              ),
                            ),
                            Flexible(
                              child: Opacity(
                                opacity: 0.6,
                                child: SizedBox(
                                  height: responsiveScreen.height * .20,
                                  child: RotatedBox(
                                    quarterTurns: 2,
                                    child: Transform.scale(
                                      scaleX: -1,
                                      child: waves(),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Text(
                          mainCubit.currentIndex == 0
                              ? "No tasks\nClick '+' to add a task."
                              : "No tasks Completed.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        // Transform.scale(
                        //   scaleX: -1,
                        //   child: Column(
                        //     children: [
                        //       SizedBox(
                        //         height: responsiveScreen.height * .10,
                        //         child: Opacity(
                        //           opacity: 0.6,
                        //           child: WaveWidget(
                        //             config: CustomConfig(
                        //               gradients: [
                        //                 [
                        //                   Colors.red[400]!,
                        //                   Colors.yellow[400]!,
                        //
                        //                   // Colors.green[200]!,
                        //                 ],
                        //                 [
                        //                   Colors.red[400]!,
                        //                   Colors.yellow[400]!,
                        //                   // Colors.green[200]!,
                        //                 ],
                        //                 [
                        //                   Colors.red[400]!,
                        //                   Colors.yellow[400]!,
                        //                   // Colors.green[200]!,
                        //                 ],
                        //                 [
                        //                   Colors.red[400]!,
                        //                   Colors.yellow[400]!,
                        //                 ],
                        //               ],
                        //               gradientBegin: Alignment.bottomLeft,
                        //               gradientEnd: Alignment.topRight,
                        //               durations: [18000, 8000, 5000, 12000],
                        //               heightPercentages: [
                        //                 0.10,
                        //                 0.20,
                        //                 0.30,
                        //                 0.40
                        //               ],
                        //             ),
                        //             size: Size(double.infinity,
                        //                 double.infinity),
                        //             waveAmplitude: 0,
                        //           ),
                        //         ),
                        //       ),
                        //       SizedBox(
                        //         height: responsiveScreen.height * .10,
                        //         child: RotatedBox(
                        //           quarterTurns: 2,
                        //           child: Opacity(
                        //             opacity: 0.6,
                        //             child: Transform.scale(
                        //               scaleX: -1,
                        //               child: WaveWidget(
                        //                 config: CustomConfig(
                        //                   gradients: [
                        //                     [
                        //                       Colors.red[400]!,
                        //                       Colors.yellow[400]!,
                        //                     ],
                        //                     [
                        //                       Colors.red[400]!,
                        //                       Colors.yellow[400]!,
                        //                       // Colors.green[200]!,
                        //                     ],
                        //                     [
                        //                       Colors.red[400]!,
                        //                       Colors.yellow[400]!,
                        //                       // Colors.green[200]!,
                        //                     ],
                        //                     [
                        //                       Colors.red[400]!,
                        //                       Colors.yellow[400]!,
                        //                     ],
                        //                   ],
                        //                   gradientBegin: Alignment.bottomLeft,
                        //                   gradientEnd: Alignment.topRight,
                        //                   durations: [18000, 8000, 5000, 12000],
                        //                   heightPercentages: [
                        //                     0.10,
                        //                     0.20,
                        //                     0.30,
                        //                     0.40
                        //                   ],
                        //                 ),
                        //                 size: Size(double.infinity,
                        //                     double.infinity),
                        //                 waveAmplitude: 0,
                        //               ),
                        //             ),
                        //           ),
                        //         ),
                        //       ),
                        //     ],
                        //   ),
                        // ),
                      ],
                    ),
                  )
                : screens[mainCubit.currentIndex],
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
                        colors: [Color(0xffce93d8), Color(0xffffee58)],
                        begin: FractionalOffset(0.0, 1.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 7.0],
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: const Icon(
                      Icons.add_rounded,
                      color: Colors.white,
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
                selectedItemColor: offWhite,
                type: BottomNavigationBarType.fixed,
                currentIndex: mainCubit.currentIndex,
                onTap: (index) => mainCubit.changeScreen(index),
                items: [
                  // TODO: change active icons color
                  BottomNavigationBarItem(
                    backgroundColor: Colors.transparent,
                    activeIcon: gradientIcon(
                      icon: mainCubit.isHome
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                      gradient: LinearGradient(
                        colors: [Color(0xffce93d8), Color(0xffffee58)],
                        begin: FractionalOffset(0.0, 1.0),
                        end: FractionalOffset(1.0, 0.0),
                        stops: [0.0, 1.0],
                        tileMode: TileMode.repeated,
                      ),
                    ),
                    // Ink(
                    //   decoration: const BoxDecoration(
                    //     shape: BoxShape.circle,
                    //     gradient: LinearGradient(
                    //       colors: [Color(0xffce93d8), Color(0xffffee58)],
                    //       begin: FractionalOffset(0.0, 1.0),
                    //       end: FractionalOffset(1.0, 0.0),
                    //       stops: [0.0, 7.0],
                    //       tileMode: TileMode.clamp,
                    //     ),
                    //   ),
                    //   child: Icon(
                    //     mainCubit.isHome
                    //         ? Icons.home_rounded
                    //         : Icons.home_outlined,
                    //     // size: 26,
                    //     color: Colors.white,
                    //   ),
                    // ),
                    // ShaderMask(
                    //   shaderCallback: (Rect bounds) {
                    //     return const LinearGradient(
                    //       colors: [Color(0xffce93d8), Color(0xffffee58)],
                    //       begin: Alignment.topCenter,
                    //       end: Alignment.bottomCenter,
                    //       tileMode: TileMode.clamp,
                    //     ).createShader(bounds);
                    //   },
                    //   child:
                    // ),
                    icon: Icon(
                      mainCubit.isHome
                          ? Icons.home_rounded
                          : Icons.home_outlined,
                      color: Colors.white,
                    ),
                    label: "Home",
                  ),
                  BottomNavigationBarItem(
                      activeIcon: gradientIcon(
                        icon: mainCubit.isHome
                            ? Icons.check_circle_outline_rounded
                            : Icons.check_circle_rounded,
                        gradient: LinearGradient(
                          colors: [Color(0xffce93d8), Color(0xffffee58)],
                          begin: FractionalOffset(0.0, 1.0),
                          end: FractionalOffset(1.0, 0.0),
                          stops: [0.0, 1.0],
                          tileMode: TileMode.repeated,
                        ),
                      ),
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
