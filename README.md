# Easy Forms

A Flutter package that simplifies form creation with ready-to-use form fields. Create beautiful forms with minimal code!

## Features

- **Multiple Field Types**: text, alphanum, number, email, password, datepicker
- **Built-in Validation**: Each field type comes with appropriate validation
- **Minimal Code**: Create forms with just one line per field
- **Customizable**: Extensive customization options available
- **Ready to Use**: Import and start using immediately

## Installation

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  easy_forms: ^1.0.0
```

Then run:

```bash
flutter pub get
```

## Quick Start

```dart
import 'package:flutter/material.dart';
import 'package:easy_forms/easy_forms.dart';

class MyForm extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Text field (default)
          EasyFormField(label: 'Name'),

          // Email field with validation
          EasyFormField(
            label: 'Email',
            fieldType: FieldType.email,
          ),

          // Password field with hide/show
          EasyFormField(
            label: 'Password',
            fieldType: FieldType.password,
          ),

          // Number field
          EasyFormField(
            label: 'Phone',
            fieldType: FieldType.number,
          ),

          // Alphanumeric field
          EasyFormField(
            label: 'Username',
            fieldType: FieldType.alphanum,
          ),

          // Date picker
          EasyFormField(
            label: 'Date of Birth',
            fieldType: FieldType.datepicker,
          ),
        ],
      ),
    );
  }
}
```

## Field Types

| Type                   | Description               | Validation                |
| ---------------------- | ------------------------- | ------------------------- |
| `FieldType.text`       | Default text input        | Required field validation |
| `FieldType.alphanum`   | Letters and numbers only  | Alphanumeric validation   |
| `FieldType.number`     | Numeric input             | Number validation         |
| `FieldType.email`      | Email input with keyboard | Email format validation   |
| `FieldType.password`   | Password with hide/show   | Minimum length validation |
| `FieldType.datepicker` | Date selection            | Date selection validation |

## Customization

```dart
EasyFormField(
  label: 'Custom Field',
  fieldType: FieldType.email,
  hintText: 'Custom hint text',
  required: false,
  prefixIcon: Icons.person,
  filled: true,
  fillColor: Colors.grey[100],
  onChanged: (value) => print('Changed: $value'),
  validator: (value) => value?.isEmpty ?? true ? 'Required!' : null,
)
```

## Properties

- `label`: Field label (required)
- `fieldType`: Type of field (defaults to text)
- `controller`: TextEditingController
- `validator`: Custom validation function
- `hintText`: Placeholder text
- `required`: Whether field is required (default: true)
- `prefixIcon` & `suffixIcon`: Icons
- `onChanged`: Callback for value changes
- `enabled`: Enable/disable field
- `filled`: Fill background
- `fillColor`: Background color

## License

MIT License
