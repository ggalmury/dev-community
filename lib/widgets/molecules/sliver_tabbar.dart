import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class SliverTabBar extends SliverPersistentHeaderDelegate {
  final List<String> tabs;
  final double height = 40;

  SliverTabBar({required this.tabs});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      height: height,
      child: TabBar(
        indicator: const BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: CustomColor.purple,
              width: 2.0,
            ),
          ),
        ),
        labelColor: Colors.black,
        labelStyle: const TextStyle(
          fontWeight: FontWeight.bold,
        ),
        tabs: tabs.map((e) {
          return Tab(text: e);
        }).toList(),
      ),
    );
  }

  @override
  double get maxExtent => height;

  @override
  double get minExtent => height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
