import 'package:flutter/material.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Services/service.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  // Deneyim için
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _maritalStatusController =
      TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService _apiService = ApiService();
  int _selectedButtonIndex = 0; // 0: Kayıt Ol, 1: Falcı Olarak Kayıt Ol

  // Falcı için seçilebilecek fal kategorileri
  List<String> _categories = ['Tarot', 'Kahve Falı', 'El Falı', 'Aşk Falı'];
  String? _selectedCategory;

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

  Future<void> _fortuneTellerRegister() async {
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
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: EdgeInsets.all(8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedButtonIndex = 0; // Kayıt Ol formu
                          });
                        },
                        child: Text(
                          'Kayıt Ol',
                          style: TextStyle(
                            fontSize: 13,
                            color: _selectedButtonIndex == 0
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10), // Butonlar arasında boşluk
                    Expanded(
                      child: TextButton(
                        onPressed: () {
                          setState(() {
                            _selectedButtonIndex = 1; // Falcı Kayıt formu
                          });
                        },
                        child: Text(
                          'Falcı Olarak Kayıt Ol',
                          style: TextStyle(
                            fontSize: 13,
                            color: _selectedButtonIndex == 1
                                ? Colors.blue
                                : Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),

              // Farklı form içerikleri
              if (_selectedButtonIndex == 0) ...[
                // Standart kullanıcı formu
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
              ] else if (_selectedButtonIndex == 1) ...[
                // Falcı kayıt formu
                TextField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                ),
                TextField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                ),
                TextField(
                  controller: _experienceController,
                  decoration:
                      InputDecoration(labelText: 'Deneyim (Yıl olarak)'),
                  keyboardType: TextInputType.number,
                ),
                TextField(
                  controller: _genderController,
                  decoration: InputDecoration(labelText: 'Cinsiyet'),
                ),

                // Fal kategorisi seçimi (Dropdown)
                SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration:
                      InputDecoration(labelText: 'Bakacağı Fal Kategorisi'),
                  value: _selectedCategory,
                  onChanged: (newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  items: _categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
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
                  onPressed: _fortuneTellerRegister,
                  child: Text('Onaya Sun'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
