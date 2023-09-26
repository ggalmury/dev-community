import 'package:dev_community/bloc/global/user_account_bloc.dart';
import 'package:dev_community/models/token.dart';
import 'package:dev_community/repositories/key_value_store.dart';
import 'package:dev_community/screens/home.dart';
import 'package:dev_community/utils/enums/global.dart';
import 'package:dev_community/utils/exceptions/authentication_exception.dart';
import 'package:dev_community/utils/exceptions/not_found_exception.dart';
import 'package:dev_community/utils/exceptions/request_canceled_exception.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/utils/logger.dart';
import 'package:dev_community/widgets/atoms/buttons/login_btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  Future<void> _kakaoLogin() async {
    context.read<UserAccountBloc>().add(KakaoLoginEvent());
  }

  void _logout() {
    context.read<UserAccountBloc>().add(LogoutEvent());
  }

  void _exceptionAlert(Exception e) {
    String title;

    if (e is RequestCanceledException) {
      title = "카카오 로그인 요청이 취소되었습니다.";
    } else if (e is NotFoundException) {
      title = "인증 정보가 존재하지 않습니다.";
    } else if (e is AuthenticationException) {
      title = "인증이 만료되었습니다.";
    } else {
      title = "네트워크 에러가 발생했습니다.";
    }

    ScreenHelper.alertDialogHandler(
      context,
      title,
      callback: () =>
          context.read<UserAccountBloc>().add(SubmitAccountErrorEvent()),
    );
  }

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Token? token = context.read<KeyValueStore>().getToken();
      loggerNoStack.i(
          "accessToken: ${token?.accessToken}, refreshToken: ${token?.refreshToken}");

      if (token != null) {
        context.read<UserAccountBloc>().add(AutoLoginEvent());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocListener<UserAccountBloc, UserAccountState>(
          listener: (context, state) {
            if (state.exception != null) _exceptionAlert(state.exception!);
            if (state.isLoggedIn) {
              Helper.pushRemoveScreen(context, const Home());
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                const SizedBox(
                  height: 450,
                  child: Center(
                    child: Text(
                      "DevWithMe",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginBtn(
                        loginType: LoginType.email,
                        onPressed: () {},
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      LoginBtn(
                        loginType: LoginType.kakao,
                        onPressed: _kakaoLogin,
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      LoginBtn(
                        loginType: LoginType.google,
                        onPressed: _logout,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
