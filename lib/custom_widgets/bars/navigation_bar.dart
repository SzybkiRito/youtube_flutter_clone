import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';
import 'package:youtube_clone/classess/Colors.dart';
import 'package:youtube_clone/pages/search_engine_page/search_engine_page.dart';
import 'package:youtube_clone/providers/user_provider.dart';
import 'package:youtube_clone/services/auth_service.dart';

class TopNavigationBar extends StatefulWidget {
  const TopNavigationBar({super.key});

  @override
  State<TopNavigationBar> createState() => _TopNavigationBarState();
}

class _TopNavigationBarState extends State<TopNavigationBar> {
  IconButton _buildNavigationButton({required VoidCallback onPressed, required Widget icon}) {
    return IconButton(
      onPressed: onPressed,
      icon: icon,
    );
  }

  IconButton _buildAvatarButton({
    required VoidCallback onPressed,
    required String avatarUrl,
  }) {
    return IconButton(
      onPressed: onPressed,
      icon: Provider.of<UserProvider>(context, listen: false).photoUrl.isNotEmpty
          ? CircleAvatar(
              backgroundImage: NetworkImage(avatarUrl),
            )
          : const Icon(
              Icons.account_circle_outlined,
              color: Colors.white,
            ),
    );
  }

  void _showSnackbar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _setAccountData(GoogleSignInAccount gUser) {
    Provider.of<UserProvider>(context, listen: false).setName(gUser.displayName!);
    Provider.of<UserProvider>(context, listen: false).setEmail(gUser.email);
    Provider.of<UserProvider>(context, listen: false).setPhotoUrl(gUser.photoUrl!);
  }

  void _clearAccountData() {
    Provider.of<UserProvider>(context, listen: false).setName('');
    Provider.of<UserProvider>(context, listen: false).setEmail('');
    Provider.of<UserProvider>(context, listen: false).setPhotoUrl('');
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: YoutubeColors().defaultBackgroundColor,
      body: Row(
        children: <Widget>[
          SizedBox(
            height: 150,
            width: 80,
            child: _buildNavigationButton(
              onPressed: () {},
              icon: Image.asset(
                'assets/icons/youtube_logo.png',
              ),
            ),
          ),
          const Spacer(),
          _buildNavigationButton(
            onPressed: () {},
            icon: const Icon(
              Icons.tv,
              color: Colors.white,
            ),
          ),
          _buildNavigationButton(
            onPressed: () {},
            icon: const Icon(
              Icons.notification_add_outlined,
              color: Colors.white,
            ),
          ),
          _buildNavigationButton(
            onPressed: () {
              Get.to(() => const SearchEnginePage(), transition: Transition.zoom);
            },
            icon: const Icon(
              Icons.search,
              color: Colors.white,
            ),
          ),
          _buildAvatarButton(
            onPressed: () {
              if (AuthService().ifUserIsLoggedIn()) {
                AuthService().signOut().then((_) {
                  _clearAccountData();
                  _showSnackbar('You have been logged out');
                });
              } else {
                AuthService().signInWithGoogle().then((GoogleSignInAccount gUser) {
                  _setAccountData(gUser);
                  _showSnackbar('You have been logged in');
                });
              }
            },
            avatarUrl: Provider.of<UserProvider>(context, listen: true).photoUrl,
          ),
        ],
      ),
    );
  }
}
