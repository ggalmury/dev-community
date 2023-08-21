import 'package:dev_community/bloc/screen/project/party_article_bloc.dart';
import 'package:dev_community/bloc/screen/project/search_filter_bloc.dart';
import 'package:dev_community/screens/index.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

var logger = Logger(
  printer: PrettyPrinter(lineLength: 60, colors: true),
);

var loggerNoStack = Logger(
  printer: PrettyPrinter(lineLength: 60, methodCount: 0),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SearchFilterBloc(),
          lazy: false,
        ),
        BlocProvider(
          create: (context) => PartyArticleBloc(),
          lazy: false,
        ),
      ],
      child: MaterialApp(
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
              backgroundColor: Colors.white,
              foregroundColor: Colors.black,
            )),
        home: const Index(),
      ),
    );
  }
}
