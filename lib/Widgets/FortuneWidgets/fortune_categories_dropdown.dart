import 'package:divinitaion/Models/fortune_category.dart';
import 'package:divinitaion/Services/service.dart';
import 'package:flutter/material.dart';

class FortuneCategoriesDropdown extends StatefulWidget {
  final Function(int?) onChanged;

  FortuneCategoriesDropdown({required this.onChanged});

  @override
  _FortuneCategoriesDropdown createState() => _FortuneCategoriesDropdown();
}

class _FortuneCategoriesDropdown extends State<FortuneCategoriesDropdown> {
  final ApiService _apiService = ApiService();
  late Future<List<FortuneCategory>> _items;
  int? _selectedId;

  @override
  void initState() {
    super.initState();
    _items = _apiService.getFortuneCategories();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<FortuneCategory>>(
      future: _items,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Hata: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('Kategoriler bulunamadı'));
        }

        List<FortuneCategory> categories = snapshot.data!;
        return DropdownButton<int>(
          value: _selectedId,
          hint: Text(
            'Bir kategori seçin',
            style: TextStyle(color: Colors.white),
          ),
          onChanged: (int? newValue) {
            setState(() {
              _selectedId = newValue;
              widget.onChanged(newValue);
            });
          },
          dropdownColor: Colors.black,
          style: TextStyle(color: Colors.white),
          items: categories.map<DropdownMenuItem<int>>((item) {
            return DropdownMenuItem<int>(
              value: item.id,
              child: Text(
                item.categoryName,
                style: TextStyle(color: Colors.white),
              ),
            );
          }).toList(),
        );
      },
    );
  }
}
