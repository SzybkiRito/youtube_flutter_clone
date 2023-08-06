import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/classess/Colors.dart';

class VideoInfoShimmer extends StatelessWidget {
  const VideoInfoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: YoutubeColors().shimmerBackgroundColor,
      highlightColor: YoutubeColors().shimmerHighlightColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
          const SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              const SizedBox(height: 5),
              Container(
                width: 100,
                height: 10,
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }
}
