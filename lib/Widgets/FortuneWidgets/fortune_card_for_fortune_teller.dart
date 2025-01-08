import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:divinitaion/Models/fortune_model_for_fortune_teller.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

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
          color: Colors.white.withOpacity(0.3),
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
        child: Stack(
          children: [
            Padding(
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
                  const SizedBox(height: 4),
                  Text(
                    '${fortune.firstName ?? ''} ${fortune.lastName ?? ''}',
                    style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    fortune.createDate != null
                        ? DateFormat('dd/MM/yyyy HH:mm:ss')
                            .format(fortune.createDate?.toLocal() ?? DateTime.now())
                        : "?",
                    style: GoogleFonts.montserrat(
                      fontSize: 14,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 10,
              right: 10,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                child: Text(
                  '${fortune.falCategory}',
                  style: GoogleFonts.montserrat(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.yellow,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(String? imageData) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: imageData != null && imageData.isNotEmpty
              ? Image.memory(
                  base64Decode(imageData),
                  height: 90,
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
