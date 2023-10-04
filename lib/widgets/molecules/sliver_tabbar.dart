import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class SliverTabBar extends SliverPersistentHeaderDelegate {
  final List<String> tabs;

  SliverTabBar({required this.tabs});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        color: Colors.white,
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
      ),
    );
  }

  @override
  double get maxExtent => 60.0;

  @override
  double get minExtent => 60.0;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
