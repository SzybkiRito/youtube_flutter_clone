import 'package:flutter/material.dart';
import 'package:youtube_clone/classess/Colors.dart';

class TopNavigationBar extends StatelessWidget {
  const TopNavigationBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: Row(
        children: <Widget>[
          Image.asset('assets/icons/youtube_logo.png'),
          const Spacer(),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tv,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}
