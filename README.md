# Sapid Labs Core

A slimmed-down Flutter template for experimental apps. No auth, database, subscriptions, or analytics — just the core scaffolding you need to get moving fast.

## What's Included

- **Dependency injection** via `get_it` + `injectable`
- **Routing** via `auto_route`
- **State management** via `signals`
- **Theming** via `flex_color_scheme` (light/dark/system)
- **AI service** (Gemini API integration)
- **Permissions** (camera, location, storage)
- **Shared UI** (loading indicators, responsive layout, app branding widgets)
- **Shared utilities** (color, dialog, navigation, text, time, UI helpers)
- **Fastlane deployment** for iOS and Android
- **Constants** (gaps, paddings, border radii, breakpoints)
- **Code generation** (`build_runner` for routes, DI, JSON serialization)

## Getting Started

Clone the template:

```bash
git clone https://github.com/Sapid-Labs/sapid-labs-core
```

### Rename the app

Search and replace these placeholders:

| Find | Replace with |
|------|-------------|
| `sapid_labs_core` | your_app_name |
| `com.sapidlabs` | com.yourcompany |
| `Sapid Labs` | Your App Name |

### Install & run

```bash
flutter pub get
flutter pub run build_runner build --delete-conflicting-outputs
flutter run
```

Or with a config file:

```bash
flutter run --dart-define-from-file=assets/config.json
```

## Setup Updates

To pull future changes from this template into your project:

```bash
git remote add template https://github.com/Sapid-Labs/sapid-labs-core
git fetch --all
git merge template/main --allow-unrelated-histories
```

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── app/
│   ├── config.dart              # App branding (first file to customize)
│   ├── constants.dart           # Gaps, paddings, breakpoints
│   ├── get_it.dart              # Dependency injection setup
│   ├── router.dart              # Route definitions
│   ├── services.dart            # Global service accessors
│   └── theme.dart               # FlexColorScheme theme config
└── features/
    ├── home/ui/                 # Home page + drawer
    ├── settings/                # Theme mode selector (light/dark/system)
    └── shared/
        ├── services/            # AI, HTTP client, permissions
        ├── ui/                  # Loading indicators, layout, branding
        └── utils/               # Color, dialog, text, time, UI helpers
```

## State Strategy

Global state is managed via `signals`. Services registered in `get_it` manipulate this state. Global signals live in the same file as their corresponding service, prefixed with the service name.

Example: `settingsThemeMode` is defined alongside `SettingsService`.

## Deployment

```bash
# iOS — TestFlight
cd ios && fastlane beta

# iOS — App Store
cd ios && fastlane prod

# Android — Internal/Alpha/Beta/Production
cd android && fastlane internal
cd android && fastlane alpha
cd android && fastlane beta
cd android && fastlane prod
```

## Release Steps

Generate your upload key if you don't already have one:

```bash
keytool -genkey -v -keystore ./keys/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```

## Development

We are all Fool Stack Developers
