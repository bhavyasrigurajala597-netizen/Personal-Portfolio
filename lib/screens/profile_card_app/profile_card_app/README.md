# Profile Card App (Flutter)

A simple profile-card UI demonstrating core Flutter layout widgets.

## Widgets covered
| Widget | Where it's used |
|---|---|
| `AppBar` | Top title bar with a settings icon |
| `CircleAvatar` (circle profile image) | Round profile picture |
| `Text` | Name, bio, stats labels |
| `Container` | Card wrapper, banner background, avatar border |
| `Row` | Social stats (Posts / Followers / Following), Follow/Message buttons |
| `Column` | Overall page layout, card content, stat items |
| `Stack` | Profile image floating over the banner |

## Project structure
```
profile_card_app/
├── pubspec.yaml
└── lib/
    └── main.dart
```

## How to run

1. Make sure Flutter is installed: https://docs.flutter.dev/get-started/install
2. Copy this folder to your machine (or unzip it if you downloaded a zip).
3. From inside the `profile_card_app` folder, run:
   ```bash
   flutter pub get
   flutter run
   ```
4. Pick a connected device/emulator/browser (Chrome works too, e.g. `flutter run -d chrome`).

## Notes
- The profile picture uses a network image (`https://i.pravatar.cc/300?img=12`) so the project runs immediately without needing local assets. Swap the `NetworkImage` for an `AssetImage` if you want to use your own local picture (remember to declare it under `flutter: assets:` in `pubspec.yaml`).
- All widget sections are labeled with comments in `lib/main.dart` so you can map each requirement (AppBar, Stack, Row, etc.) directly to the code.
