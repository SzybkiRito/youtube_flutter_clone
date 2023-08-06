import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/classess/colors.dart';

class VideoShimmer extends StatelessWidget {
  const VideoShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Shimmer.fromColors(
            baseColor: YoutubeColors().shimmerBackgroundColor,
            highlightColor: YoutubeColors().shimmerHighlightColor,
            child: SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
              width: MediaQuery.of(context).size.width,
              child: Container(
                color: Colors.white,
              ),
            ),
          ),
        ),
        Row(
          children: [
            const SizedBox(
              width: 6,
            ),
            Shimmer.fromColors(
              baseColor: YoutubeColors().shimmerBackgroundColor,
              highlightColor: YoutubeColors().shimmerHighlightColor,
              child: const CircleAvatar(
                radius: 15,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 6.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Shimmer.fromColors(
                      baseColor: YoutubeColors().shimmerBackgroundColor,
                      highlightColor: YoutubeColors().shimmerHighlightColor,
                      child: Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.8,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 6,
                    ),
                    Shimmer.fromColors(
                      baseColor: YoutubeColors().shimmerBackgroundColor,
                      highlightColor: YoutubeColors().shimmerHighlightColor,
                      child: Container(
                        height: 10,
                        width: MediaQuery.of(context).size.width * 0.6,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
