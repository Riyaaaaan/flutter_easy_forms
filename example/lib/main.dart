import 'package:flutter/material.dart';
import 'package:easy_forms/easy_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Easy Forms Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const FormDemoPage(),
    );
  }
}

class FormDemoPage extends StatefulWidget {
  const FormDemoPage({Key? key}) : super(key: key);

  @override
  State<FormDemoPage> createState() => _FormDemoPageState();
}

class _FormDemoPageState extends State<FormDemoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _usernameController = TextEditingController();
  final _dobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Easy Forms Demo')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Registration Form',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // Text field (default)
              const EasyFormField(label: 'Full Name'),

              // Email field
              EasyFormField(
                label: 'Email Address',
                fieldType: FieldType.email,
                controller: _emailController,
              ),

              // Password field
              EasyFormField(
                label: 'Password',
                fieldType: FieldType.password,
                controller: _passwordController,
              ),

              // Number field
              EasyFormField(
                label: 'Phone Number',
                fieldType: FieldType.number,
                controller: _phoneController,
              ),

              // Alphanumeric field
              EasyFormField(
                label: 'Username',
                fieldType: FieldType.alphanum,
                controller: _usernameController,
                hintText: 'Only letters and numbers allowed',
              ),

              // Date picker field
              EasyFormField(
                label: 'Date of Birth',
                fieldType: FieldType.datepicker,
                controller: _dobController,
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              ),

              // Optional field
              const EasyFormField(
                label: 'Middle Name (Optional)',
                required: false,
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Form is valid!')),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text('Submit Form'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _phoneController.dispose();
    _usernameController.dispose();
    _dobController.dispose();
    super.dispose();
  }
}
