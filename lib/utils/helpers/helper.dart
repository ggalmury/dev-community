class Helper {
  static List<T> toggleListElement<T>(List<T> list, dynamic data) {
    List<T> copiedList = List.from(list);

    list.contains(data) ? copiedList.remove(data) : copiedList.add(data);

    return copiedList;
  }

  static List<T> deduplicatedList<T>(List<T> target, List<T> list) {
    Set<String> nextPositionSet = Set.from(target);
    Set<String> curPosiitonSet = Set.from(list);

    return nextPositionSet.difference(curPosiitonSet).toList() as List<T>;
  }

  static int dayDifference(DateTime start, DateTime end) {
    Duration difference = end.difference(start);
    return difference.inDays;
  }
}
