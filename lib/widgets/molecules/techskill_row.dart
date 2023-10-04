import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class TechSkillRow extends StatelessWidget {
  final List<String> techSkill;

  const TechSkillRow({super.key, required this.techSkill});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        techSkill.length,
        (index) {
          return Container(
            margin: const EdgeInsets.only(right: 20),
            child: SvgPicture.asset(
              "assets/svgs/skills/${techSkill[index]}.svg",
              width: 25,
              height: 25,
            ),
          );
        },
      ),
    );
  }
}
