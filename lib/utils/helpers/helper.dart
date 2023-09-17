import 'package:dev_community/utils/helpers/pair.dart';
import 'package:flutter/material.dart';

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

  static String dateToIsoString(DateTime s) {
    return s.toUtc().toIso8601String();
  }

  static int dayDifference(DateTime s, DateTime e) {
    Duration diff = e.difference(s);
    return diff.inDays;
  }

  static String isOverdue(DateTime t) {
    DateTime n = DateTime.now();

    return t.isBefore(n)
        ? "마감"
        : "마감 D-${Helper.dayDifference(DateTime.now(), t)}";
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
}
