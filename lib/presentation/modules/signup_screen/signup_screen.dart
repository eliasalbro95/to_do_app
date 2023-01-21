import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sign_button/sign_button.dart';
import 'package:to_do_app/data/models/user/user_model.dart';
import 'package:to_do_app/logic/cubit/login_signup/login_and_signup_cubit.dart';
import 'package:to_do_app/shared/components/components.dart';
import 'package:to_do_app/shared/network/local/shared_preferences.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../../shared/components/responsive.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

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
                    "Create new account",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(
                    height: responsiveScreen.height * .02,
                  ),
                  Expanded(
                    child: Form(
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: defaultTextField(
                                  controller: nameController,
                                  label: "Name",
                                  validator: (value) {
                                    // TODO: name validator & RegEx
                                  },
                                  context: context,
                                  prefix: Icons.person_outline_outlined),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: defaultTextField(
                                  controller: phoneController,
                                  label: "Phone number",
                                  validator: (value) {
                                    // TODO: Number validator & RegEx
                                  },
                                  context: context,
                                  prefix: Icons.phone_outlined),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: defaultTextField(
                                  controller: emailController,
                                  label: "Email address",
                                  validator: (value) {
                                    // TODO: Email validator & RegEx
                                  },
                                  context: context,
                                  prefix: Icons.email_outlined),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: defaultTextField(
                                  controller: passwordController,
                                  label: "Password",
                                  validator: (value) {
                                    // TODO: Password validator & RegEx
                                  },
                                  context: context,
                                  prefix: Icons.lock_outline),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .02,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 30.0),
                              child: defaultTextField(
                                  controller: confirmPasswordController,
                                  label: "Confirm password",
                                  validator: (value) {
                                    // TODO: confirm password validator & RegEx
                                  },
                                  context: context,
                                  prefix: Icons.lock_outline),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .03,
                            ),
                            BlocConsumer<LoginAndSignupCubit,
                                LoginAndSignupState>(
                              listener: (context, state) {},
                              builder: (context, state) {
                                return Container(
                                  height: responsiveScreen.height * .08,
                                  width: responsiveScreen.width * .8,
                                  child: ElevatedButton(
                                    onPressed: () async {
                                      if (passwordController.text ==
                                          confirmPasswordController.text) {
                                        String signupResult;
                                        await LoginAndSignupCubit.get(context)
                                            .signupButton(
                                                name: nameController.text,
                                                phoneNumber:
                                                    phoneController.text,
                                                email: emailController.text,
                                                password:
                                                    passwordController.text)
                                            .then((value) {
                                              CacheHelper.saveData(key: "loggedIn", value: true);
                                              Navigator.of(context).pushNamed("/");
                                        });
                                      }
                                      else{
                                        print("password doesn't match");
                                      }

                                      // TODO: validate and Store data in firebase and sign in
                                      // Navigator.of(context).pushNamed("/");
                                    },
                                    child: Text("Sign up",
                                        style: TextStyle(
                                            fontSize: 24,
                                            fontFamily: "Comfortaa",
                                            fontWeight: FontWeight.w800)),
                                    style: ElevatedButton.styleFrom(
                                      primary: Colors.transparent,
                                      onSurface: Colors.transparent,
                                      shadowColor: Colors.transparent,
                                    ),
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    gradient:gradientButton(),
                                  ),
                                );
                              },
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .03,
                            ),
                            Text(
                              "Or create account using",
                              style: TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            SizedBox(
                              height: responsiveScreen.height * .025,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SignInButton(
                                  buttonType: ButtonType.google,
                                  btnColor: Colors.white,
                                  onPressed: () {
                                    // TODO: Sign in with firebase google
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
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
