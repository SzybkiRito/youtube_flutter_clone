import 'package:flutter/material.dart';

class VideoInfo extends StatelessWidget {
  const VideoInfo({
    super.key,
    required this.videoTitle,
    required this.videoViews,
    required this.videoUploadDate,
    required this.numberOfLikes,
  });
  final String videoTitle;
  final String videoViews;
  final String videoUploadDate;
  final String numberOfLikes;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                videoTitle,
                style: Theme.of(context).textTheme.labelLarge,
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {},
                child: const Icon(
                  Icons.arrow_drop_down,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8.0),
          child: Text(
            '$videoViews views • $videoUploadDate',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8.0, right: 8.0),
              child: Column(
                children: [
                  const Icon(
                    Icons.thumb_up,
                    color: Colors.white,
                    size: 20,
                  ),
                  const SizedBox(height: 5),
                  Text(
                    numberOfLikes,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
            const Padding(
              padding: EdgeInsets.only(left: 8.0, right: 8.0),
              child: Icon(
                Icons.thumb_down,
                color: Colors.white,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
