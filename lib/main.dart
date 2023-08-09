import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/dependency_injection.dart';
import 'package:youtube_clone/pages/main_page/main_page.dart';
import 'package:youtube_clone/providers/search_provider.dart';
import 'package:youtube_clone/theme/theme.dart';

void main() async {
  await dotenv.load();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  MyApp({super.key}) {
    setupDependencyInjection(navigatorKey);
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => SearchProvider()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Demo',
        theme: youtubeThemeData,
        home: const MainPage(),
      ),
    );
  }
}
