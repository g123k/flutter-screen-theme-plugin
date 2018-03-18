import 'dart:async';
import 'dart:ui';

import 'package:flutter/services.dart';

class Platform {
  final _value;
  const Platform._internal(this._value);
  toString() => '$_value';

  static const Android = const Platform._internal('android');
  static const iOS = const Platform._internal('ios');
  static const both = const Platform._internal('both');
}

class ScreenTheme {
  static const MethodChannel _channel =
      const MethodChannel('g123k/screentheme');

  /// Will return true only if the status bar was changed
  /// On Android 6.0, the status bar items will become black
  static Future<bool> lightStatusBar({Platform platform = Platform.both}) =>
      _channel.invokeMethod('changeStatusBarTheme',
          {'theme': 'light', 'platform': platform.toString()});

  /// Will return true only if the status bar was changed
  /// On Android 6.0, the status bar items will become white
  static Future<bool> darkStatusBar({Platform platform = Platform.both}) =>
      _channel.invokeMethod('changeStatusBarTheme',
          {'theme': 'dark', 'platform': platform.toString()});

  static Future<bool> hasALightStatusBar({Platform platform = Platform.both}) =>
      _channel
          .invokeMethod('hasLightStatusBar', {'platform': platform.toString()});

  static Future<bool> hasANavigationBar({Platform platform = Platform.both}) =>
      _channel
          .invokeMethod('hasNavigationBar', {'platform': platform.toString()});

  /// Change the navigation bar color on Android only
  /// iOS: Will throw a PlatformException
  /// Android: Will only works on Android 5.0+
  static Future<bool> updateNavigationBarColor(Color color,
          {Platform platform = Platform.both}) =>
      _channel.invokeMethod('changeNavigationBarColor', {
        'red': color.red,
        'blue': color.blue,
        'green': color.green,
        'platform': platform.toString()
      });

  /// Will return true only if the status bar was changed (only works on Android 8.0+)
  static Future<bool> lightNavigationBar({Platform platform = Platform.both}) =>
      _channel.invokeMethod('changeNavigationBarTheme',
          {'theme': 'light', 'platform': platform.toString()});

  /// Will return true only if the status bar was changed (only works on Android 8.0+)
  static Future<bool> darkNavigationBar({Platform platform = Platform.both}) =>
      _channel.invokeMethod('changeNavigationBarTheme',
          {'theme': 'dark', 'platform': platform.toString()});

  static Future<bool> hasALightNavigationBar(
          {Platform platform = Platform.both}) =>
      _channel.invokeMethod(
          'hasLightNavigationBar', {'platform': platform.toString()});
}
