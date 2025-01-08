import 'package:divinitaion/Models/fortune_list.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FortuneCard extends StatefulWidget {
  final FortuneListt fortune;
  final bool isTappable;
  final VoidCallback? onTap;

  const FortuneCard({
    Key? key,
    required this.fortune,
    this.isTappable = true,
    this.onTap,
  }) : super(key: key);

  @override
  _FortuneCardState createState() => _FortuneCardState();
}

class _FortuneCardState extends State<FortuneCard> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isTappable ? widget.onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 150,
          child: Card(
            color: Colors.white.withOpacity(0.3),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.coffee,
                        size: 50,
                        color: const Color.fromARGB(158, 232, 162, 241),
                      ),
                      SizedBox(width: 25),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(height: 8),
                            Text(
                              'Falcı: ${widget.fortune.fortunetellerFirstName} ${widget.fortune.fortunetellerLastName}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Tarih: ${widget.fortune.createDate != null ? DateFormat('dd/MM/yyyy HH:mm:ss').format(widget.fortune.createDate?.toLocal() ?? DateTime.now()) : "?"}',
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Text(
                      '${widget.fortune.falCategory}',
                      style: TextStyle(
                        color: const Color.fromARGB(255, 251, 255, 0),
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
