# Seed

A Flutter app built with Clean Architecture and a feature-first module layout.

## Tech stack

- Flutter / Dart
- [GetX](https://pub.dev/packages/get) — state management, dependency injection, routing
- [Dio](https://pub.dev/packages/dio) — HTTP client
- Clean Architecture (per feature: presentation now, data/domain to be added as features are implemented)

## Project structure

```
lib/
├── core/
│   ├── constants/   # colors, spacing, strings, API constants
│   ├── theme/       # ThemeData, typography
│   ├── routes/      # route names + GetPage table
│   ├── utils/       # validators, extensions
│   ├── widgets/     # shared reusable widgets
│   ├── network/     # Dio client, API endpoints
│   ├── errors/      # exceptions (data layer) and failures (domain layer)
│   └── di/          # app-wide GetX bindings
│
├── features/
│   └── <feature>/
│       └── presentation/
│           ├── bindings/    # GetX Bindings — registers the feature's controllers
│           ├── controllers/ # GetxController subclasses
│           └── pages/       # GetView screens
│
└── main.dart
```

Each feature currently ships only its `presentation` layer as routing/DI
scaffolding with no business logic. Add `data/` and `domain/` folders inside
a feature as it's implemented, following the same Clean Architecture split
used by `core/errors` (`exceptions.dart` for data-layer errors, mapped to
`failures.dart` for the domain/presentation layers).

## Getting started

```
flutter pub get
flutter run
```
