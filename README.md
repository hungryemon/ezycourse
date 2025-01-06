# ezycourse

# Getting Started

## Prerequisites

Ensure you have the following installed on your development environment:

- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- Dart (comes with Flutter)
- Android Studio or Visual Studio Code with Flutter plugins
- A connected device or emulator for running the app

## Setup

1. Clone the repository:
   ```bash
   git clone https://github.com/hungryemon/ezycourse.git
   cd ezycourse
    ```
2. Get Dependencies:
  ```bash
  flutter pub get
  ```
### For ios
  ```bash
  cd ios
  ```
then,
  ```bash
  pod install
  ```

3. Rune the Appp:
  ```bash
  flutter run
  ```

## Project Structure
```
|-- lib
    |-- main.dart
    |-- main_dev.dart
    |-- app
        |-- base
        |-- bindings
        |-- flavors
        |-- helpers
        |-- routes
        |-- theme
        |-- widgets
        |-- app.dart
    |-- core
        |-- network
        |-- storage
    |-- features
        |-- auth
            |-- data
            |-- domain
            |-- presentation
        |-- feeds
        |-- post
        |-- splash
   
```
