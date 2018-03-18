package fr.g123k.screentheme;

import android.app.Activity;
import android.content.res.Resources;
import android.graphics.Color;
import android.os.Build;
import android.util.Log;
import android.view.View;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/**
 * Screen theme (status bar & navigation bar) Plugin
 */
public class ScreenThemePlugin implements MethodCallHandler {

    private static final String METHOD_CHANNEL_NAME = "g123k/screentheme";

    private final Activity activity;

    public ScreenThemePlugin(Activity activity) {
        this.activity = activity;
    }

    /**
     * Plugin registration.
     */
    public static void registerWith(Registrar registrar) {
        final MethodChannel channel = new MethodChannel(registrar.messenger(), METHOD_CHANNEL_NAME);
        channel.setMethodCallHandler(new ScreenThemePlugin(registrar.activity()));
    }

    @Override
    public void onMethodCall(MethodCall call, Result result) {
        if (call.hasArgument("platform")) {
            String platform = call.argument("platform");
            if (!("android".equalsIgnoreCase(platform) || "both".equalsIgnoreCase(platform))) {
                result.error("PLATFORM", "This call is not for an Android device!", null);
                return;
            }
        }

        if (call.method.equals("changeStatusBarTheme") && call.hasArgument("theme")) {
            String theme = call.argument("theme");
            if ("light".equals(theme)) {
                result.success(lightStatusBar());
            } else if ("dark".equals(theme)) {
                result.success(darkStatusBar());
            } else {
                result.notImplemented();
            }
        } else if (call.method.equals("hasLightStatusBar")) {
            result.success(hasLightStatusBar());
        } else if (call.method.equals("changeNavigationBarTheme") && call.hasArgument("theme")) {
            String theme = call.argument("theme");
            if ("light".equals(theme)) {
                result.success(lightNavigationBar());
            } else if ("dark".equals(theme)) {
                result.success(darkNavigationBar());
            } else {
                result.notImplemented();
            }
        } else if (call.method.equals("hasLightNavigationBar")) {
            result.success(hasLightNavigationBar());
        } else if (call.method.equals("changeNavigationBarColor") && call.hasArgument("red") && call.hasArgument("green") && call.hasArgument("blue")) {
            Object red = call.argument("red");
            Object green = call.argument("green");
            Object blue = call.argument("blue");
            result.success(changeNavigationBarColor(Integer.parseInt(red.toString()), Integer.parseInt(green.toString()), Integer.parseInt(blue.toString())));
        } else if (call.method.equals("hasNavigationBar")) {
            result.success(hasANavigationBar());
        } else {
            result.notImplemented();
        }
    }

    private boolean supportsStatusBarTheming() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.M;
    }

    private boolean hasLightStatusBar() {
        if (supportsStatusBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            return (flags & View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR) != View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
        }
        return true;
    }

    // White status bar = default status bar theme for Android
    private boolean lightStatusBar() {
        if (supportsStatusBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            flags &= ~View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            view.setSystemUiVisibility(flags);
            return true;
        }
        return false;
    }

    // Dark status bar = light status bar theme for Android
    private boolean darkStatusBar() {
        if (supportsStatusBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            flags |= View.SYSTEM_UI_FLAG_LIGHT_STATUS_BAR;
            view.setSystemUiVisibility(flags);
            return true;
        }
        return false;
    }

    // White status bar = default status bar theme for Android
    private boolean hasLightNavigationBar() {
        if (supportsNavigationBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            return (flags & View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR) != View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
        }
        return false;
    }

    private boolean supportsNavigationBarTheming() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.O;
    }

    private boolean lightNavigationBar() {
        if (supportsNavigationBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            flags &= ~View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
            view.setSystemUiVisibility(flags);
            return true;
        }
        return false;
    }

    private boolean darkNavigationBar() {
        if (supportsNavigationBarTheming()) {
            final View view = getView();
            int flags = view.getSystemUiVisibility();
            flags |= View.SYSTEM_UI_FLAG_LIGHT_NAVIGATION_BAR;
            view.setSystemUiVisibility(flags);
            return true;
        }
        return false;
    }

    private boolean supportsNavigationBarColorTheming() {
        return Build.VERSION.SDK_INT >= Build.VERSION_CODES.LOLLIPOP;
    }

    private boolean changeNavigationBarColor(int red, int green, int blue) {
        if (supportsNavigationBarColorTheming()) {
            activity.getWindow().setNavigationBarColor(Color.argb(255, red, green, blue));
            return true;
        }
        return false;
    }

    private boolean hasANavigationBar() {
        final Resources res = activity.getResources();
        int id = res.getIdentifier("config_showNavigationBar", "bool", "android");
        return id > 0 && res.getBoolean(id);
    }

    private View getView() {
        return activity.getWindow().getDecorView();
    }

}
