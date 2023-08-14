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
      margin: const EdgeInsets.only(top: 20),
      color: Colors.white,
      child: const Center(
        child: Text("article"),
      ),
    );
  }
}
