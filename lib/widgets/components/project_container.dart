import 'package:flutter/material.dart';

class ProjectContainer extends StatefulWidget {
  const ProjectContainer({super.key});

  @override
  State<ProjectContainer> createState() => _ProjectContainerState();
}

class _ProjectContainerState extends State<ProjectContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      margin: const EdgeInsets.symmetric(vertical: 10),
      color: Colors.red,
      child: const Text("alac"),
    );
  }
}
