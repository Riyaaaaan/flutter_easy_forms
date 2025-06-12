<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/tools/pub/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/to/develop-packages).
-->

A Flutter package for creating forms with minimal code. Easy Forms provides a simple yet powerful way to create forms in your Flutter applications with built-in validation and ready-to-use form fields.

## Features

- Simple and intuitive API
- Built-in validation
- Support for various field types:
  - Text
  - Email
  - Password
  - Numbers
  - Alphanumeric
  - Date picker
- Customizable styling
- Form field validation
- Optional fields support

## Getting started

Add this to your package's `pubspec.yaml` file:

```yaml
dependencies:
  easy_forms: ^0.0.1
```

## Usage

```dart
import 'package:flutter/material.dart';
import 'package:easy_forms/easy_forms.dart';

// Create a simple form field
const EasyFormField(
  label: 'Email',
  fieldType: FieldType.email,
);

// Create a password field with validation
const EasyFormField(
  label: 'Password',
  fieldType: FieldType.password,
);

// Create an optional field
const EasyFormField(
  label: 'Phone Number (Optional)',
  fieldType: FieldType.number,
  required: false,
);
```

See the `example` directory for a complete sample application.

## Additional information

For more examples and usage information, please visit the example directory in the package repository. This package provides a comprehensive solution for creating forms in Flutter with minimal code while maintaining flexibility and customization options.
