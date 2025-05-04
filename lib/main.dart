import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:unilift/bloc/auth_bloc.dart';
import 'package:unilift/bloc/auth_event.dart';
import 'package:unilift/bloc/auth_state.dart';
import 'package:unilift/mainlayout.dart';
import 'package:unilift/repositories/auth_repository.dart';
import 'package:unilift/screens/createCarpoolScreens/car_details_screen.dart';
import 'package:unilift/screens/createCarpoolScreens/carpool_details_screen.dart';
import 'package:unilift/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:unilift/screens/signup_screen.dart';
import 'firebase_options.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp(authRepository: AuthRepository()));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: authRepository)..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'UniLift',
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            return const MainLayout();
            // return const CarDetailScreen();
            //   if (state is AuthAuthenticated) {
            //     return const SignUpScreen(); // Navigate to home if authenticated
            //   }
            //else {
            //   return const SignUpScreen(); // Otherwise, show login screen
            // }
          },
        ),
        // routes: {
        //   '/signup': (context) => const SignUpScreen(),
        //   '/login': (context) => const LogInScreen(),
        //   '/home': (context) => const Dashboard(),
        // },
      ),
    );
  }
}
