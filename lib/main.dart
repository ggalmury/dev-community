import 'package:dev_community/apis/auth_api.dart';
import 'package:dev_community/apis/dio/dio_provider.dart';
import 'package:dev_community/apis/party_api.dart';
import 'package:dev_community/bloc/global/user_account_bloc.dart';
import 'package:dev_community/bloc/screen/party/party_article_bloc.dart';
import 'package:dev_community/bloc/screen/party/search_filter_bloc.dart';
import 'package:dev_community/repositories/key_value_store.dart';
import 'package:dev_community/screens/index.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/customs/custom_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kakao_flutter_sdk/kakao_flutter_sdk_template.dart';

void main() async {
  await dotenv.load();
  KakaoSdk.init(nativeAppKey: dotenv.env["KAKAO_NATIVE_KEY"]);

  await KeyValueStore().initialize();
  DioProvider().initialize();

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
        RepositoryProvider(
          create: (context) => AuthApi(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => UserAccountBloc(
              authApi: context.read<AuthApi>(),
            ),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => SearchFilterBloc(),
            lazy: false,
          ),
          BlocProvider(
            create: (context) => PartyArticleBloc(
              partyApi: context.read<PartyApi>(),
            ),
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
            ),
          ),
          home: const Index(),
        ),
      ),
    );
  }
}
