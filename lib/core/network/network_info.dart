/// Abstraction over device connectivity so the data layer can check for a
/// network connection without depending on a concrete plugin.
abstract class NetworkInfo {
  Future<bool> get isConnected;
}
