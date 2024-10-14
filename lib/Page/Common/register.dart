import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService _apiService = ApiService();

  Future<void> _register() async {
    User newUser = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: DateTime.parse(_dateOfBirthController.text),
      occupation: _occupationController.text,
      maritalStatus: _maritalStatusController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    bool success = await _apiService.registerUser(newUser);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration successful!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Registration failed. Please try again.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(labelText: 'First Name'),
              ),
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(labelText: 'Last Name'),
              ),
              TextField(
                controller: _genderController,
                decoration: InputDecoration(labelText: 'Gender'),
              ),
              TextField(
                controller: _dateOfBirthController,
                decoration:
                    InputDecoration(labelText: 'Date of Birth (YYYY-MM-DD)'),
                keyboardType: TextInputType.datetime,
              ),
              TextField(
                controller: _occupationController,
                decoration: InputDecoration(labelText: 'Occupation'),
              ),
              TextField(
                controller: _maritalStatusController,
                decoration: InputDecoration(labelText: 'Marital Status'),
              ),
              TextField(
                controller: _userNameController,
                decoration: InputDecoration(labelText: 'Username'),
              ),
              TextField(
                controller: _emailController,
                decoration: InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              TextField(
                controller: _passwordController,
                decoration: InputDecoration(labelText: 'Password'),
                obscureText: true,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _register,
                child: Text('Register'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
