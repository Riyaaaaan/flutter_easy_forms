// main.dart - Complete example of using easy_forms in your app
import 'package:flutter/material.dart';
import 'package:easy_forms/easy_forms.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'My App with Easy Forms',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const RegistrationPage(),
    );
  }
}

// Example 2: Complete Registration Form
class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Create Account')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              const Text(
                'Join Us Today!',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),

              // All different field types with minimal code
              const EasyFormField(
                label: 'First Name',
                // fieldType defaults to FieldType.text
              ),

              const EasyFormField(label: 'Last Name'),

              const EasyFormField(
                label: 'Email Address',
                fieldType: FieldType.email,
              ),

              const EasyFormField(
                label: 'Username',
                fieldType: FieldType.alphanum,
                hintText: 'Letters and numbers only',
              ),

              const EasyFormField(
                label: 'Phone Number',
                fieldType: FieldType.number,
              ),

              const EasyFormField(
                label: 'Create Password',
                fieldType: FieldType.password,
              ),

              EasyFormField(
                label: 'Date of Birth',
                fieldType: FieldType.datepicker,
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
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Account created successfully!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Create Account'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Example 3: Advanced Usage with Custom Styling and Validation
class ProfileEditPage extends StatefulWidget {
  const ProfileEditPage({super.key});

  @override
  State<ProfileEditPage> createState() => _ProfileEditPageState();
}

class _ProfileEditPageState extends State<ProfileEditPage> {
  final _formKey = GlobalKey<FormState>();
  final _bioController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Custom styling example
              EasyFormField(
                label: 'Display Name',
                filled: true,
                fillColor: Colors.grey[100],
                prefixIcon: Icons.person,
                onChanged: (value) {
                  print('Name changed: $value');
                },
              ),

              // Custom validation example
              EasyFormField(
                label: 'Website URL',
                validator: (value) {
                  if (value != null && value.isNotEmpty) {
                    if (!value.startsWith('http://') &&
                        !value.startsWith('https://')) {
                      return 'URL must start with http:// or https://';
                    }
                  }
                  return null;
                },
                required: false,
                prefixIcon: Icons.link,
              ),

              // Multi-line text field
              EasyFormField(
                label: 'Bio',
                controller: _bioController,
                maxLines: 4,
                hintText: 'Tell us about yourself...',
                textInputAction: TextInputAction.newline,
              ),

              // Number field with custom validation
              EasyFormField(
                label: 'Age',
                fieldType: FieldType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Age is required';
                  }
                  final age = int.tryParse(value);
                  if (age == null || age < 13 || age > 120) {
                    return 'Please enter a valid age (13-120)';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 30),

              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Profile updated!'),
                        backgroundColor: Colors.green,
                      ),
                    );
                  }
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Update Profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _bioController.dispose();
    super.dispose();
  }
}
