import 'package:flutter/material.dart';
import 'package:social_share/social_share.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Twitter Share Example'),
        ),
        body: Center(
          child: ElevatedButton(
            onPressed: () {
              SocialShare.shareTwitter(
                "Hello, Twitter! This is a test tweet.",
                hashtags: ["Flutter", "SocialShare"],
                url: "https://example.com",
                trailingText: "Check it out!",
              ).then((data) {
                print("Twitter Response: $data");
              });
            },
            child: Text("Share on Twitter"),
          ),
        ),
      ),
    );
  }
}
// ElevatedButton(
//             child: Text("Twitter'da Paylaş"),
//             onPressed: () async {
//               String message = "Hello, Twitter!";
//               String url = "https://twitter.com/intent/tweet?text=$message";
//               if (await canLaunch(url)) {
//                 await launch(url);
//               } else {
//                 print("URL açılamadı.");
//               }
//             },
//           ),