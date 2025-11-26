# Medijobs Connect

## Project Overview

_Medijobs Connect_ is a mobile application developed using Flutter that aims to connect users with opportunities in the medical and healthcare sector. The application provides personalized job recommendations, scholarship opportunities, entrepreneurship resources, and a professional networking platform powered by Firebase.

| Feature            | Status                 | Details                                                 |
| :----------------- | :--------------------- | :------------------------------------------------------ |
| _Platform_         | Mobile (iOS & Android) | Built with Flutter 3.x                                  |
| _Backend_          | Firebase               | Firestore (Database), Authentication (Sign-in)          |
| _State Management_ | Provider               | Used for efficient state handling across layers         |
| _Authentication_   | Dual Method            | Email/Password (with OTP/Verification) & Google Sign-in |

---

## Technical Architecture

The application is structured following _Clean Architecture_ principles to separate the presentation, business logic, and data layers.

### Code Structure

The lib folder is organized to enforce separation of concerns:

```
lib
├── app/        # User-facing screens and flow logic (Presentation)
├── components/ # Reusable stateless UI widgets (Presentation)
├── data/       # Data sources (Firebase implementation) and repository contracts (Data)
├── models/     # Data structures/Entities (Domain)
├── providers/  # Business logic, state management (Domain/Presentation Bridge)
├── utils/      # Helper functions, e.g., job matching algorithms (Domain)
└── tests/      # Unit and Widget tests (Testing)
```

### State Management (Provider)

We use the _Provider_ package for state management. This approach ensures:

- _Separation:_ Business logic resides in Provider classes, keeping widgets clean and focused purely on UI.
- _Efficiency:_ Selective rebuilding of widgets based on state changes.

---

## Getting Started

Follow these steps to get the Medijobs Connect mobile application running on your local machine.

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (Version 3.x or higher)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- A physical device or emulator running _Android or iOS_.

### 1. Cloning the Repository

```bash
git clone [FILL IN YOUR PUBLIC GITHUB URL HERE]
cd medijobs_connect
```

### 2. Dependency Installation

```bash
flutter pub get
```

### 3. Firebase Configuration

- Set up a new Firebase project in the Firebase Console.

- Enable Firestore and `Email/Password` and Google sign-in methods in Authentication.

- Add the generated platform-specific configuration files (google-services.json/GoogleService-Info.plist).

- `The lib/firebase_options.dart` file should be generated automatically by the `FlutterFire CLI`.

### 4. Running the App

Note: The assignment requires running on a mobile device/emulator.

```bash
flutter run
```

# 5. Security and Quality

## Authentication Methods

Email/Password: Implemented with secure hashing and Email Verification/OTP flow.
Google Sign-in: Integrated using the platform-specific Firebase SDK.

## Firestore Security Rules

Access to data is strictly controlled by user authentication and data ownership. (A detailed explanation of the rules is included in the final report.)

## Code Quality

Testing: Comprehensive Widget Tests and Unit Tests have been implemented and pass successfully.

Zero Warnings: The codebase passes flutter analyze with zero warnings or issues.

Formatting: The entire codebase has been formatted using dart format ..

### Collaboration and Contributions

Detailed records of group members, their roles, and specific contributions are maintained in the separate [CONTRIBUTORS.md](CONTRIBUTORS.md) file.
