import 'package:dev_community/utils/helpers/pair.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

class Helper {
  static List<T> toggleListElement<T>(List<T> l, dynamic d) {
    List<T> cl = List.from(l);

    l.contains(d) ? cl.remove(d) : cl.add(d);

    return cl;
  }

  static List<T> deduplicatedList<T>(List<T> t, List<T> l) {
    Set<String> nextPos = Set.from(t);
    Set<String> curPos = Set.from(l);

    return nextPos.difference(curPos).toList() as List<T>;
  }

  static Map<K, V> pairListToMap<K, V>(List<Pair> pl) {
    Map<K, V> map = {};

    for (Pair p in pl) {
      map[p.k] = p.v;
    }

    return map;
  }

  static String formattedDate(DateTime d) {
    return DateFormat("yyyy-MM-dd").format(d);
  }

  static String dateToIsoString(DateTime d) {
    return d.toUtc().toIso8601String();
  }

  static int dayDifference(DateTime s, DateTime e) {
    Duration diff = e.difference(s);
    return diff.inDays;
  }

  static String timePassage(DateTime targetDate) {
    final now = DateTime.now();
    final difference = now.difference(targetDate);

    if (difference.inDays == 0) {
      return '오늘';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}일 전';
    } else if (difference.inDays < 30) {
      final weeks = difference.inDays ~/ 7;
      return '$weeks주 전';
    } else if (difference.inDays < 365) {
      final months =
          now.month - targetDate.month + 12 * (now.year - targetDate.year);
      return '$months개월 전';
    } else {
      final years = now.year - targetDate.year;
      return '$years년 전';
    }
  }

  static bool isOverdue(DateTime t) {
    DateTime n = DateTime.now();

    return t.isBefore(n) ? true : false;
  }

  static void pushScreen(BuildContext context, Widget s) {
    Navigator.push(
        context, MaterialPageRoute(builder: (BuildContext context) => s));
  }

  static void pushRemoveScreen(BuildContext context, Widget s) {
    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (BuildContext context) => s),
        ((route) => false));
  }

  static Widget svgFactory(String path, double size,
      {ColorFilter? colorFilter}) {
    return SvgPicture.asset(
      path,
      width: size,
      height: size,
      colorFilter: colorFilter,
    );
  }
}
