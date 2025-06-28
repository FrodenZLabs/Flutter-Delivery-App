class RouterException implements Exception {
  final String message;
  RouterException(this.message);
}

class ServerException implements Exception {}

class CacheException implements Exception {}
