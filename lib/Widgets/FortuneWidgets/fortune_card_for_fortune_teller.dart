import 'package:flutter/material.dart';
import 'dart:convert'; // base64Decode için gerekli
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:google_fonts/google_fonts.dart'; // Google Fonts kütüphanesini ekledik
import 'package:intl/intl.dart'; // intl paketini import etmeniz gerekiyor

class FortuneCardForFortuneTeller extends StatelessWidget {
  final FortuneForFortuneTeller fortune;

  const FortuneCardForFortuneTeller({
    Key? key,
    required this.fortune,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(15.0),
          border: Border.all(
            width: 1,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        margin: const EdgeInsets.symmetric(vertical: 3, horizontal: 10),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildImage(fortune.imageData1),
                  _buildImage(fortune.imageData2),
                  _buildImage(fortune.imageData3),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '${fortune.firstName ?? ''} ${fortune.lastName ?? ''}',
                style: GoogleFonts.montserrat(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFFC0C0C0),
                ),
              ),

              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    fortune.createDate != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(fortune.createDate?.toLocal() ?? DateTime.now()) : "?",                    
                    style: GoogleFonts.montserrat(
                    fontSize: 14,
                    color: Color(0xFFD4AF37),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Resim Yükleme Yardımcı Fonksiyonu
  Widget _buildImage(String? imageData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: imageData != null && imageData.isNotEmpty
              ? Image.memory(
                  base64Decode(imageData),
                  height: 90, // Resim yüksekliğini ayarladık
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey[300],
                      child: Center(child: Text('Resim Yüklenemedi')),
                    );
                  },
                )
              : Container(
                  color: Colors.grey[300],
                  child: Center(child: Text('Resim Yok')),
                ),
        ),
      ),
    );
  }
}
