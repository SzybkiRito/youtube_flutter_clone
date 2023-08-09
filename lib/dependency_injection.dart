import 'package:get_it/get_it.dart';
import 'package:youtube_clone/api/connections/channel_connection.dart';
import 'package:youtube_clone/api/connections/comments_connection.dart';
import 'package:youtube_clone/api/connections/videos_connection.dart';
import 'package:youtube_clone/shared_preference.dart';

void setupDependencyInjection(navigatorKey) {
  GetIt.I.registerLazySingleton<SharedPreference>(() => const SharedPreference());
  GetIt.I.registerLazySingleton<ChannelConnection>(() => ChannelConnection());
  GetIt.I.registerLazySingleton<CommentsConnection>(() => CommentsConnection());
  GetIt.I.registerLazySingleton<VideosConnection>(() => VideosConnection());
}
