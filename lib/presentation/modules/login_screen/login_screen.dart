import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:to_do_app/logic/cubit/login_signup/login_and_signup_cubit.dart';
import 'package:to_do_app/shared/components/components.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../shared/components/responsive.dart';
import '../../../shared/network/local/shared_preferences.dart';
import '../../styles/colors.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ResponsiveScreen responsiveScreen = ResponsiveScreen(context);
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Flexible(
              flex: 1,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    colors: [
                      Colors.red[400]!,
                      Colors.yellow[400]!,
                      Colors.purple[400]!,
                      Color(0xff1c272c),
                      // Colors.green[200]!,
                    ],
                    durations: [18000, 8000, 5000, 12000],
                    heightPercentages: [0.20, 0.21, 0.24, 0.30],
                  ),
                  size: Size(double.infinity, responsiveScreen.height * .30),
                  waveAmplitude: 0,
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Hello",
                    style: TextStyle(fontSize: 60, fontWeight: FontWeight.w900),
                  ),
                  SizedBox(
                    height: responsiveScreen.height * .015,
                  ),
                  Text(
                    "Sign in to your account",
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(
                    height: responsiveScreen.height * .08,
                  ),
                  Form(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: defaultTextField(
                              controller: emailController,
                              label: "Email address",
                              validator: (value) {
                                // TODO: email validator
                              },
                              context: context,
                              prefix: Icons.email_outlined),
                        ),
                        SizedBox(
                          height: responsiveScreen.height * .03,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30.0),
                          child: defaultTextField(
                              controller: passwordController,
                              label: "Password",
                              validator: (value) {
                                // TODO: password validator
                              },
                              context: context,
                              prefix: Icons.lock_outline),
                        ),
                        SizedBox(
                          height: responsiveScreen.height * .02,
                        ),
                        GestureDetector(
                          onTap: () {
                            // TODO: back-end for reset password
                            print("Hi");
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(left: 40.0),
                            child: Align(
                              alignment: AlignmentDirectional.centerStart,
                              child: Text("Forget password?",
                                  style: TextStyle(color: dark, fontSize: 12)),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: responsiveScreen.height * .06,
                        ),
                        Container(
                          height: responsiveScreen.height * .08,
                          width: responsiveScreen.width * .8,
                          child: ElevatedButton(
                            onPressed: () async {
                              // TODO: email and password validator to sign in
                              await LoginAndSignupCubit.get(context)
                                  .loginButton(
                                      email: emailController.text,
                                      password: passwordController.text)
                                  .then((value) {
                                CacheHelper.saveData(key: "loggedIn", value: true);

                                Navigator.of(context).pushNamed("/");
                                  }
                              );


                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.transparent,
                              onSurface: Colors.transparent,
                              shadowColor: Colors.transparent,
                            ),
                            child: Text("Sign in",
                                style: TextStyle(
                                    fontSize: 24,
                                    fontFamily: "Comfortaa",
                                    fontWeight: FontWeight.w800)),
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            gradient: gradientButton(),
                          ),
                        ),
                        SizedBox(
                          height: responsiveScreen.height * .01,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Don't have an account?",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pushNamed("/signup");
                              },
                              child: Text(
                                "Sign up",
                                style: TextStyle(
                                  color: Colors.orange[200],
                                  fontSize: 16,
                                ),
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Flexible(
              flex: 1,
              child: WaveWidget(
                config: CustomConfig(
                  colors: [
                    Colors.red[400]!,
                    Colors.yellow[400]!,
                    Colors.purple[400]!,
                    Color(0xff1c272c),
                  ],
                  durations: [18000, 8000, 5000, 12000],
                  heightPercentages: [0.20, 0.21, 0.24, 0.30],
                ),
                size: Size(double.infinity, responsiveScreen.height * .30),
                waveAmplitude: 0,
              ),
            ),
          ],
        ));
  }
}
