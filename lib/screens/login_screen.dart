import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unilift/bloc/auth_bloc.dart';
import 'package:unilift/bloc/auth_event.dart';
import 'package:unilift/bloc/auth_state.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/screens/dashboard.dart';
import 'package:unilift/screens/signup_screen.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/button/customTextButton.dart';
import 'package:unilift/widgets/text/customText.dart';
import 'package:unilift/widgets/textfield/customTextfield.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool val = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            Navigator.pushReplacement(
                context, MaterialPageRoute(builder: (context) => Dashboard()));
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        child: Center(
          child: Container(
            color: ClrUtils.primary,
            width: SizeCons.getWidth(context),
            height: SizeCons.getHeight(context),
            child: Stack(
              children: [
                Positioned(
                  top: 0,
                  child: Container(
                      padding: EdgeInsets.fromLTRB(
                          50, 130, 50, SizeCons.getWidth(context) * 0.22),
                      width: SizeCons.getWidth(context),
                      height: SizeCons.getHeight(context) * 0.5,
                      color: ClrUtils.secondary,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                text: "UniLift",
                                color: ClrUtils.primary,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 5.0,
                                fontSize: 40,
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: SizeCons.getWidth(context),
                    height: SizeCons.getHeight(context) * 0.5,
                    color: ClrUtils.background,
                  ),
                ),
                Positioned(
                  top: SizeCons.getHeight(context) * 0.3,
                  left: SizeCons.getWidth(context) * 0.05,
                  child: Container(
                    width: SizeCons.getWidth(context) * 0.9,
                    height: SizeCons.getHeight(context) * 0.5,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ClrUtils.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "Sign in to your Account",
                          fontSize: 32,
                          fontWeight: FontWeight.w700,
                          color: ClrUtils.textPrimary,
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 10),
                        CustomText(
                          text: "Enter your email and password to login",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: ClrUtils.textTertiary,
                        ),
                        SizedBox(height: 10),
                        CustomTextField(
                          controller: emailController,
                          hintText: "abc@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "abc123",
                          isPassword: true,
                          maxline: 1,
                        ),
                        SizedBox(height: 10),
                        CustomButton(
                          text: "Login",
                          onPressed: () {
                            context.read<AuthBloc>().add(
                                  LogInRequested(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                );
                          },
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Don't have an account?",
                              color: ClrUtils.textSecondary,
                              fontSize: 12,
                            ),
                            CustomTextButton(
                              text: "Sign Up",
                              onpressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUpScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
