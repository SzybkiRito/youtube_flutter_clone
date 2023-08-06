import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/classess/colors.dart';

class PreferencesBarShimmer extends StatefulWidget {
  const PreferencesBarShimmer({super.key});

  @override
  State<PreferencesBarShimmer> createState() => _PreferencesBarShimmerState();
}

class _PreferencesBarShimmerState extends State<PreferencesBarShimmer> {
  Map<String, bool> preferences = {
    'Wszystko': false,
    'Muzyka': false,
    'Sport': false,
    'Gry': false,
    'Filmy': false,
    'Wiadomości': false,
    'Live': false,
    'Moda': false,
    'Nauka': false,
    'Technologia': false,
  };

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: preferences.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: Shimmer.fromColors(
                baseColor: YoutubeColors().shimmerBackgroundColor,
                highlightColor: YoutubeColors().shimmerHighlightColor,
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
