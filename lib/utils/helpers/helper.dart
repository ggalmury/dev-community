class Helper {
  List<T> toggleListElement<T>(List<T> list, dynamic data) {
    List<T> copiedList = List.from(list);

    list.contains(data) ? copiedList.remove(data) : copiedList.add(data);

    return copiedList;
  }
}
