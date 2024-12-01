import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class ClientProfilePage extends StatefulWidget {
  ClientProfilePage();

  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  final ApiService _apiService = ApiService();
  late Future<User> _userFuture;
  bool _obscurePassword = true;
  bool _isEditing = false;

  // Add controllers to manage input fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();

  String _gender = 'Belirtmek İstemiyorum'; // Default value for gender
  String _maritalStatus = 'Bekar'; // Default value for marital status

  List<String> _genderOptions = ['Kadın', 'Erkek', 'Belirtmek İstemiyor'];
  List<String> _maritalStatusOptions = ['Evli', 'İlişkisi Var', 'Bekar'];

  @override
  void initState() {
    super.initState();
    _userFuture = _apiService.getUser();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
    });
  }

  void _saveProfile() {
    Map<String, dynamic> updatedData = {
      'userName': _userNameController.text,
      'firstName': _firstNameController.text,
      'lastName': _lastNameController.text,
      'dateofBirth': _dateOfBirthController.text,
      'occupation': _occupationController.text,
      'gender': _gender,
      'maritalStatus': _maritalStatus,
      'email':  _emailController.text,
    };

    _apiService.updateClientProfile(updatedData).then((isSuccess) {
      if (isSuccess) {
        setState(() {
          _isEditing = false;
          _userFuture = _apiService.getUser(); // güncel verileri getir
        });
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profil başarıyla güncellendi')));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Profil güncellenirken hata oluştu')));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundContainer(
      child: Scaffold(
        backgroundColor: Colors.transparent, // Arka planı saydam yap
        appBar: AppBar(
          title: Text('Profilim', style: TextStyle(color: Colors.white)),
          actions: [
            IconButton(
              icon: Icon(_isEditing ? Icons.save : Icons.edit,
                  color: Colors.white),
              onPressed: _isEditing ? _saveProfile : _toggleEdit,
            ),
          ],
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: FutureBuilder<User>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              _firstNameController.text = user.firstName;
              _lastNameController.text = user.lastName;
              _dateOfBirthController.text = user.dateOfBirth.toIso8601String();
              _occupationController.text = user.occupation;
              _userNameController.text = user.userName;
              _emailController.text = user.email;
              _gender = user.gender;
              _maritalStatus = user.maritalStatus;

              return _buildProfile(user);
            } else {
              return Center(child: Text('Kullanıcı bilgisi bulunamadı.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfile(User user) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildCard(child: _buildTextField('Adı', _firstNameController)),
                _buildCard(child: _buildTextField('Soyadı', _lastNameController)),
                _buildCard(child: _buildTextField('Doğum Tarihi', _dateOfBirthController)),
                _buildCard(child: _buildGenderDropdown()),
                _buildCard(child: _buildMaritalStatusDropdown()),
                _buildCard(child: _buildTextField('Meslek', _occupationController)),
                _buildCard(child: _buildTextField('Kullanıcı Adı', _userNameController, isEditable: false)),
                _buildCard(child: _buildTextField('Email', _emailController, isEditable: false)),
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
      margin: const EdgeInsets.symmetric(vertical: 6.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: child,
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller,
      {bool isEditable = true}) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing || !isEditable,
      style: TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.white),
        border: OutlineInputBorder(),
      ),
    );
  }

 Widget _buildGenderDropdown() {
  return DropdownButtonFormField<String>(
    value: _gender,
    onChanged: _isEditing
        ? (String? newValue) {
            setState(() {
              _gender = newValue!;
            });
          }
        : null,
    items: _genderOptions.map((String gender) {
      return DropdownMenuItem<String>(
        value: gender,
        child: Text(gender, style: TextStyle(color: Colors.white)),
      );
    }).toList(),
    decoration: InputDecoration(
      labelText: 'Cinsiyet',
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
    ),
    dropdownColor: Colors.black.withOpacity(0.7),
  );
}

Widget _buildMaritalStatusDropdown() {
  return DropdownButtonFormField<String>(
    value: _maritalStatus,
    onChanged: _isEditing
        ? (String? newValue) {
            setState(() {
              _maritalStatus = newValue!;
            });
          }
        : null,
    items: _maritalStatusOptions.map((String status) {
      return DropdownMenuItem<String>(
        value: status,
        child: Text(status, style: TextStyle(color: Colors.white)),
      );
    }).toList(),
    decoration: InputDecoration(
      labelText: 'Medeni Durum',
      labelStyle: TextStyle(color: Colors.white),
      border: OutlineInputBorder(),
    ),
    dropdownColor: Colors.black.withOpacity(0.7),
  );
}


}
