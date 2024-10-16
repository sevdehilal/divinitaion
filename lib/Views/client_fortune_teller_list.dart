import 'dart:convert';
import 'package:divinitaion/Views/client_fortune_teller_card.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomFortuneTellerList extends StatefulWidget {
  @override
  _CustomFortuneTellerListState createState() => _CustomFortuneTellerListState();
}

class _CustomFortuneTellerListState extends State<CustomFortuneTellerList> {
  List<Map<String, dynamic>> fortuneTellers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchFortuneTellers();
  }

  Future<void> fetchFortuneTellers() async {
    final url = Uri.parse('https://api.example.com/fortune-tellers'); // API URL'nizi buraya yazın

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);

        setState(() {
          fortuneTellers = data.map((item) {
            return {
              'name': item['name'],
              'rating': item['rating'],
              'balance': item['balance'],
            };
          }).toList();
          isLoading = false;
        });
      } else {
        // Hata durumu
        setState(() {
          isLoading = false;
        });
        print('Veri alınamadı: ${response.statusCode}');
      }
    } catch (e) {
      // İstek başarısız olduğunda
      setState(() {
        isLoading = false;
      });
      print('Hata: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Falcı Listesi'),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: fortuneTellers.length,
              itemBuilder: (context, index) {
                final fortuneTeller = fortuneTellers[index];
                return CustomFortuneTellerCard(
                  fortuneTellerName: fortuneTeller['name'],
                  rating: fortuneTeller['rating'],
                  balance: fortuneTeller['balance'],
                );
              },
            ),
    );
  }
}
