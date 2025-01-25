# Yuva Again

Yuva Again is a Flutter application developed for senior citizens to help them conduct voice/video calls, find events near them, and play games. The app aims to provide an easy-to-use interface for seniors to stay connected and engaged.

## Overview

The Yuva Again app includes the following features:
- **Voice/Video Calls**: Users can join voice and video calls through various channels.
- **Events**: Users can find and participate in events happening near them.
- **Games**: Users can play games to stay entertained and mentally active.

## Project Structure
.gitignore
.metadata
analysis_options.yaml
android/
assets/
ios/
lib/
  firebase_options.dart
  main.dart
  models/
  screens/
  services/
  utils/
  widgets/
pubspec.lock
pubspec.yaml
README.md
test/

## Getting Started

### Prerequisites

Ensure you have the following installed:
- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter
- Android Studio or Xcode: For running the app on Android or iOS devices

### Installation

1. Clone the repository:
```sh
git clone https://github.com/your-repo/yuva_again.git
cd yuva_again
```


2. Install dependencies:

```sh
flutter pub get
```

3. Set up Firebase:

Follow the instructions to set up Firebase for your Flutter app: Firebase Setup(https://firebase.flutter.dev/docs/overview)
Add your google-services.json for Android in android/app and ios/Runner/GoogleService-Info.plist for iOS in ios/Runner

### Running the App

Run the app on an emulator or physical device:
```sh
flutter run
```

### Building the App
To build the app for release, use the following commands:

Android:

```sh
flutter build apk
```

### Contributing
Contributions are welcome! Please open an issue or submit a pull request for any improvements or bug fixes.
