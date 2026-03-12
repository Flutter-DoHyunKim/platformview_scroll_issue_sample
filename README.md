# PlatformView Scroll Jank Sample (Add-to-App)

Minimal Add-to-App Flutter sample that reproduces **Android PlatformView scroll jank** on merged platform/UI thread (TLHC mode).

Since Flutter 3.38, the platform/UI thread merge opt-out was removed ([PR #174408](https://github.com/flutter/flutter/pull/174408)), making thread merge the only option. This causes `setOffset()` to trigger expensive `setLayoutParams()` → `requestLayout()` → `draw()` serially within `Choreographer#doFrame`, leading to jank when multiple PlatformViews are present.

## How to run

```bash
flutter run --profile
```

1. App launches with a native Android screen
2. Tap **"Open Flutter PlatformView Test"** to open the Flutter view
3. Scroll the list up and down — frame drops should be visible

## What this reproduces

A `ListView` with 8 `AndroidView` PlatformViews (simulating ad banners) interleaved with regular Flutter widgets. Scrolling causes visible jank because `setOffset()` triggers an expensive `setLayoutParams()` → `requestLayout()` → `draw()` cycle for every visible PlatformView on every frame.

## Structure

```
lib/
  main.dart                   — ListView with 8 AndroidView + regular Flutter cards

android/.../
  NativeMainActivity.kt       — Native Android launcher screen
  activity_native_main.xml    — "Open Flutter PlatformView Test" button
  MainActivity.kt             — FlutterActivity, registers PlatformView factory
  AndroidTextViewFactory.kt   — PlatformViewFactory implementation
  AndroidTextView.kt          — Native view (ImageView + TextView, simulating ad banner)
```

## Environment

- Flutter 3.38+ (platform/UI thread merge opt-out removed)
- Android physical device
- PlatformView mode: TLHC (Texture Layer Hybrid Composition)
- Reproducible with both Impeller and Skia
