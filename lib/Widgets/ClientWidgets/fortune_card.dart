import 'package:divinitaion/Models/fortune_list.dart';
import 'package:flutter/material.dart';

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
  bool isFavorite = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.isTappable ? widget.onTap : null,
      child: Padding(
        padding: const EdgeInsets.all(7.0),
        child: SizedBox(
          height: 150,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16.0),
            ),
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(
                    Icons.coffee,
                    size: 50,
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(height: 8),
                        Text('Falcı: ${widget.fortune.fortunetellerFirstName}'),
                        Text('Tarih: ${widget.fortune.createDate}'),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        icon: Icon(
                          isChecked ? Icons.check_box : Icons.check_box_outline_blank,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isChecked = !isChecked;
                          });
                        },
                      ),
                      SizedBox(height: 8),
                      IconButton(
                        icon: Icon(
                          isFavorite ? Icons.favorite : Icons.favorite_border,
                          size: 24,
                        ),
                        onPressed: () {
                          setState(() {
                            isFavorite = !isFavorite;
                          });
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
