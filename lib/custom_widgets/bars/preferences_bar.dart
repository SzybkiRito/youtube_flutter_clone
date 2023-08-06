import 'package:flutter/material.dart';
import 'package:youtube_clone/classess/Colors.dart';

class PreferencesBar extends StatefulWidget {
  const PreferencesBar({super.key});

  @override
  State<PreferencesBar> createState() => _PreferencesBarState();
}

class _PreferencesBarState extends State<PreferencesBar> {
  Map<String, bool> preferences = {
    'Wszystko': false,
    'Muzyka': false,
    'Sport': false,
    'Gry': false,
    'Filmy': false,
    'Wiadomości': false,
    'Live': false,
    'Moda': false,
    'Nauka': false,
    'Technologia': false,
  };

  void resetPreferences() {
    preferences.forEach((key, value) {
      preferences[key] = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: ListView(
          scrollDirection: Axis.horizontal,
          children: preferences.entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(right: 5.0),
              child: TextButton(
                onPressed: () {
                  resetPreferences();
                  setState(() {
                    preferences[entry.key] = !preferences[entry.key]!;
                  });
                },
                style: TextButton.styleFrom(
                  backgroundColor: preferences[entry.key]! ? Colors.white : YoutubeColors().defaultButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                  ),
                  foregroundColor: preferences[entry.key]! ? Colors.black : Colors.white,
                ),
                child: Text(entry.key, style: Theme.of(context).textTheme.labelSmall),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
