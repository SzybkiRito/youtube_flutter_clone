import 'package:flutter/material.dart';
import 'package:youtube_clone/classess/Colors.dart';

class SearchField extends StatefulWidget {
  const SearchField({
    super.key,
    required this.onSubmitPressed,
  });
  final Function(String) onSubmitPressed;

  @override
  State<SearchField> createState() => _SearchFieldState();
}

class _SearchFieldState extends State<SearchField> {
  final TextEditingController _searchController = TextEditingController();
  bool _isSearching = false;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _searchController,
      style: const TextStyle(
        color: Colors.white,
      ),
      onChanged: (String value) {
        setState(() {
          _isSearching = value.isNotEmpty;
        });
      },
      onSubmitted: (String value) {
        widget.onSubmitPressed(value);
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: YoutubeColors().defaultButtonColor,
        hintText: 'Search',
        hintStyle: TextStyle(
          color: Colors.white.withOpacity(0.6),
        ),
        border: InputBorder.none,
        suffixIcon: _isSearching
            ? GestureDetector(
                onTap: () {
                  _searchController.clear();
                },
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                ),
              )
            : const SizedBox(),
      ),
    );
  }
}
