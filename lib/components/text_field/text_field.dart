import 'package:jaspr/jaspr.dart';

import 'package:universal_web/web.dart';

import 'package:dart_portfolio/components/scaffold/scaffold.dart'
    show surfaceColorVariable;
import 'package:dart_portfolio/components/form/form.dart';

part 'text_editing_controller.dart';

/// The type of the HTML input element.
enum TextFieldType {
  text,
  password,
  email,
  number,
  tel,
  url,
  search,
}

/// A Material-Tailwind styled text input field that integrates with [Form] and [FormField].
///
/// This component provides a styled text input box, displays validation errors,
/// and works seamlessly within a [Form].
///
/// It mimics Flutter's [TextField] by supporting a [TextEditingController]
/// for programmatic text control.
class TextField extends StatefulComponent {
  /// Controls the text being edited.
  ///
  /// If null, this widget will create its own [TextEditingController].
  final TextEditingController? controller;

  /// The label text for the input field.
  final String? labelText;

  /// Text that appears in the input field when it's empty.
  /// (Material-Tailwind uses labelText for this, but providing placeholder for flexibility)
  final String? placeholder;

  /// Whether to obscure the text being edited (e.g., for password fields).
  final bool obscureText;

  /// The type of the HTML input element.
  final TextFieldType type;

  /// A callback that validates the field's value.
  final FormFieldValidator<String>? validator;

  /// A callback that is called when the form is saved.
  final FormFieldSetter<String>? onSaved;

  /// A callback that is called when the text being edited changes.
  final ValueChanged<String?>? onChanged;

  /// Whether the text field is read-only.
  final bool readOnly;

  /// Whether the text field is enabled.
  final bool enabled;

  const TextField({
    super.key,
    this.controller,
    this.labelText,
    this.placeholder,
    this.obscureText = false,
    this.type = TextFieldType.text,
    this.validator,
    this.onSaved,
    this.onChanged,
    this.readOnly = false,
    this.enabled = true,
  });

  @override
  State<TextField> createState() => _TextFieldState();
}

class _TextFieldState extends State<TextField> {
  late TextEditingController _controller;
  FormFieldState<String>?
      _formFieldState; // Reference to the parent FormFieldState

  @override
  void initState() {
    super.initState();
    _controller = component.controller ?? TextEditingController();
    _controller.addListener(_handleControllerChanged);
  }

  @override
  void didUpdateComponent(covariant TextField oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (component.controller != oldComponent.controller) {
      oldComponent.controller?.removeListener(_handleControllerChanged);
      _controller = component.controller ?? TextEditingController();
      _controller.addListener(_handleControllerChanged);
      // Ensure FormField's internal value is updated if controller changes
      _formFieldState?.didChange(_controller.text);
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_handleControllerChanged);
    // Only dispose the controller if it was created internally by this widget
    if (component.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _handleControllerChanged() {
    // Notify the FormField that the value has changed.
    // This is crucial for validation and saving via the Form.
    _formFieldState?.didChange(_controller.text);
    component.onChanged?.call(_controller.text);
  }

  // Helper to map TextFieldType to HTML InputType
  InputType _mapTextFieldTypeToInputType(TextFieldType type) {
    switch (type) {
      case TextFieldType.text:
        return InputType.text;
      case TextFieldType.password:
        return InputType.password;
      case TextFieldType.email:
        return InputType.email;
      case TextFieldType.number:
        return InputType.number;
      case TextFieldType.tel:
        return InputType.tel;
      case TextFieldType.url:
        return InputType.url;
      case TextFieldType.search:
        return InputType.search;
    }
  }

  // This is the builder function for the FormField
  Component _buildTextField(FormFieldState<String> field) {
    _formFieldState = field; // Keep a reference to the FormFieldState

    // Keep controller and FormField in sync, prioritize controller if present
    if (_controller.text != (field.value ?? '')) {
      // Avoid infinite loop if controller itself triggered didChange
      // Only update controller if the field value changed from an external source (e.g., Form.reset)
      _controller.setText(field.value ?? '');
    }

    final String baseInputClasses =
        'peer w-full bg-transparent placeholder:text-slate-400 text-slate-700 text-sm border border-slate-200 rounded-md px-3 py-2 transition duration-300 ease focus:outline-none focus:border-slate-400 hover:border-slate-300 shadow-sm focus:shadow';
    final String errorInputClasses =
        '!border-red-500 !border-t-red-500 focus:!border-red-500';
    final String baseLabelClasses =
        'absolute cursor-text pointer-events-none bg-inherit px-1 left-2.5 top-2.5 text-slate-400 text-sm transition-all transform origin-left peer-focus:-top-2 peer-focus:left-2.5 peer-focus:text-xs peer-focus:text-slate-400 peer-focus:scale-90';
    final String errorLabelClasses =
        '!text-red-500 peer-focus:!text-red-500 before:!border-red-500 after:!border-red-500 peer-focus:before:!border-t-red-500 peer-focus:before:!border-l-red-500 peer-focus:after:!border-t-red-500 peer-focus:after:!border-r-red-500';

    return div(
      classes:
          'relative h-11 w-full min-w-[200px]', // Material-Tailwind wrapper
      [
        input([],
            type: _mapTextFieldTypeToInputType(component.type),
            value: _controller.text, // Controlled by TextEditingController

            disabled: !component.enabled,
            classes: [
              baseInputClasses,
              if (field.hasError) errorInputClasses,
            ].join(' '),
            events: {
              'input': (Event e) {
                final inputText = (e.target as HTMLInputElement).value;
                _controller.text = inputText; // Update controller
                // _handleControllerChanged will then call field.didChange()
              },
            },
            attributes: {
              'placeholder': component.labelText != null
                  ? ' '
                  : (component.placeholder ?? ''),
              'read-only': component.readOnly.toString(),
              if (component.obscureText)
                'type':
                    'password', // Ensure password type if obscureText is true
              // if (component.labelText != null) 'placeholder': ' ', // Ensure space placeholder if label is present
            }),
        if (component.labelText != null)
          label(
            classes: [
              baseLabelClasses,
              if (field.hasError) errorLabelClasses,
            ].join(' '),
            styles: Styles(raw: {
              'background-color': 'var($surfaceColorVariable)',
            }),
            attributes: {
              'htmlFor':
                  'text-field-${field.hashCode}', // Unique ID for label connection
            },
            [text(component.labelText!)],
          ),
        if (field.hasError)
          p(
            classes: ['text-red-500', 'text-xs', 'mt-1', 'font-normal']
                .join(' '), // Tailwind for error message
            [text(field.errorText!)],
          ),
      ],
    );
  }

  @override
  Iterable<Component> build(BuildContext context) {
    return [
      FormField<String>(
        initialValue: component.controller?.text ??
            '', // Pass initial value from controller
        validator: component.validator,
        onSaved: component.onSaved,
        builder:
            _buildTextField, // Delegate the actual rendering to _buildTextField
      )
    ];
  }
}
