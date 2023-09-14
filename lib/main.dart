import 'package:flutter/material.dart';
import 'package:mnctest/Auth/forgotPassword.dart';
import 'package:mnctest/Auth/login.dart';
import 'package:mnctest/Auth/signup.dart';
import 'package:mnctest/liveness.dart';
import 'package:mnctest/screens/AttendanceHistory.dart';
import 'package:mnctest/screens/animatetextfiled.dart';
import 'package:mnctest/screens/biometric.dart';
import 'package:mnctest/screens/home.dart';
import 'package:mnctest/screens/leaves.dart';

import 'package:mnctest/services/Api/apiClient.dart';
import 'package:mnctest/widgets/Images/imageCache.dart';
import 'package:provider/provider.dart';

void main() {
  MyWidgetsBinding();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider(create: (_) => ApiClientProvider())],
        child: MaterialApp(
          initialRoute: '/',
          routes: {
            '/': (context) => LoginScreen(),
            '/home': (context) => const HomePage(),
            '/signup': (context) => const SignUpScreen()
          },
          debugShowCheckedModeBanner: false,
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
        )
        // home: LoginScreen()),
        );
  }
}
