import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Services/service.dart';

import '../../Models/fortune_category.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final ApiService _apiService = ApiService();
  int _selectedTabIndex = 0;
  bool _isPasswordVisible = false;

  List<FortuneCategory> _categories = [];
  List<FortuneCategory> _selectedCategories = [];

  List<String> _genderOptions = ['Kız', 'Erkek'];
  String? _selectedGender;

  Future<void> _selectDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _dateOfBirthController.text = DateFormat('dd-MM-yyyy').format(picked);
      });
    }
  }

  Future<void> _fetchCategories() async {
    List<FortuneCategory> categories = await _apiService.getFortuneCategories();
    
    setState(() {
      _categories = categories;
    });
  }

  Future<void> _register() async {
    User newUser = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: DateFormat('dd-MM-yyyy').parse(_dateOfBirthController.text),
      occupation: _occupationController.text,
      maritalStatus: _maritalStatusController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    bool success = await _apiService.registerUser(newUser);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarılı!!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Kayıt başarısız. Lütfen tekrar deneyin.')),
      );
    }
  }

  Future<void> _fortuneTellerRegister() async {
    FortuneTeller newFortuneTeller = FortuneTeller(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      dateOfBirth: DateFormat('dd-MM-yyyy').parse(_dateOfBirthController.text),
      gender: _genderController.text,
      experience: _experienceController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
      falCategories: _selectedCategories.map((category) => category.id).toList(),
    );

    bool success = await _apiService.registerFortuneTeller(newFortuneTeller);

    if (success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Falcı olarak kayıt başarılı!')),
      );
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Falcı olarak kayıt başarısız. Lütfen tekrar deneyin.')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kayıt'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedTabIndex == 0
                          ? const Color.fromARGB(123, 117, 0, 146)
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedTabIndex = 0;
                      });
                    },
                    child: Text(
                      'Kayıt Ol',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _selectedTabIndex == 1
                          ? const Color.fromARGB(123, 117, 0, 146)
                          : Colors.grey,
                    ),
                    onPressed: () {
                      setState(() {
                        _selectedTabIndex = 1;
                      });
                    },
                    child: Text(
                      'Falcı Olarak Kayıt Ol',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (_selectedTabIndex == 0)
              _buildUserForm()
            else
              _buildFortuneTellerForm(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserForm() {
    return Column(
      children: [
        TextField(
          controller: _firstNameController,
          decoration: InputDecoration(labelText: 'İsim'),
        ),
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(labelText: 'Soyisim'),
        ),
        DropdownButtonFormField<String>(
          decoration: InputDecoration(labelText: 'Cinsiyet'),
          value: _selectedGender,
          onChanged: (newValue) {
            setState(() {
              _selectedGender = newValue;
            });
          },
          items: _genderOptions.map((gender) {
            return DropdownMenuItem<String>(
              value: gender,
              child: Text(gender),
            );
          }).toList(),
        ),
        TextField(
          controller: _dateOfBirthController,
          decoration: InputDecoration(
            labelText: 'Doğum Tarihi (dd-MM-yyyy)',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
          readOnly: true,
        ),
        TextField(
          controller: _occupationController,
          decoration: InputDecoration(labelText: 'Meslek'),
        ),
        TextField(
          controller: _maritalStatusController,
          decoration: InputDecoration(labelText: 'Medeni Durum'),
        ),
        TextField(
          controller: _userNameController,
          decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Şifre',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          obscureText: !_isPasswordVisible,
        ),
        SizedBox(height: 20),
        OutlinedButton(
          onPressed: _register,
          child: Text('Kayıt Ol'),
        ),
      ],
    );
  }

  Widget _buildFortuneTellerForm() {
    return Column(
      children: [
        TextField(
          controller: _firstNameController,
          decoration: InputDecoration(labelText: 'İsim'),
        ),
        TextField(
          controller: _lastNameController,
          decoration: InputDecoration(labelText: 'Soyisim'),
        ),
        TextField(
          controller: _dateOfBirthController,
          decoration: InputDecoration(
            labelText: 'Doğum Tarihi (dd-MM-yyyy)',
            suffixIcon: IconButton(
              icon: Icon(Icons.calendar_today),
              onPressed: () => _selectDate(context),
            ),
          ),
          readOnly: true,
        ),
        TextField(
          controller: _userNameController,
          decoration: InputDecoration(labelText: 'Kullanıcı Adı'),
        ),
        TextField(
          controller: _emailController,
          decoration: InputDecoration(labelText: 'E-mail'),
          keyboardType: TextInputType.emailAddress,
        ),
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Şifre',
            suffixIcon: IconButton(
              icon: Icon(
                _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
              ),
              onPressed: () {
                setState(() {
                  _isPasswordVisible = !_isPasswordVisible;
                });
              },
            ),
          ),
          obscureText: !_isPasswordVisible,
        ),
        SizedBox(height: 10),
        Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Bakılacak Fal Kategorisi',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        SizedBox(height: 5),
        _categories.isEmpty
            ? CircularProgressIndicator()
            : Wrap(
                children: _categories.map((category) {
                  return Row(
                    children: [
                      Checkbox(
                        value: _selectedCategories.contains(category),
                        onChanged: (bool? value) {
                          setState(() {
                            if (value != null && value) {
                              _selectedCategories.add(category);
                            } else {
                              _selectedCategories.remove(category);
                            }
                          });
                        },
                      ),
                      Text(category.categoryName),
                    ],
                  );
                }).toList(),
              ),
        OutlinedButton(
          onPressed: _fortuneTellerRegister,
          child: Text('Onaya Sun'),
        ),
      ],
    );
  }
}
