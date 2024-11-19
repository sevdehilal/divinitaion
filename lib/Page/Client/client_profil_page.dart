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
  bool _isEditing = false;

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

  @override
  void dispose() {
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
    setState(() {
      _isEditing = false;
    });

    final updatedUser = User(
      firstName: _firstNameController.text,
      lastName: _lastNameController.text,
      gender: _genderController.text,
      dateOfBirth: widget.user.dateOfBirth,
      occupation: _occupationController.text,
      maritalStatus: _maritalStatusController.text,
      userName: _userNameController.text,
      email: _emailController.text,
      password: _passwordController.text,
    );

    print(updatedUser.toJson());
  }

  void _togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Profilim', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
            onPressed: _isEditing ? _saveProfile : _toggleEdit,
          ),
        ],
        backgroundColor: const Color.fromARGB(0, 255, 255, 255),
        elevation: 0,
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    children: [
                      _buildCard(
                        child: _buildTextField('Adı', _firstNameController,
                            icon: Icon(Icons.person, color: Colors.white)),
                      ),
                      _buildCard(
                        child: _buildTextField('Soyadı', _lastNameController,
                            icon: Icon(Icons.person, color: Colors.white)),
                      ),
                      _buildCard(child: _buildGenderDropdown()),
                      _buildCard(
                        child: _buildTextField('Meslek', _occupationController,
                            icon: Icon(Icons.work, color: Colors.white)),
                      ),
                      _buildCard(
                        child: _buildTextField(
                          'Medeni Durum',
                          _maritalStatusController,
                          icon: Icon(Icons.family_restroom, color: Colors.white),
                        ),
                      ),
                      _buildCard(
                        child: _buildTextField('Kullanıcı Adı', _userNameController,
                            icon: Icon(Icons.person_outline, color: Colors.white)),
                      ),
                      _buildCard(
                        child: _buildTextField('Email', _emailController,
                            icon: Icon(Icons.email, color: Colors.white)),
                      ),
                      _buildCard(
                        child: _buildPasswordField('Şifre', _passwordController),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 8), // Aradaki boşluğu artır
                Align(
                  alignment: Alignment.center,
                  child: ElevatedButton(
                    onPressed: _toggleEdit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white.withOpacity(0.9),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                    ),
                    child: Text(
                      _isEditing ? 'Kaydet' : 'Düzenle',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard({required Widget child}) {
    return Card(
      color: Colors.black.withOpacity(0.7),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      margin: const EdgeInsets.symmetric(vertical: 6.0), // Daha küçük margin
      child: Padding(
        padding: const EdgeInsets.all(8.0), // Daha küçük padding
        child: child,
      ),
    );
  }

  Widget _buildGenderDropdown() {
    return DropdownButtonFormField<String>(
      value: _genderController.text.isEmpty ? null : _genderController.text,
      items: _genders.map((String gender) {
        return DropdownMenuItem<String>(
          value: gender,
          child: Text(gender, style: TextStyle(color: Colors.white)),
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
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {Icon? icon}) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        prefixIcon: icon,
      ),
    );
  }

  Widget _buildPasswordField(String label, TextEditingController controller) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing,
      obscureText: _obscurePassword,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
        suffixIcon: IconButton(
          icon: Icon(
            _obscurePassword ? Icons.visibility : Icons.visibility_off,
            color: Colors.white,
          ),
          onPressed: _togglePasswordVisibility,
        ),
      ),
    );
  }
}
