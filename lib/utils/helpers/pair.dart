class Pair<K, V> {
  K k;
  V v;

  Pair({required this.k, required this.v});

  @override
  String toString() {
    return "(${this.k}, ${this.v})";
  }
}
