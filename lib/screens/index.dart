import 'package:dev_community/bloc/global/user_account_bloc.dart';
import 'package:dev_community/screens/home.dart';
import 'package:dev_community/utils/enums/widget_property.dart';
import 'package:dev_community/utils/exceptions/request_canceled_exception.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:dev_community/utils/helpers/screen_helper.dart';
import 'package:dev_community/widgets/atoms/buttons/primary_btn.dart';
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
    } else {
      title = "네트워크 에러가 발생했습니다.";
    }

    ScreenHelper.alertDialogHandler(
      context,
      title,
      onPressed: () =>
          context.read<UserAccountBloc>().add(SubmitAccountErrorEvent()),
    );
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
                BlocBuilder<UserAccountBloc, UserAccountState>(
                  builder: (context, state) {
                    return Column(
                      children: [
                        Text(state.userAccount.uuid),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(state.isLoggedIn.toString()),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(state.exception.toString()),
                      ],
                    );
                  },
                ),
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    PrimaryBtn(
                      label: "카카오로 로그인",
                      onPressed: _kakaoLogin,
                      widgetSize: WidgetSize.big,
                      widgetColor: WidgetColor.mint,
                      width: double.infinity,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    PrimaryBtn(
                      label: "로그아웃",
                      onPressed: _logout,
                      widgetSize: WidgetSize.big,
                      widgetColor: WidgetColor.mint,
                      width: double.infinity,
                    ),
                  ],
                ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
