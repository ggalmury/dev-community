import 'package:flutter/material.dart';

class QnA extends StatefulWidget {
  const QnA({super.key});

  @override
  State<QnA> createState() => _QnAState();
}

class _QnAState extends State<QnA> {
  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Center(
        child: Text('QnA screen'),
      ),
    );
  }
}
