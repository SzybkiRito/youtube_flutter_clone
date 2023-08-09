import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/classess/Colors.dart';
import 'package:youtube_clone/custom_widgets/bars/search_bar.dart';
import 'package:youtube_clone/pages/main_page/main_page.dart';
import 'package:youtube_clone/providers/search_provider.dart';
import 'package:youtube_clone/shared_preference.dart';

class SearchEnginePage extends StatefulWidget {
  const SearchEnginePage({super.key});

  @override
  State<SearchEnginePage> createState() => _SearchEnginePageState();
}

class _SearchEnginePageState extends State<SearchEnginePage> {
  List<String> lastSearches = [];

  Future<void> setLastSearches() async {
    SharedPreference sharedPreference = GetIt.I<SharedPreference>();
    List<String> lastSearches = await sharedPreference.getLastSearches();

    setState(() {
      this.lastSearches = lastSearches;
    });
  }

  Future<void> saveNewSearch(String query) async {
    SharedPreference sharedPreference = GetIt.I<SharedPreference>();
    List<String> lastSearches = await sharedPreference.getLastSearches();

    if (lastSearches.contains(query)) {
      lastSearches.remove(query);
    }

    lastSearches.insert(0, query);

    await sharedPreference.setLastSearches(lastSearches);
  }

  Future<void> deleteSearch(int index) async {
    SharedPreference sharedPreference = GetIt.I<SharedPreference>();
    List<String> lastSearches = await sharedPreference.getLastSearches();
    lastSearches.removeAt(index);
    sharedPreference.setLastSearches(lastSearches);
    setLastSearches();
  }

  @override
  void initState() {
    super.initState();
    setLastSearches();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: SafeArea(
        child: Column(
          children: [
            CustomSearchBar(
              onSearchPressed: (String value) {
                saveNewSearch(value);
                Provider.of<SearchProvider>(context, listen: false).setSearchQuery(value);
                Get.to(
                  () => const MainPage(
                    defaultIndex: 0,
                  ),
                  transition: Transition.zoom,
                );
              },
            ),
            Expanded(
              child: ListView.builder(
                itemCount: lastSearches.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Provider.of<SearchProvider>(context, listen: false).setSearchQuery(lastSearches[index]);
                      Get.to(
                        () => const MainPage(
                          defaultIndex: 0,
                        ),
                        transition: Transition.zoom,
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.8,
                            child: Text(
                              lastSearches[index],
                              style: Theme.of(context).textTheme.labelLarge,
                            ),
                          ),
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              deleteSearch(index);
                            },
                            icon: const Icon(
                              Icons.delete,
                              color: Colors.white,
                              size: 16.0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
