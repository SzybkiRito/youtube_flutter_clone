import 'package:flutter/material.dart';

class VideoItem extends StatelessWidget {
  const VideoItem({
    super.key,
    required this.title,
    required this.channelName,
    required this.views,
    required this.uploadDate,
    required this.duration,
    required this.miniatureImageSrc,
    required this.channelImageSrc,
  });
  final String title;
  final String channelName;
  final String views;
  final String uploadDate;
  final String duration;
  final String miniatureImageSrc;
  final String channelImageSrc;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Stack(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: 309,
                child: Image.network(
                  miniatureImageSrc,
                  loadingBuilder: (BuildContext context, Widget widget, ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return widget;
                    }

                    return const SizedBox();
                  },
                ),
              ),
              Positioned(
                bottom: 10,
                right: 10,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    duration,
                    style: Theme.of(context).textTheme.labelMedium,
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              const SizedBox(
                width: 6,
              ),
              CircleAvatar(
                radius: 15,
                backgroundImage: NetworkImage(channelImageSrc),
              ),
              Expanded(
                child: ListTile(
                  title: Text(
                    title,
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Text(
                    '$channelName • $views • $uploadDate',
                    style: Theme.of(context).textTheme.labelMedium,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
