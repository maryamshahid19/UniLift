import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unilift/bloc/auth_bloc.dart';
import 'package:unilift/bloc/auth_event.dart';
import 'package:unilift/bloc/auth_state.dart';
import 'package:unilift/constants/color_constants.dart';
import 'package:unilift/constants/screensize_constants.dart';
import 'package:unilift/screens/login_screen.dart';
import 'package:unilift/widgets/button/customButton.dart';
import 'package:unilift/widgets/button/customTextButton.dart';
import 'package:unilift/widgets/text/customText.dart';
import 'package:unilift/widgets/textfield/customTextfield.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();

  bool val = true;
  String? selectedUniversity;
  final List<String> universities = [
    'FAST-NUCES',
    'NED',
    'NUST',
    'IBA',
    'Bahria University',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthAuthenticated) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("SignUp successful!")),
            );
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LogInScreen()),
            );
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(state.message), backgroundColor: Colors.red),
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
                        50, 90, 50, SizeCons.getWidth(context) * 0.7),
                    width: SizeCons.getWidth(context),
                    height: SizeCons.getHeight(context),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          ClrUtils.secondary,
                          ClrUtils.secondary,
                        ],
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
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
                  ),
                ),
                Positioned(
                  top: SizeCons.getHeight(context) * 0.2,
                  left: SizeCons.getWidth(context) * 0.05,
                  child: Container(
                    width: SizeCons.getWidth(context) * 0.9,
                    height: SizeCons.getHeight(context) * 0.6,
                    padding: EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: ClrUtils.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.center,
                          child: CustomText(
                            text: "Signup",
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: ClrUtils.textPrimary,
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CustomText(
                              text: "Already have an account?",
                              color: ClrUtils.textSecondary,
                              fontSize: 12,
                            ),
                            CustomTextButton(
                              text: "Log In",
                              onpressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LogInScreen(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        CustomText(
                          text: "Name",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: nameController,
                          hintText: "Maryam",
                          maxline: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Email",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: emailController,
                          hintText: "abc@gmail.com",
                          keyboardType: TextInputType.emailAddress,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "Password",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        CustomTextField(
                          controller: passwordController,
                          hintText: "abc123",
                          isPassword: true,
                          maxline: 1,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CustomText(
                          text: "University",
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                        ),
                        DropdownButtonFormField<String>(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: const Color.fromARGB(41, 255, 110, 97),
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 8),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          value: selectedUniversity,
                          hint: CustomText(
                              text: "Select your university",
                              color: ClrUtils.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.normal),
                          items: universities.map((university) {
                            return DropdownMenuItem<String>(
                              value: university,
                              child: Text(university),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              selectedUniversity = value!;
                            });
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                          text: "SignUp",
                          onPressed: () {
                            if (selectedUniversity == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                    content:
                                        Text("Please select your university")),
                              );
                              return;
                            }

                            context.read<AuthBloc>().add(
                                  SignUpRequested(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim(),
                                    name: nameController.text.trim(),
                                    university: selectedUniversity!,
                                  ),
                                );

                          
                          },
                        ),
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
