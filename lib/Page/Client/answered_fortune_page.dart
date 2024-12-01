import 'dart:io';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
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
  double? _currentRating;
  final GlobalKey _screenshotKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _currentRating = widget.fortune.rating;
  }

  Future<void> _showRatingDialog() async {
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(5, (index) {
                      return IconButton(
                        icon: Icon(
                          Icons.star,
                          color: index < (_currentRating ?? 0)
                              ? Colors.yellow
                              : Colors.grey,
                        ),
                        onPressed: () {
                          setDialogState(() {
                            _currentRating = index + 1;
                          });
                        },
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
                        widget.fortune.id, _currentRating ?? 0);
                    setState(() {});
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

      //await Share.shareFiles([filePath], text: 'Falınızı Paylaşın!');
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
          // AppBar yüksekliği kadar boşluk bırakıyoruz
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
                  'Oluşturma Tarihi: ${widget.fortune.createDate}'),
              const SizedBox(height: 6),
              const Divider(color: Colors.grey),
              _infoContainer(widget.fortune.answer ?? 'No answer provided.'),
              const Spacer(),
              if (_currentRating == null)
                OutlinedButton(
                    onPressed: _showRatingDialog,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.white),
                    ),
                    child: const Text(
                      'Puanlamak İster misiniz?',
                      style: TextStyle(color: Colors.white),
                    ),
                  )
              else
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(5, (index) {
                    return Icon(
                      Icons.star,
                      color: index < _currentRating!
                          ? Colors.yellow
                          : Colors.grey,
                    );
                  }),
                ),
              const SizedBox(height: 10),
              OutlinedButton(
                onPressed: _captureAndShareScreenshot,
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                ),
                child: const Text(
                  'Ekran Görüntüsünü Paylaş',
                  style: TextStyle(color: Colors.white),
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
