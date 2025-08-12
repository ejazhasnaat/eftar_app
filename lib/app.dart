import 'package:flutter/material.dart';
import 'features/auth/presentation/screens/sign_in_screen.dart';
import 'features/auth/presentation/screens/sign_up_screen.dart';

class EftarApp extends StatelessWidget {
  const EftarApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EFTAR App',
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      initialRoute: SignInScreen.routeName,
      routes: {
        SignInScreen.routeName: (_) => const SignInScreen(),
        SignUpScreen.routeName: (_) => const SignUpScreen(),
      },
    );
  }
}
