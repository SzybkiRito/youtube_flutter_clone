import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:youtube_clone/pages/main_page/main_page.dart';
import 'package:youtube_clone/theme/theme.dart';

void main() async {
  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: youtubeThemeData,
      home: const MainPage(),
    );
  }
}
