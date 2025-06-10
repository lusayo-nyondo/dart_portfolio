import 'package:jaspr/jaspr.dart';

import 'components.dart';

class SharedState extends ChangeNotifier {
  final ThemeData themeData;

  SharedState({required this.themeData});
}
