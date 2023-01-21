import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:to_do_app/logic/cubit/login_signup/login_and_signup_cubit.dart';
import 'package:to_do_app/presentation/styles/colors.dart';
import 'package:to_do_app/shared/components/responsive.dart';
import '../../../data/models/pie/pie_data_model.dart';
import '../../../logic/cubit/main_cubit/main_cubit.dart';
import '../../../logic/cubit/theme/theme_cubit.dart';
import '../../../shared/components/constants.dart';
import '../../../shared/network/local/shared_preferences.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeCubit = ThemeCubit.get(context);
    ResponsiveScreen responsiveScreen = ResponsiveScreen(context);
    List<PieData> dataPie = [
      PieData('Done', doneTasks.length, "Done"),
      PieData('Remain', (allTasks.length - doneTasks.length) + 1, "Remain")
    ];
    return Scaffold(
        appBar: AppBar(
          elevation: 0,
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
                  )),
            ),
          ),
          //TODO: Add options here
        ),
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      child: CircleAvatar(
                        backgroundImage:
                            // TODO: Insert the image from the account
                            AssetImage("assets/profilePic/Rebecca.jpg"),
                        radius: responsiveScreen.width * 0.22,
                      ),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                                blurRadius: 6,
                                color: Colors.black26,
                                spreadRadius: 2)
                          ]),
                    ),
                    SizedBox(
                      height: responsiveScreen.height * .03,
                    ),
                    Text(
                      LoginAndSignupCubit.get(context)
                          .userModel
                          .name
                          .toString(),
                      // TODO: Insert the name from the account
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
                    SizedBox(
                      height: responsiveScreen.height * .03,
                    ),
                    SfCircularChart(
                        legend: Legend(isVisible: false),
                        palette: [
                          Colors.orange[100]!,
                          Colors.purple[100]!,
                        ],
                        series: <PieSeries<PieData, String>>[
                          PieSeries<PieData, String>(
                              explode: false,
                              explodeIndex: 0,
                              dataSource: dataPie,
                              xValueMapper: (PieData data, _) => data.xData,
                              yValueMapper: (PieData data, _) => data.yData,
                              dataLabelMapper: (PieData data, _) => data.text,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                          ),
                        ],
                    )
                    // Row(
                    //   // crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.spaceAround,
                    //   children: [
                    //     Container(
                    //       height: responsiveScreen.height * .065,
                    //       width: responsiveScreen.width * .18,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Expanded(child: Text("Done")),
                    //             SizedBox(
                    //               height: responsiveScreen.height * .004,
                    //             ),
                    //             // TODO: Insert the number from database
                    //             Expanded(child: Text("2"),),
                    //           ],
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: Colors.green[300],
                    //         shape: BoxShape.rectangle,
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //     ),
                    //     Container(
                    //       height: responsiveScreen.height * .065,
                    //       width: responsiveScreen.width * .18,
                    //       child: Padding(
                    //         padding: const EdgeInsets.all(8.0),
                    //         child: Column(mainAxisAlignment: MainAxisAlignment.center,
                    //           children: [
                    //             Expanded(child: Text("Remain")),
                    //             SizedBox(
                    //               height: responsiveScreen.height * .004,
                    //             ),
                    //             // TODO: Insert the number from database
                    //             Expanded(child: Text("12"),),
                    //           ],
                    //         ),
                    //       ),
                    //       decoration: BoxDecoration(
                    //         color: Colors.red[300],
                    //         shape: BoxShape.rectangle,
                    //         borderRadius: BorderRadius.circular(5),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
              ),
              SizedBox(
                height: responsiveScreen.height * 0.005,
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    ListTile(
                      leading: Icon(Icons.account_circle_outlined),
                      title: Text("Account Information",
                          style: Theme.of(context).textTheme.bodyText2),
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: const Icon(Icons.dark_mode_outlined),
                      title: Text('Dark Mode',
                          style: Theme.of(context).textTheme.bodyText2),
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
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: const Icon(Icons.share_outlined),
                      title: Text('Share',
                          style: Theme.of(context).textTheme.bodyText2),
                      onTap: () => null,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: const Icon(Icons.star_outline),
                      title: Text('Rate us',
                          style: Theme.of(context).textTheme.bodyText2),
                      onTap: () => null,
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 20),
                      leading: Icon(Icons.logout_outlined),
                      title: Text("Log out",
                          style: Theme.of(context).textTheme.bodyText2),
                      onTap: () async {
                        await LoginAndSignupCubit.get(context)
                            .logoutButton()
                            .then((value) async {
                          await CacheHelper.saveData(
                              key: "loggedIn", value: false);
                          Navigator.of(context).pushNamed("/");
                        });
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
