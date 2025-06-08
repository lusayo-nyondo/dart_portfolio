/// Mimics Flutter's [IconData] class for Material Icons.
///
/// This class holds the name of the icon (e.g., 'home', 'settings')
/// which corresponds to the ligature used by the Material Icons font.
// ignore_for_file: constant_identifier_names

class IconData {
  /// The icon name (e.g., 'home', 'settings', 'add').
  final String name;

  const IconData(this.name);
}

// A collection of common Material Icons, mimicking Flutter's [Icons] class.
class Icons {
  Icons._(); // Private constructor to prevent instantiation

  static const IconData add = IconData('add');
  static const IconData menu = IconData('menu');
  static const IconData settings = IconData('settings');
  static const IconData home = IconData('home');
  static const IconData favorite = IconData('favorite');
  static const IconData search = IconData('search');
  static const IconData delete = IconData('delete');
  static const IconData close = IconData('close');
  static const IconData arrow_back = IconData('arrow_back');
  static const IconData check = IconData('check');
  static const IconData email = IconData('email');
  static const IconData person = IconData('person');
  static const IconData camera_alt = IconData('camera_alt');
  static const IconData build = IconData('build');
  static const IconData help = IconData('help');
  static const IconData info = IconData('info');
  static const IconData warning = IconData('warning');
  static const IconData shopping_cart = IconData('shopping_cart');
  static const IconData star = IconData('star');
  static const IconData star_border = IconData('star_border');
  static const IconData phone = IconData('phone');
}
