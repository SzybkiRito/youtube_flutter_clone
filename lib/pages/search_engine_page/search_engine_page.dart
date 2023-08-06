import 'package:flutter/material.dart';

class SearchEnginePage extends StatefulWidget {
  const SearchEnginePage({super.key});

  @override
  State<SearchEnginePage> createState() => _SearchEnginePageState();
}

class _SearchEnginePageState extends State<SearchEnginePage> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height,
      child: const Text('SearchEnginePage'),
    );
  }
}
