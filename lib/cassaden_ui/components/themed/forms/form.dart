// lib/components/form/form.dart
import 'package:jaspr/jaspr.dart';

part 'form_field_state.dart';
part 'form_field.dart';

/// A [Form] groups together multiple form fields.
///
/// Each form field can be validated, saved, and reset.
///
/// To interact with the [Form], provide a [GlobalKey] to its constructor.
/// This key can then be used to access the [FormState] and call methods
/// like [FormState.validate], [FormState.save], or [FormState.reset].
///
/// Example:
/// ```dart
/// class MyForm extends StatefulComponent {
///   @override
///   State<MyForm> createState() => _MyFormState();
/// }
///
/// class _MyFormState extends State<MyForm> {
///   final _formKey = GlobalKey<FormState>();
///
///   @override
///   Iterable<Component> build(BuildContext context) {
///     return Form(
///       key: _formKey,
///       child: Column(children: [
///         FormField<String>(
///           builder: (field) => Input(
///             type: InputType.text,
///             value: field.value,
///             onInput: (e) => field.didChange(e.value),
///             placeholder: 'Enter text',
///           ),
///           validator: (value) {
///             if (value == null || value.isEmpty) {
///               return 'Please enter some text';
///             }
///             return null;
///           },
///           onSaved: (value) => print('Text saved: $value'),
///         ),
///         // Add more FormFields
///         button(
///           events: {
///             'click': (e) {
///               if (_formKey.currentState?.validate() == true) {
///                 _formKey.currentState?.save();
///                 print('Form is valid and saved!');
///               } else {
///                 print('Form is invalid.');
///               }
///             },
///           },
///           children: [text('Submit')]
///         )
///       ]),
///     );
///   }
/// }
/// ```
class Form extends StatefulComponent {
  /// A callback that is called when the form's fields change value.
  final VoidCallback? onChanged;

  /// A callback that is called when the form is submitted (e.g., by pressing Enter in a text field).
  final VoidCallback? onSubmitted;

  /// The widget below this widget in the tree.
  final Component child;

  const Form({
    required super.key, // GlobalKey<FormState> is required here
    this.onChanged,
    this.onSubmitted,
    required this.child,
  });

  @override
  State<Form> createState() => FormState();

  /// Obtains the [FormState] from the nearest [Form] ancestor.
  ///
  /// This method is typically used by [FormField] widgets to interact with
  /// their parent [Form].
  static FormState? of(BuildContext context) {
    return context.findAncestorStateOfType<FormState>();
  }
}

/// The state associated with a [Form] widget.
///
/// This class provides methods to control the form's behavior, such as
/// [validate], [save], and [reset].
class FormState extends State<Form> {
  final _fields =
      <FormFieldState<dynamic>>{}; // Using HashSet for efficient add/remove

  /// Registers a [FormFieldState] with this [Form].
  ///
  /// This method is called automatically by [FormField] widgets when they are initialized.
  void registerField(FormFieldState<dynamic> field) {
    _fields.add(field);
  }

  /// Unregisters a [FormFieldState] from this [Form].
  ///
  /// This method is called automatically by [FormField] widgets when they are disposed.
  void unregisterField(FormFieldState<dynamic> field) {
    _fields.remove(field);
  }

  /// Validates all the [FormField]s that are descendants of this [Form].
  ///
  /// Returns `true` if all fields are valid, `false` otherwise.
  bool validate() {
    bool isValid = true;
    for (final field in _fields) {
      if (!field.validate()) {
        isValid = false;
      }
    }
    return isValid;
  }

  /// Calls the [FormField.onSaved] callback for each [FormField] descendant.
  void save() {
    for (final field in _fields) {
      field.save();
    }
  }

  /// Resets all the [FormField]s that are descendants of this [Form] to their
  /// [FormField.initialValue].
  void reset() {
    for (final field in _fields) {
      field.reset();
    }
  }

  /// Called when a field's value changes.
  /// This can be used to trigger the form's [onChanged] callback.
  void _onFieldChanged() {
    component.onChanged?.call();
  }

  @override
  Iterable<Component> build(BuildContext context) {
    // The Form component itself doesn't render anything special beyond its child.
    // Its purpose is to provide the FormState to its descendants.
    return [component.child];
  }
}
