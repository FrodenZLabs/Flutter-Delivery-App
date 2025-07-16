# 🚚 Delivery App
Delivery App is a cross-platform mobile application built with Flutter to streamline and simplify local delivery and service scheduling. It provides users with the ability to book, track, and manage delivery services directly from their smartphones.

## 📱 Features
- 📦 **Service Booking**: Schedule deliveries and services with ease.
- 🗺 **Track Deliveries**: View real-time delivery status and updates.
- 🏠 **Saved Delivery Info**: Save frequently used addresses and contact info.
- 👤 **User Profiles**: Manage personal details and preferences.
- 🚘 **Driver Assignment**: Automatically match users with available drivers.
- 🧠 **Offline Support**: Works seamlessly with local cache using Hive.
- 🔒 **Secure Login**: Token-based authentication with persistent sessions.

## 🧱 Technology Stack
- **Frontend**: Flutter (Cross-platform)
- **State Management**: BLoC + Cubit
- **Backend**: Node.js with Express.js (Pluggable)
- **Local Storage**: Hive (for offline support)
- **Network Handling**: Dio / HTTP Client
- **Dependency Injection**: get_it & injectable

## 🎯 Project Purpose
This app is intended to support small-to-medium local delivery services by providing an intuitive digital platform for managing delivery tasks. It's ideal for courier services, local businesses, and freelance delivery agents looking to improve operations.

## 🛠 Installation & Setup
```
  git clone https://github.com/your-username/flutter_delivery_app.git
  cd flutter_delivery_app
  flutter pub get
  flutter run
```
To generate injectable files:
```
flutter pub run build_runner build --delete-conflicting-outputs
```

## 📦 Building for Release
For Android:
```
flutter build apk --release
```
For iOS:
```
flutter build ios --release
```
Make sure to update your app name, icons, and bundle identifiers before building for release.
