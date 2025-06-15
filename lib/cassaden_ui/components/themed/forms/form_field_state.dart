part of 'form.dart';

/// The state for a single [FormField].
///
/// This is the class that builders passed to the [FormField.builder] callback
/// typically interact with.
abstract class FormFieldState<T> extends State<FormField<T>> {
  /// The current value of the field.
  T? get value;

  /// The current error text for the field.
  String? get errorText;

  /// Whether the field currently has a validation error.
  bool get hasError => errorText != null;

  /// Updates the value of the field.
  ///
  /// This should be called by the `builder` callback when the wrapped input
  /// widget's value changes (e.g., in an `onChange` handler).
  void didChange(T? newValue);

  /// Clears the field's value and resets its error state.
  void reset();

  /// Validates the field's current value.
  ///
  /// This method is typically called by the parent [Form] when its `validate`
  /// method is called.
  ///
  /// Returns `true` if the field is valid, `false` otherwise.
  bool validate();

  /// Calls the [FormField.onSaved] callback.
  ///
  /// This method is typically called by the parent [Form] when its `save`
  /// method is called.
  void save();
}
