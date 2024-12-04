import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:flutter/material.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class FortuneTellerProfilePage extends StatefulWidget {
  @override
  _FortuneTellerProfilePageState createState() =>
      _FortuneTellerProfilePageState();
}

class _FortuneTellerProfilePageState extends State<FortuneTellerProfilePage> {
  final ApiService _apiService = ApiService();
  late Future<FortuneTeller> _fortuneTellerFuture;
  bool _isEditing = false;

  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();
  final TextEditingController _experienceController = TextEditingController();
  final TextEditingController _requirementCreditController =
      TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _ratingController = TextEditingController();
  final TextEditingController _totalCreditController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fortuneTellerFuture = _apiService.getFortuneTeller();
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _firstNameController.dispose();
    _lastNameController.dispose();
    _genderController.dispose();
    _experienceController.dispose();
    _requirementCreditController.dispose();
    _emailController.dispose();
    _ratingController.dispose();
    _totalCreditController.dispose();
    _dateOfBirthController.dispose();
    super.dispose();
  }

  void _populateFields(FortuneTeller fortuneTeller) {
    _userNameController.text = fortuneTeller.userName ?? '';
    _firstNameController.text = fortuneTeller.firstName;
    _lastNameController.text = fortuneTeller.lastName;
    _genderController.text = fortuneTeller.gender ?? '';
    _experienceController.text = fortuneTeller.experience ?? '';
    _requirementCreditController.text =
        fortuneTeller.requirementCredit?.toString() ?? '0';
    _emailController.text = fortuneTeller.email ?? '';
    _ratingController.text = fortuneTeller.rating?.toString() ?? '0.0';
    _totalCreditController.text = fortuneTeller.totalCredit?.toString() ?? '0.0';
    _dateOfBirthController.text = DateTime(2017, 9, 7, 17, 30).toIso8601String();
  }

  void _toggleEdit() async {
    if (_isEditing) {
      final updatedData = {
        'userName': _userNameController.text,
        'firstName': _firstNameController.text,
        'lastName': _lastNameController.text,
        'dateOfBirth': _dateOfBirthController.text,
        'experience': _experienceController.text,
        'requirementCredit':
            int.tryParse(_requirementCreditController.text) ?? 0,
        'gender': _genderController.text,
        'email': _emailController.text,
        'rating': double.tryParse(_ratingController.text) ?? 0,
        'totalCredit': int.tryParse(_totalCreditController.text) ?? 0,
      };

      final success = await _apiService.updateFortuneTellerProfile(updatedData);

      if (success) {
        setState(() {
          _isEditing = false;
          _fortuneTellerFuture = _apiService.getFortuneTeller();
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
            icon: Icon(_isEditing ? Icons.save : Icons.edit, color: Colors.white),
            onPressed: _toggleEdit,
          ),
        ],
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BackgroundContainer(
        child: FutureBuilder<FortuneTeller>(
          future: _fortuneTellerFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Bir hata oluştu: ${snapshot.error}'));
            } else if (snapshot.hasData) {
              final fortuneTeller = snapshot.data!;
              if (!_isEditing) {
                _populateFields(fortuneTeller);
              }
              return _buildProfile();
            } else {
              return Center(child: Text('Falcı bilgisi bulunamadı.'));
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
                _buildCard(child: _buildDropdownField('Cinsiyet', _genderController)),
                _buildCard(
                    child: _buildTextField('Doğum Tarihi', _dateOfBirthController)),
                _buildCard(
                    child: _buildTextField('Deneyim (Yıl)', _experienceController,
                        isNumber: true)),
                _buildCard(
                    child: _buildTextField('Gereken Coin', _requirementCreditController,
                        isNumber: true)),
                _buildCard(
                    child: _buildTextField('Rating', _ratingController,
                        isEditable: false)),
                _buildCard(
                    child: _buildTextField('Toplam Coin', _totalCreditController,
                        isEditable: false)),
                _buildCard(
                    child: _buildTextField('Kullanıcı Adı', _userNameController,
                        isEditable: false)),
                _buildCard(
                    child: _buildTextField('E-Posta', _emailController,
                        isEditable: false)),
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

  Widget _buildDropdownField(String label, TextEditingController controller) {
    const genderOptions = ['Kadın', 'Erkek', 'Belirtmek İstemiyor'];

    // Dropdown'da kullanılacak değer için kontrol
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
}
