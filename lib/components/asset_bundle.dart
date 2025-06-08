import 'dart:html' show window;
import 'dart:async'; // For Future

/// A simple asset bundle for Jaspr web applications.
///
/// This mimics Flutter's [rootBundle] for loading assets from the `assets/` directory.
/// Assets are expected to be served from the `/assets/` path relative to the web root.
class RootAssetBundle {
  RootAssetBundle._(); // Private constructor

  static final RootAssetBundle _instance = RootAssetBundle._();

  /// The singleton instance of [RootAssetBundle].
  static RootAssetBundle get instance => _instance;

  /// The base path for assets. Adjust if your assets are served from a different directory.
  static const String _basePath = 'assets/';

  /// Resolves an asset key to its full URL.
  ///
  /// Example: 'images/logo.png' resolves to '/assets/images/logo.png'
  String getAssetUrl(String key) {
    // Ensure the key doesn't start with a slash, and prepend the base path.
    final String cleanKey = key.startsWith('/') ? key.substring(1) : key;
    return '${_basePath}${cleanKey}';
  }

  /// Loads a string asset from the bundle.
  ///
  /// Example: `RootAssetBundle.instance.loadString('data/config.json')`
  Future<String> loadString(String key) async {
    final String url = getAssetUrl(key);
    try {
      final response = await window.fetch(url);
      if (!response.ok) {
        throw Exception(
            'Failed to load asset: $url (Status: ${response.status})');
      }
      return await response.text();
    } catch (e) {
      print('Error loading string asset "$url": $e');
      rethrow;
    }
  }

  // You can add more loading methods if needed, e.g., loadBytes, loadJson, etc.
  // For images, we often just need the URL.
}
