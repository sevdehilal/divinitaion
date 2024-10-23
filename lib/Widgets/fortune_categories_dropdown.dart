import 'package:divinitaion/Models/fortune_teller_entity.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class FortuneCategoriesDropdown extends StatefulWidget {
  final Function(int?) onChanged; // Seçilen kategorinin ID'sini döndüren callback

  FortuneCategoriesDropdown({required this.onChanged});

  @override
  _FortuneCategoriesDropdown createState() => _FortuneCategoriesDropdown();
}

class _FortuneCategoriesDropdown extends State<FortuneCategoriesDropdown> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneTeller>> _items; // API'den alınan kategoriler
  int? _selectedId; // Seçilen kategori ID'si

  @override
  void initState() {
    super.initState();
    _items = _apiService.FetchFortuneTeller(); // Kategorileri yükle
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FortuneTeller>>(
      future: _items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Veriler yükleniyor
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hata durumu
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // Boş veri durumu
          return Center(child: Text('Kategoriler bulunamadı'));
        }

        // Başarılı bir şekilde veri yüklendi
        List<FortuneTeller> categories = snapshot.data!;
        return DropdownButton<int>(
          value: _selectedId,
          hint: Text('Bir kategori seçin'),
          onChanged: (int? newValue) {
            setState(() {
              _selectedId = newValue;
              widget.onChanged(newValue); // Seçilen ID'yi döndür
            });
          },
          items: categories.map<DropdownMenuItem<int>>((item) {
            return DropdownMenuItem<int>(
              value: item.id, // ID'yi kullan
              child: Text(item.firstName), // Gösterilecek isim
            );
          }).toList(),
        );
      },
    );
  }
}
