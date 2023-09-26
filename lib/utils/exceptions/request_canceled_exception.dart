class RequestCanceledException implements Exception {
  final String? message;

  RequestCanceledException({this.message});

  @override
  String toString() => message ?? "RequestCanceledException";
}
