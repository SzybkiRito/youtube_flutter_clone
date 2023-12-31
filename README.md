# Flutter youtube clone

This is clone of youtube application made in flutter, this is not fully functional due to youtube. 
This project is still in progress.

# Packages

| Package               | Version |
| --------------------- | ------- |
| flutter_svg           | 2.0.5   |
| flutter_dotenv        | 5.1.0   |
| http                  | 1.1.0   |
| shimmer               | 3.0.0   |
| youtube_player_iframe | 4.0.4   |
| webview_flutter       | 4.2.2   |
| provider              | 6.0.5   |
| shared_preferences    | 2.2.0   |
| get                   | NEWEST  |
| get_it                | 7.6.0   |
| firebase_core         | 2.15.1  |
| google_sign_in        | 6.1.4   |
| firebase_auth         | 4.7.3   |

## Installation

Before you start work on this project you will need to create .env file in root directory.
.env

```
GOOGLE_API_KEY=
```

Build & Run project
Before you try to run this project you need to configure firebase on your PC.

```bash
    cd youtube_clone
    flutter pub get
    flutterfire configure
    flutter run
```

## Roadmap

- ~~Add posibility to login using Youtube OAUTH~~
- Add functionality to likes button and comments button
- ~~Add Search Bar~~
- Find different aproach to show youtube videos than flutter_webview
- Add flutter localizations to the project

## Screenshots

![image](https://github.com/SzybkiRito/youtube_flutter_clone/assets/43932238/fd3bd5f1-01b6-4a3c-b9e9-cdd1e4b13237)
![image](https://github.com/SzybkiRito/youtube_flutter_clone/assets/43932238/103a0d04-d4fd-4c3b-a784-ef19ec16d749)
![image](https://github.com/SzybkiRito/youtube_flutter_clone/assets/43932238/9a229962-17c8-4c26-a83e-51c50f68baf9)


## License

[MIT](https://choosealicense.com/licenses/mit/)
