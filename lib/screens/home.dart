import 'package:dev_community/bloc/global/user_account_bloc.dart';
import 'package:dev_community/screens/index.dart';
import 'package:dev_community/screens/notifiy.dart';
import 'package:dev_community/screens/profile.dart';
import 'package:dev_community/screens/party.dart';
import 'package:dev_community/screens/qna.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:dev_community/utils/helpers/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const Party(),
    const QnA(),
    const Notify(),
    const Profile(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserAccountBloc, UserAccountState>(
      listener: (context, state) {
        if (state.isLoggedIn == false) {
          Helper.pushRemoveScreen(context, const Index());
        }
      },
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: _screens,
        ),
        bottomNavigationBar: Theme(
          data: ThemeData(
            splashFactory: NoSplash.splashFactory,
            splashColor: Colors.transparent,
            highlightColor: Colors.transparent,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.code),
                label: '파티찾기',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.question_answer_rounded),
                label: 'Q&A',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.notifications_active),
                label: '알림',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: '내 프로필',
              ),
            ],
            type: BottomNavigationBarType.fixed,
            selectedItemColor: CustomColor.purple,
            elevation: 8.0,
          ),
        ),
      ),
    );
  }
}
