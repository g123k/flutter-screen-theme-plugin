# Flutter Screen Theme plugin

This plugin for \[Flutter\](https://flutter.io) adds the ability to change the status bar theme: light or dark (Android and iOS).
It also provides the ability to change the navigation bar theme and color (Android only)

<p align="center">
  <img src="https://raw.githubusercontent.com/g123k/flutter-screen-theme-plugin/master/assets/demo.gif" alt="Demo App" style="margin:auto" width="540" height="960">
</p>


## Getting Started

On iOS only, please add in your Info.plist:
```xml
<key>UIViewControllerBasedStatusBarAppearance</key>
<false/>
```

Then you just have to import the package in your dart files with
```dart
import 'package:screentheme/screentheme.dart';
```

For each call, you can specify which platform you want to target (by default both):
```dart
ScreenTheme.darkStatusBar(platform: Platform.Android);
```

Each call returns a boolean, which is `true` when the platform and the OS version supports the feature.
For the navigation bar, all calls will throw a `MissingPluginException`.

## Status bar

**Compatibility**: Android (6.0+) & iOS
On Android, it will only work with Android 6.0 (Marshmallow) and above devices.


## Navigation bar

**Compatibility**: Android only
Android 5.0 (Lollipop) and above: color
Android 8.0 (Oreo) and above: theme (dark/light)