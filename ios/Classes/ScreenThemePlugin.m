#import "ScreenThemePlugin.h"

@implementation ScreenThemePlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"g123k/screentheme"
            binaryMessenger:[registrar messenger]];
  ScreenThemePlugin* instance = [[ScreenThemePlugin alloc] init];
  [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    NSDictionary *args = call.arguments;
    NSString *platform = [args objectForKey:@"platform"];

    if (!([@"ios" isEqualToString:platform] || [@"both" isEqualToString:platform])) {
        result(FlutterMethodNotImplemented);
        return;
    }

    if ([@"changeStatusBarTheme" isEqualToString:call.method]) {
        NSString *theme = [args objectForKey:@"theme"];

        if ([@"light" isEqualToString:theme]) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
            result(@YES);
        } else if ([@"dark" isEqualToString:theme]) {
            [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleDefault;
            result(@YES);
        } else {
            result(@NO);
        }
    } else if ([@"hasLightStatusBar" isEqualToString:call.method]) {
        if ([UIApplication sharedApplication].statusBarStyle != UIStatusBarStyleDefault) {
            result(@YES);
        } else {
            result(@NO);
        }
    } else {
        result(FlutterMethodNotImplemented);
    }
}

@end
