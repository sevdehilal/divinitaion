import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:divinitaion/Models/fortune_list.dart';
import 'package:divinitaion/Page/Common/backround_container.dart';
import 'package:divinitaion/Services/service.dart';

class FortuneAnswerPage extends StatefulWidget {
  final FortuneListt fortune;

  const FortuneAnswerPage({Key? key, required this.fortune}) : super(key: key);

  @override
  _FortuneAnswerPageState createState() => _FortuneAnswerPageState();
}

class _FortuneAnswerPageState extends State<FortuneAnswerPage> {
  final ApiService _apiService = ApiService();
  double? _currentScore;
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentScore = widget.fortune.score;
  }

  Future<void> _showRatingDialog() async {
    double tempScore = _currentScore ?? 0;

    await showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Puan Ver'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Puanınız: ${tempScore.toStringAsFixed(1)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  Slider(
                    value: tempScore,
                    onChanged: (value) {
                      setDialogState(() {
                        tempScore = value;
                      });
                    },
                    min: 0,
                    max: 5,
                    divisions: 10,
                    label: tempScore.toStringAsFixed(1),
                    activeColor: Colors.yellow,
                    inactiveColor: Colors.grey,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      double starValue = index + 1.0;
                      return Icon(
                        starValue <= tempScore
                            ? Icons.star
                            : starValue - 0.5 <= tempScore
                                ? Icons.star_half
                                : Icons.star_border,
                        color: starValue <= tempScore! || starValue - 0.5 <= tempScore!
                          ? Colors.yellow
                          : Colors.grey,
                      );
                    }),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('İptal'),
                ),
                TextButton(
                  onPressed: () async {
                    await _apiService.UpdateFortuneRating(
                        widget.fortune.id, tempScore);
                    setState(() {
                      _currentScore = tempScore;
                    });
                    Navigator.pop(context);
                  },
                  child: const Text('Puan Ver'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _formatDate(DateTime? date) {
    if (date == null) {
      return 'Tarih yok';
    }
    return DateFormat('dd/MM/yyyy ss:HH:mm').format(date);
  }

  Future<void> _captureAndShareScreenshot() async {
    try {
      final boundary = _screenshotKey.currentContext?.findRenderObject()
          as RenderRepaintBoundary?;
      if (boundary == null) return;

      final image = await boundary.toImage(pixelRatio: 3.0);
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      if (byteData == null) return;

      final buffer = byteData.buffer.asUint8List();
      final directory = await getTemporaryDirectory();
      final filePath = '${directory.path}/screenshot.png';
      final file = File(filePath);

      await file.writeAsBytes(buffer);

      await Share.shareXFiles([XFile(filePath)], text: 'Great picture');
    } catch (e) {
      debugPrint('Ekran görüntüsü alma ve paylaşma hatası: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: const Text(
          'Fal Cevabın...',
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
      ),
      body: BackgroundContainer(
        child: RepaintBoundary(
          key: _screenshotKey,
          child: Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).padding.top + kToolbarHeight,
              left: 16.0,
              right: 16.0,
              bottom: 16.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _infoContainer(
                    'Kategoriler: ${widget.fortune.categories?.join(', ') ?? ''}'),
                const SizedBox(height: 10),
                _infoContainer(
                    'Oluşturma Tarihi: ${_formatDate(widget.fortune.createDate)}'),
                const SizedBox(height: 6),
                const Divider(color: Colors.grey),
                _infoContainer(widget.fortune.answer ?? 'No answer provided.'),
                const Spacer(),
                if (_currentScore == null)
                  Center(
                    child: OutlinedButton(
                      onPressed: _showRatingDialog,
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white),
                      ),
                      child: const Text(
                        'Puanlamak İster misiniz?',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                else
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      double starValue = index + 1.0;
                      return Icon(
                        starValue <= _currentScore!
                            ? Icons.star
                            : starValue - 0.5 <= _currentScore!
                                ? Icons.star_half
                                : Icons.star_border,
                        color: starValue <= _currentScore! || starValue - 0.5 <= _currentScore!
                            ? Colors.yellow
                            : Colors.grey,
                      );
                    }),
                  ),
                const SizedBox(height: 10),
                Center(  // Center the button here
                  child: OutlinedButton(
                    onPressed: _captureAndShareScreenshot,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text(
                      'Ekran Görüntüsünü Paylaş',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoContainer(String text) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.6),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          color: Colors.white,
        ),
      ),
    );
  }
}
