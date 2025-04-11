# BinaPost Mobile App

The `BinaPost` app is a Flutter-based social media showcase application built with a focus on clean architecture, performance, and visual appeal. This project was developed in response to a developer test and serves as a demonstration of effective MVVM structuring, Firebase integration, media handling, and custom UI implementation.

BinaPost is created entirely in Flutter using `Provider` as the state management solution. The application demonstrates best practices in app architecture, modular folder structure, testing, and user experience.

---

## The Flutter Application

### Mobile App: `BinaPost`

The BinaPost app is developed for Android and iOS using Flutter. 
- **Minimum Android Version:** 6.0 (API 23)
- **Minimum iOS Version:** 11.0

This application showcases Firebase integration, media rendering (image, video, text), and dynamic user interaction.

---

## Getting Started

BinaPost includes all the setup required to build, test, and run the application across platforms. It includes:
- Firebase setup
- Theming support (dark/light)
- Localization structure
- Testing support using Mockito

### How to Use

**Step 1:**
Clone this repository:
```
https://github.com/Peterside07/binapost/
```

**Step 2:**
Install dependencies:
```
flutter pub get
```

---

## BinaPost Features

- Firebase Firestore Integration
- MVVM Architecture with Provider
- Dark Mode / Light Mode Toggle
- Video Player with Scroll Visibility Handling
- Stories-like Horizontal User Layout
- Responsive Design for Android/iOS
- Dialog-Based Profile Viewer
- Custom Theming
- Refreshable Feed
- Unit Tests for ViewModels

---

## Libraries & Tools Used

- [Provider](https://pub.dev/packages/provider) (State Management)
- [Cached Network Image](https://pub.dev/packages/cached_network_image)
- [Video Player](https://pub.dev/packages/video_player)
- [Visibility Detector](https://pub.dev/packages/visibility_detector)
- [Firebase Core, Firestore](https://firebase.google.com)
- [Mockito](https://pub.dev/packages/mockito) (Testing)

> All additional dependencies are listed in `pubspec.yaml`

---

## Folder Structure

Here is the folder structure used in this project:

```
lib/
├── core/
│   ├── config/
│   ├── models/
│   ├── repository/
│   ├── utils/
├── features/
│   ├── post/
│   ├── theme/
│   ├── users/
├── home_page.dart
├── app.dart
├── main.dart
```

### Folder Breakdown

- **models/** – Contains Post and User model classes.
- **viewmodels/** – State logic using ChangeNotifier (e.g., PostViewModel, UserViewModel).
- **views/** – Contains all UI screens including Home, Posts, and Users.
- **widgets/** – Reusable widgets like PostCard, CustomVideoPlayer, etc.
- **theme/** – Light and dark theme setup.
- **core/config/** – App constants, dimensions, and colors.
- **main.dart** – App entry point, routes, theme mode bindings.

---

## Controllers (ViewModels)

```
viewmodels/
|- post_view_model.dart
|- user_view_model.dart
|- theme_view_model.dart
```

---

## Widgets
Reusable components found in:
```
widgets/
|- post_card.dart
|- custom_video_player.dart
```

---

## Testing
Unit tests are included for ViewModels using mock Firebase calls:
```
test/
|- widget_test.dart
```

---

## Main Entry

`main.dart` initializes Firebase, sets up providers, and loads the app with dynamic theme switching support.

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
```

---

## Conclusion

BinaPost is built to demonstrate expertise in clean architecture, Firebase integration, user experience, and production-ready app design. The structure allows for rapid iteration, maintainability, and feature scalability.

Create! 😊