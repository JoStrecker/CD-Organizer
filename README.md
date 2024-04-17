# music_collection
A flutter App to organize a collection of Vinyl, CDs and co.

## Getting Started
1. Run ``` flutter pub get ``` to install dependencies
2. Create a discogs developer account and register an application: https://www.discogs.com/developers
3. Create an .env file in the project root with the following data:
```
API_KEY=**YOUR_DISCOGS_API_KEY**
API_SECRET=**YOUR_DISCOGS_API_SECRET**
```
4. Run ``` dart run build_runner build --delete-conflicting-outputs ``` to create the env.g.dart file
5. Run the App using ``` flutter run lib/main.dart  ```
