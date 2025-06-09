part of 'form.dart';

/// A callback that receives the current [FormFieldState] to build the input widget.
///
/// This allows [FormField] to be generic over the actual input widget type.
typedef FormFieldBuilder<T> = Component Function(FormFieldState<T> field);

/// A callback that validates the field's value.
///
/// Returns an error string if the value is invalid, otherwise returns `null`.
typedef FormFieldValidator<T> = String? Function(T? value);

/// A callback that is called when the form is saved.
typedef FormFieldSetter<T> = void Function(T? value);

/// A single form field.
///
/// This component wraps an input widget (built by the [builder] callback)
/// and provides functionality for validation, saving, and resetting.
///
/// [FormField]s typically reside within a [Form] widget.
class FormField<T> extends StatefulComponent {
  /// The initial value of the field.
  final T? initialValue;

  /// A callback that builds the input widget for this field.
  ///
  /// The [FormFieldState] is provided to the builder, allowing the input
  /// widget to interact with the field's state (e.g., `field.value`, `field.errorText`, `field.didChange`).
  final FormFieldBuilder<T> builder;

  /// A callback that validates the field's value.
  final FormFieldValidator<T>? validator;

  /// A callback that is called when the form is saved.
  final FormFieldSetter<T>? onSaved;

  const FormField({
    super.key,
    this.initialValue,
    required this.builder,
    this.validator,
    this.onSaved,
  });

  @override
  FormFieldState<T> createState() => _FormFieldState<T>();
}

/// The internal state for a [FormField].
///
/// This class implements the abstract [FormFieldState] and manages the field's
/// value, error text, and interaction with the parent [Form].
class _FormFieldState<T> extends FormFieldState<T> {
  FormState? _form; // Reference to the parent FormState
  T? _value;
  String? _errorText;

  @override
  T? get value => _value;

  @override
  String? get errorText => _errorText;

  @override
  void initState() {
    super.initState();
    _value = component.initialValue;
    // Find and register with the nearest Form ancestor
    _form = Form.of(context);
    _form?.registerField(this);
  }

  @override
  void dispose() {
    _form?.unregisterField(this); // Unregister when disposed
    super.dispose();
  }

  @override
  void didChange(T? newValue) {
    setState(() {
      _value = newValue;
      _errorText =
          null; // Clear error on change, it will be re-validated if validate() is called
    });
    _form?._onFieldChanged(); // Notify the parent form that a field changed
  }

  @override
  void reset() {
    setState(() {
      _value = component.initialValue;
      _errorText = null;
    });
  }

  @override
  bool validate() {
    if (component.validator == null) {
      setState(() {
        _errorText = null; // No validator, always valid
      });
      return true;
    }

    final String? result = component.validator!(_value);
    setState(() {
      _errorText = result;
    });
    return result == null;
  }

  @override
  void save() {
    component.onSaved?.call(_value);
  }

  @override
  Iterable<Component> build(BuildContext context) {
    // Delegate the actual rendering to the builder callback
    return [component.builder(this)];
  }
}
