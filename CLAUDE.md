# CLAUDE.md

This file provides guidance to Claude Code when working with code in this repository.

## Project Overview

This is **Sapid Labs Core** (package name: `sapid_labs_core`) — a slimmed-down Flutter template for experimental apps. No auth, database, subscriptions, or analytics — just the core scaffolding needed to build fast.

**Company**: Sapid Labs — "tasteful software"

Key capabilities:
- **Dependency injection**: get_it + injectable
- **Routing**: auto_route with declarative route definitions
- **State management**: Signals for reactive global state
- **Theming**: FlexColorScheme with light/dark/system toggle
- **AI integration**: Gemini API service
- **Permissions**: Camera, location, storage via permission_handler
- **Deployment**: Fastlane for iOS (TestFlight, App Store) and Android (internal, alpha, beta, production)

## Build & Development Commands

### Core Commands
```bash
# Install dependencies
flutter pub get

# Run code generation for auto_route, injectable, and json_serializable
flutter pub run build_runner build --delete-conflicting-outputs

# Clean build artifacts
flutter clean

# Run the app
flutter run

# Run with config file
flutter run --dart-define-from-file=assets/config.json
```

### Testing & Deployment
```bash
# Run tests
flutter test

# iOS — TestFlight
cd ios && fastlane beta

# iOS — App Store (submit for review)
cd ios && fastlane prod

# Android — Internal test track
cd android && fastlane internal

# Android — Alpha test track
cd android && fastlane alpha

# Android — Beta test track
cd android && fastlane beta

# Android — Production
cd android && fastlane prod
```

### Template Updates
```bash
# Fetch and merge updates from the template repository
git fetch template
git merge template/main --allow-unrelated-histories
```

## Architecture

### State Management Strategy
- **Global State**: Managed via signals from the `signals` package
- **Global Signals**: Located in the same file as their corresponding service, prefixed with service name
  - Example: `settingsThemeMode` is defined in `lib/features/settings/services/settings_service.dart`
- **Services**: Registered with `get_it` and `injectable`, accessed via global getters in `lib/app/services.dart`
  - Example: `aiService`, `settingsService`, `permissionService`

### Dependency Injection
- Uses `get_it` with `injectable` for dependency registration
- Services are decorated with:
  - `@Singleton()` for single instance services
  - `@LazySingleton()` for lazily initialized services
  - `@Injectable()` for regular services
- Configuration happens in `lib/app/get_it.dart` with `configureDependencies()`
- Services are accessed via global getters in `lib/app/services.dart`

### Routing
- Uses `auto_route` for declarative routing
- Router configuration: `lib/app/router.dart`
- Generated routes: `lib/app/router.gr.dart` (auto-generated, don't edit manually)
- Navigation: Use `router.push()`, `router.pop()`, etc.

### Feature Organization
Each feature follows this structure:
```
lib/features/{feature_name}/
  ├── models/          # Data models with json_serializable
  ├── services/        # Business logic and state (with signals)
  ├── ui/              # Views and widgets
      └── widgets/     # Feature-specific widgets
  └── utils/           # Feature-specific utilities
```

Current features: `home`, `settings`, `shared`

### Shared Resources
- **UI Components**: `lib/features/shared/ui/` contains reusable widgets:
  - `app_logo.dart`, `app_name.dart`, `app_version.dart`
  - `loading_indicator.dart`, `loading_overlay.dart`, `loading_stack.dart`
  - `phone_number_text_field.dart`, `layout.dart`
- **Utilities**: `lib/features/shared/utils/` contains helper functions
- **Services**: `lib/features/shared/services/` contains cross-cutting concerns (AI, permissions, HTTP client)

## Code Style & Conventions

- Use Signals for state management (not setState, Provider, Bloc, etc.)
- Use auto_route for routing (`lib/app/router.dart`)
- Use get_it and injectable for service registration (`lib/app/services.dart`)
- Use constant gaps instead of SizedBox (e.g., `gap16`, `gap24` from `lib/app/constants.dart`)
- Don't use underscores in function or variable names

### Spacing Constants
Available gap constants from `lib/app/constants.dart`:
- `gap4`, `gap8`, `gap12`, `gap16`, `gap24`, `gap32`, `gap48`, `gap64`
- Also: `smallerGap`, `smallGap`, `gap`, `largeGap`, `largerGap`, `largestGap`

Available padding constants:
- `padding8`, `padding12`, `padding16`, `padding24`, `padding36`
- Directional: `paddingH8`, `paddingV8`, `paddingH16`, `paddingV16`, `paddingH24`, `paddingV24`

### Code Generation
After modifying:
- Routes in `router.dart` → Run build_runner to update `router.gr.dart`
- Services with `@injectable` → Run build_runner to update `get_it.config.dart`
- Models with `@JsonSerializable` → Run build_runner to update `*.g.dart` files

## App Configuration

Edit `lib/app/config.dart` for:
- App name and branding (defaults to "Sapid Labs" — replace per child app)
- Social media usernames

This is the first file to customize when creating a new child app from the template.

## Claude Skills

Available skills for working with this template:

| Skill | Purpose |
|---|---|
| `/sapid-feature` | Create a complete feature with models, services, UI, and routing |
| `/sapid-model` | Create Dart model classes with JSON serialization |
| `/sapid-service` | Create service classes with backend integration and DI |
| `/sapid-route` | Create routes and connect them to the app router |
| `/sapid-deploy` | Commands and instructions for deploying to production |
| `/sapidify` | Update existing files to follow Sapid Labs conventions |

## Key Files

- `lib/main.dart`: App entry point — configures dependencies, sets up theme and routing
- `lib/app/router.dart`: Route definitions
- `lib/app/services.dart`: Global service accessors (e.g., `aiService`, `settingsService`)
- `lib/app/get_it.dart`: Dependency injection configuration
- `lib/app/constants.dart`: UI constants (gaps, paddings, borders, breakpoints)
- `lib/app/config.dart`: App configuration and branding (first file to customize per child app)
- `lib/app/theme.dart`: Theme configuration (uses FlexColorScheme)
