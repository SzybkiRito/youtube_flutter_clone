import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:youtube_clone/classess/colors.dart';

class VideoCommentShimmer extends StatelessWidget {
  const VideoCommentShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Shimmer.fromColors(
              baseColor: YoutubeColors().shimmerBackgroundColor,
              highlightColor: YoutubeColors().shimmerHighlightColor,
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: CircleAvatar(
                  radius: 15,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Shimmer.fromColors(
                      baseColor: YoutubeColors().shimmerBackgroundColor,
                      highlightColor: YoutubeColors().shimmerHighlightColor,
                      child: Container(
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Shimmer.fromColors(
                      baseColor: YoutubeColors().shimmerBackgroundColor,
                      highlightColor: YoutubeColors().shimmerHighlightColor,
                      child: Container(
                        width: 100,
                        height: 10,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Shimmer.fromColors(
                  baseColor: YoutubeColors().shimmerBackgroundColor,
                  highlightColor: YoutubeColors().shimmerHighlightColor,
                  child: Container(
                    width: 100,
                    height: 10,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      color: Colors.grey,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
