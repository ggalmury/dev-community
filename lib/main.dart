import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/bloc/screen/party/party_article_bloc.dart';
import 'package:dev_community/bloc/screen/party/search_filter_bloc.dart';
import 'package:dev_community/screens/index.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
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
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => PartyApi(),
        ),
      ],
      child: MultiBlocProvider(
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
          localizationsDelegates: const [
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('ko'),
          ],
          theme: ThemeData(
            scaffoldBackgroundColor: CustomColor.whiteGrey1,
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
            ),
          ),
          home: const Index(),
        ),
      ),
    );
  }
}
