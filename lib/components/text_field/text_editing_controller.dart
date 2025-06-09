part of 'text_field.dart';

/// A controller for an editable text field.
///
/// Whenever the user modifies a text field with an associated
/// [TextEditingController], the text field updates the controller's value.
/// Listeners are notified.
///
/// This controller can also be used to programmatically set or get the
/// text in the text field.
class TextEditingController extends ChangeNotifier {
  TextEditingController({String? text}) : _text = text ?? '';

  String _text;

  /// The current text being edited.
  String get text => _text;
  set text(String newText) {
    if (_text == newText) {
      return; // No change, no notification
    }
    _text = newText;
    notifyListeners();
  }

  /// Clears the text field.
  void clear() {
    text = '';
  }

  /// Sets the text field's value to the given string.
  void setText(String newText) {
    text = newText;
  }
}
