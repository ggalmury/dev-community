import 'package:dev_community/screens/index.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          inputDecorationTheme: const InputDecorationTheme(
            border: InputBorder.none,
          ),
          textButtonTheme: TextButtonThemeData(
            style: CustomStyle.defaultButtonStyle,
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: CustomStyle.defaultButtonStyle,
          ),
          appBarTheme: const AppBarTheme(
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            elevation: 0,
            backgroundColor: Colors.transparent,
            foregroundColor: Colors.black,
          )),
      home: const Index(),
    );
  }
}
