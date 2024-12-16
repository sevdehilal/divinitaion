import 'package:divinitaion/Models/register_client.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class ClientProfilePage extends StatefulWidget {
  @override
  _ClientProfilePageState createState() => _ClientProfilePageState();
}

class _ClientProfilePageState extends State<ClientProfilePage> {
  final ApiService _apiService = ApiService();
  late Future<User> _userFuture;
  bool _isEditing = false;

final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  final TextEditingController _occupationController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _maritalStatusController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _userFuture = _apiService.getUser();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _emailController.dispose();
    _dateOfBirthController.dispose();
    _occupationController.dispose();
    _maritalStatusController.dispose();
    super.dispose();
  }

  void _populateFields(User user) {
    _userNameController.text = user.userName ?? '';
    _firstNameController.text = user.firstName;
    _lastNameController.text = user.lastName;
    _genderController.text = user.gender ?? '';
    _emailController.text = user.email ?? '';
    _occupationController.text = user.occupation ?? '';
    _maritalStatusController.text = user.maritalStatus ?? '';
    if (user.dateOfBirth != null) {
      _dateOfBirthController.text = DateFormat('dd/MM/yyyy').format(user.dateOfBirth!);
    }
  }

  void _toggleEdit() async {
    if (_isEditing) {
      final updatedData = {
        'userName': _userNameController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'dateOfBirth': DateFormat('dd/MM/yyyy').parse(_dateOfBirthController.text).toIso8601String(),
        'gender': _genderController.text,
        'email': _emailController.text,
        'occupation': _occupationController.text,
        'maritalStatus': _maritalStatusController.text,
      };

      final success = await _apiService.updateClientProfile(updatedData);

      if (success) {
        setState(() {
          _isEditing = false;
          _userFuture = _apiService.getUser();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil başarıyla güncellendi.")),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Profil güncellenemedi, tekrar deneyin.")),
        );
      }
    } else {
      setState(() {
        _isEditing = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(
              _isEditing ? Icons.save : Icons.edit,
              color: Colors.white,
            ),
            onPressed: _toggleEdit,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      extendBodyBehindAppBar: true,
      body: BackgroundContainer(
        child: FutureBuilder<User>(
          future: _userFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final user = snapshot.data!;
              if (!_isEditing) {
                _populateFields(user);
              }
              return _buildProfile();
            } else {
              return Center(child: Text('User bilgisi bulunamadı.'));
            }
          },
        ),
      ),
    );
  }

  Widget _buildProfile() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildCard(child: _buildTextField('Adı', _firstNameController)),
                _buildCard(child: _buildTextField('Soyadı', _lastNameController)),
                _buildCard(child: _buildGenderDropdownField('Cinsiyet', _genderController)),
                _buildCard(child: _buildMaritalStatusDropdownField('Medeni Durum', _maritalStatusController)),
                _buildCard(child: _buildTextField('Meslek', _occupationController)),
                _buildCard(child: _buildTextField('Doğum Tarihi', _dateOfBirthController)),
                _buildCard(child: _buildTextField('Kullanıcı Adı', _userNameController, isEditable: false)),
                _buildCard(child: _buildTextField('E-Posta', _emailController, isEditable: false)),
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
      {bool isEditable = true, bool isNumber = false}) {
    return TextFormField(
      controller: controller,
      readOnly: !_isEditing || !isEditable,
      keyboardType: isNumber ? TextInputType.number : TextInputType.text,
      inputFormatters: isNumber
          ? [FilteringTextInputFormatter.digitsOnly]
          : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
    );
  }

  Widget _buildGenderDropdownField(String label, TextEditingController controller) {
    const genderOptions = ['Kadın', 'Erkek', 'Belirtmek İstemiyor'];

    String? dropdownValue = genderOptions.contains(controller.text)
        ? controller.text
        : null;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      items: genderOptions
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
      onChanged: _isEditing
          ? (value) {
              setState(() {
                controller.text = value ?? '';
              });
            }
          : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      dropdownColor: Colors.black.withOpacity(0.9),
    );
  }

  Widget _buildMaritalStatusDropdownField(String label, TextEditingController controller) {
    const maritalStatusOptions = ['Bekar', 'Evli', 'Belirtmek İstemiyor'];

    String? dropdownValue = maritalStatusOptions.contains(controller.text)
        ? controller.text
        : null;

    return DropdownButtonFormField<String>(
      value: dropdownValue,
      items: maritalStatusOptions
          .map((gender) => DropdownMenuItem(
                value: gender,
                child: Text(
                  gender,
                  style: const TextStyle(color: Colors.white),
                ),
              ))
          .toList(),
      onChanged: _isEditing
          ? (value) {
              setState(() {
                controller.text = value ?? '';
              });
            }
          : null,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white),
        border: const OutlineInputBorder(),
      ),
      dropdownColor: Colors.black.withOpacity(0.9),
    );
  }
}