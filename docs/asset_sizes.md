# Logo & Splash Icon Size Guide

Export every asset from a single **1024×1024 px master** (SVG or layered source).
All PNGs below are exported from that master — never upscale a smaller file.

---

## 1. App logo (in-app usage)

Provide the logo in 3 raster densities (or one SVG via `flutter_svg`):

| Asset | Size (px) | Used at |
|---|---|---|
| `assets/images/logo.png` | 512 × 512 | base (works for all `Image.asset` uses) |
| `assets/images/2.0x/logo.png` | *(optional)* 1024 × 1024 | high-dpi tablets |

> Flutter picks density variants automatically from `2.0x/`, `3.0x/` subfolders.
> With one 512 px PNG you already cover phones and tablets safely.

### In-app sizing (all devices — use sizer, never fixed px)

```dart
// Splash / login logo: scales with screen width, capped for tablets
SizedBox(
  width: 40.w.clamp(120.0, 220.0),   // 40% of width, min 120, max 220
  child: Image.asset(AppImages.logo),
)
```

| Placement | Recommended size |
|---|---|
| Splash center icon | `40.w`, clamp 120–220 |
| Login / onboarding header | `30.w`, clamp 100–180 |
| App bar logo | `height: 4.h`, clamp 28–40 |

The clamp keeps the logo from becoming huge on tablets/foldables and
unreadably small on compact phones.

---

## 2. Splash screen center icon

### In-app splash (our `SplashScreen` widget)

Center the logo with the sizer rule above (`40.w`, clamped). Because it is
percentage-based it renders correctly on:

| Device class | Screen width | Rendered logo |
|---|---|---|
| Small phone (iPhone SE) | 320 pt | 128 px → clamped 128 |
| Regular phone (Pixel 8) | 412 dp | ~165 |
| Large phone / phablet | 480 dp | ~192 |
| Tablet (iPad 11") | 834 pt | clamped 220 |

### Android 12+ native splash (`windowSplashScreenAnimatedIcon`)

Android crops the icon into a circle — keep artwork inside the safe zone.

| Variant | Canvas | Artwork safe zone |
|---|---|---|
| Icon without background | 288 × 288 dp | ⌀ 192 dp centered |
| Icon with background | 240 × 240 dp | ⌀ 160 dp centered |
| Branding image (optional, bottom) | 200 × 80 dp | — |

Export per density (canvas 288 dp):

| Density | px |
|---|---|
| mdpi | 288 |
| hdpi | 432 |
| xhdpi | 576 |
| xxhdpi | 864 |
| xxxhdpi | 1152 |

### iOS launch screen (LaunchScreen.storyboard)

Use a centered image view, ~30% of screen width, constrained to center X/Y.

| Scale | px (for a 200 pt logo) |
|---|---|
| @1x | 200 |
| @2x | 400 |
| @3x | 600 |

---

## 3. App launcher icons (for reference)

### Android (mipmap)

| Density | Legacy icon | Adaptive icon layer |
|---|---|---|
| mdpi | 48 × 48 | 108 × 108 |
| hdpi | 72 × 72 | 162 × 162 |
| xhdpi | 96 × 96 | 216 × 216 |
| xxhdpi | 144 × 144 | 324 × 324 |
| xxxhdpi | 192 × 192 | 432 × 432 |

Adaptive icon: keep critical artwork inside the center **⌀ 66 dp** safe zone
of the 108 dp canvas (outer ring may be masked/cropped by the launcher).

### iOS

Single **1024 × 1024 px** (no alpha) — Xcode generates all sizes from it.

---

## 4. Tooling

Generate launcher + native splash automatically instead of exporting by hand:

```yaml
dev_dependencies:
  flutter_launcher_icons: ^0.14.0
  flutter_native_splash: ^2.4.0
```

Both take the 1024 px master and emit every size in the tables above.
