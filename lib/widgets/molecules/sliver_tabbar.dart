import 'package:dev_community/utils/customs/custom_color.dart';
import 'package:flutter/material.dart';

class SliverTabBar extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Align(
      child: Container(
        color: Colors.white,
        child: const TabBar(
          indicator: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: CustomColor.purple,
                width: 2.0,
              ),
            ),
          ),
          labelColor: Colors.black,
          labelStyle: TextStyle(
            fontWeight: FontWeight.bold,
          ),
          tabs: [
            Tab(text: '정보'),
            Tab(text: '댓글'),
          ],
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
