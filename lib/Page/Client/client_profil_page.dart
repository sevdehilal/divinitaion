import 'package:divinitaion/Models/register_client.dart';
import 'package:flutter/material.dart';

class ClientProfilePage extends StatefulWidget {
  final User user;

  ClientProfilePage({required this.user});

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  bool _obscurePassword = true;
  final List<String> _genders = ['Erkek', 'Kadın', 'Diğer'];

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword; // Şifre görünürlüğünü değiştir
    });
  }

  bool _isEditing = false; // Düzenleme modunu kontrol eder
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _genderController;
  late TextEditingController _occupationController;
  late TextEditingController _maritalStatusController;
  late TextEditingController _userNameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Controller'lar için mevcut kullanıcı bilgilerini yükleme
    _firstNameController = TextEditingController(text: widget.user.firstName);
    _lastNameController = TextEditingController(text: widget.user.lastName);
    _genderController = TextEditingController(text: widget.user.gender);
    _occupationController = TextEditingController(text: widget.user.occupation);
    _maritalStatusController =
        TextEditingController(text: widget.user.maritalStatus);
    _userNameController = TextEditingController(text: widget.user.userName);
    _emailController = TextEditingController(text: widget.user.email);
    _passwordController = TextEditingController(text: widget.user.password);
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller,
        readOnly: !_isEditing,
        obscureText: _obscurePassword, // Şifreyi gizlemek için
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          suffixIcon: IconButton(
            icon: Icon(
              _obscurePassword ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed:
                _togglePasswordVisibility, // Göz simgesine tıklandığında çağrılır
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Controller'ları temizleme
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _occupationController.dispose();
    _maritalStatusController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    // Kaydetme işlemi
    setState(() {
      _isEditing = false;
    });

    // Güncellenmiş kullanıcı bilgilerini almak
    final updatedUser = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: widget.user.dateOfBirth, // Doğum tarihini sabit tuttum
      occupation: _occupationController.text,
      maritalStatus: _maritalStatusController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text, // Şifre düzenlenemez
    );

    print(updatedUser.toJson()); // Güncellenmiş kullanıcı bilgileri terminalde
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profilim'),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit),
            onPressed: _isEditing ? _saveProfile : _toggleEdit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(13.0),
        child: ListView(
          children: [
            _buildTextField('Adı', _firstNameController,
                icon: Icon(Icons.person)),
            _buildTextField('Soyadı', _lastNameController,
                icon: Icon(Icons.person)),
            _buildGenderDropdown(),
            _buildTextField('Meslek', _occupationController,
                icon: Icon(Icons.work)),
            _buildTextField('Medeni Durum', _maritalStatusController,
                icon: Icon(Icons.family_restroom)),
            _buildTextField('Kullanıcı Adı', _userNameController,
                icon: Icon(Icons.person_outline)),
            _buildTextField('Email', _emailController, icon: Icon(Icons.email)),
            _buildPasswordField('Şifre', _passwordController),
          ],
        ),
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: DropdownButtonFormField<String>(
        value: _genderController.text.isEmpty ? null : _genderController.text,
        items: _genders.map((String gender) {
          return DropdownMenuItem<String>(
            value: gender,
            child: Text(gender),
          );
        }).toList(),
        onChanged: _isEditing
            ? (String? newValue) {
                setState(() {
                  _genderController.text = newValue!;
                });
              }
            : null,
        decoration: InputDecoration(
          labelText: 'Cinsiyet',
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, dynamic controller,
      {bool isEditable = true, Icon? icon}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        controller: controller is TextEditingController ? controller : null,
        readOnly: !isEditable || !_isEditing,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
          prefixIcon: icon,
        ),
        initialValue: controller is String
            ? controller
            : null, // Doğum tarihi gibi sabit değerler için
      ),
    );
  }
}
