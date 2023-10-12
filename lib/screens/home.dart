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

  Widget _navigationIcon(String path, int idx) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5),
      child: Helper.svgFactory(path, 20,
          colorFilter: _currentIndex == idx
              ? const ColorFilter.mode(CustomColor.purple, BlendMode.srcIn)
              : null),
    );
  }

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
          child: Container(
            decoration: const BoxDecoration(
                border: Border(
              top: BorderSide(color: CustomColor.greyLight, width: 2),
            )),
            child: BottomNavigationBar(
              currentIndex: _currentIndex,
              backgroundColor: Colors.white,
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              items: [
                BottomNavigationBarItem(
                  icon: _navigationIcon("assets/svgs/commons/console.svg", 0),
                  label: '파티찾기',
                ),
                BottomNavigationBarItem(
                  icon: _navigationIcon("assets/svgs/commons/bubbles.svg", 1),
                  label: 'Q&A',
                ),
                BottomNavigationBarItem(
                  icon: _navigationIcon("assets/svgs/commons/clock.svg", 2),
                  label: '알림',
                ),
                BottomNavigationBarItem(
                  icon: _navigationIcon("assets/svgs/commons/user.svg", 3),
                  label: '내 프로필',
                ),
              ],
              type: BottomNavigationBarType.fixed,
              selectedItemColor: CustomColor.purple,
              selectedLabelStyle: const TextStyle(fontWeight: FontWeight.bold),
              unselectedLabelStyle:
                  const TextStyle(fontWeight: FontWeight.bold),
              elevation: 8.0,
            ),
          ),
        ),
      ),
    );
  }
}
