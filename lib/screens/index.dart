import 'package:dev_community/bloc/screen/project/project_search_option_bloc.dart';
import 'package:dev_community/screens/profile.dart';
import 'package:dev_community/screens/project.dart';
import 'package:dev_community/screens/qna.dart';
import 'package:dev_community/screens/study.dart';
import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Index extends StatefulWidget {
  const Index({super.key});

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    BlocProvider(
        create: (context) => ProjectSearchOptionBloc(), child: const Project()),
    const Study(),
    const QnA(),
    const Profile(),
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
              label: '프로젝트',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.group),
              label: '스터디',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.question_answer_rounded),
              label: 'Q&A',
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
