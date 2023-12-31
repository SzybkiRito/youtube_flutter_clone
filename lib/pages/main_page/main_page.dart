import 'package:flutter/material.dart';
import 'package:youtube_clone/classess/Colors.dart';
import 'package:youtube_clone/custom_widgets/bars/navigation_bar.dart';
import 'package:youtube_clone/pages/home_page/home_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({
    super.key,
    this.defaultIndex,
  });
  final int? defaultIndex;

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Widget> listOfPages = [
    const HomePage(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(60.0),
        child: SafeArea(
          child: TopNavigationBar(),
        ),
      ),
      body: listOfPages[widget.defaultIndex ?? 0],
    );
  }
}
