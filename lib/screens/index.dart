import 'package:dev_community/screens/notification_screen.dart';
import 'package:dev_community/screens/profile_screen.dart';
import 'package:dev_community/screens/party_screen.dart';
import 'package:dev_community/screens/qna_screen.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    const PartyScreen(),
    const QnAScreen(),
    const NotificationScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          selectedItemColor: CustomColor.mint,
          elevation: 8.0,
        ),
      ),
    );
  }
}
