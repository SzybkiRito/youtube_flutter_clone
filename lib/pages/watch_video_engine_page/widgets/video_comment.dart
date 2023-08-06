import 'package:flutter/material.dart';

class VideoComment extends StatelessWidget {
  const VideoComment({
    super.key,
    required this.author,
    required this.text,
    required this.likes,
    required this.publishedAt,
    required this.authorThumbnail,
  });
  final String author;
  final String text;
  final String likes;
  final String publishedAt;
  final String authorThumbnail;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(
                  authorThumbnail,
                ),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '@$author',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      '•',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      publishedAt,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.6),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Text(
                    text,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.thumb_up_alt_outlined, color: Colors.white.withOpacity(0.6), size: 15),
                        const SizedBox(width: 5),
                        Text(
                          likes,
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 10),
                    Icon(Icons.comment_outlined, color: Colors.white.withOpacity(0.6), size: 15),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
