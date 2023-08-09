import 'package:flutter/material.dart';
import 'package:youtube_clone/custom_widgets/fields/search_field.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.onSearchPressed});
  final Function(String)? onSearchPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            SizedBox(
              width: 30,
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_sharp,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: SearchField(
                onSubmitPressed: (String value) {
                  if (onSearchPressed != null) {
                    onSearchPressed!(value);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
