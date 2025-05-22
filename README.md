
# Task Manager

A Flutter application for task management, built with Clean Architecture principles. It uses **Drift** for local database management and **BLoC** for state management.

---

## Architecture Overview

The project follows **Clean Architecture**, promoting separation of concerns and scalability. It consists of three main layers:

- **Presentation Layer**: UI components and state management using BLoC.
- **Domain Layer**: Business logic, including entities and use cases.
- **Data Layer**: Data sources and local storage handled with Drift.

---

## Features

- User authentication (sign-in and sign-up)
- Task creation, retrieval, update, and deletion
- Local data persistence with Drift (SQLite)
- State management using BLoC pattern
- Clean, maintainable, and scalable codebase

---

## Getting Started

### Prerequisites

- Flutter SDK
- Dart SDK

### Installation

```bash
git clone https://github.com/Mohammed-Shatara/task-manager.git
cd task-manager
flutter pub get
flutter run
```

---

## Project Structure

```
lib/
├── core/                 # Shared utilities and resources
├── data/                 # Data layer (repositories, models)
│   ├── data_sources/
│   │   ├── auth/
│   │   └── tasks/
│   ├── databases/
│   │   ├── doa/
│   │   │   ├── auth/
│   │   │   └── tasks/
│   │   ├── tables/
│   │   └── app_database
│   ├── models/
│   ├── repositories/
│   └── request/
├── domain/              # Business logic (use cases)
│   ├── repositories
│   └── use_cases/
├── presintation/        # UI and BLoC for tasks
│   ├── flows
│   └── widgets
└── main.dart             # Application entry point
```

---

## Data Layer

### Drift Database

- Uses Drift for local SQLite database.
- Schema includes `users` and `tasks` tables.
- Supports reactive streams for live updates.

### Data Access Objects (DAOs)

#### UserDao

Handles user-related database operations:

- `login(String email, String password)`
- `updateUser(User user)`
- `deleteUser(User user)`
- `createUser(UsersCompanion user)`
- `getUserByEmail(String email)`
- `getUserById(int id)`

#### TaskDao

Handles task-related database operations:

- `createTask(TasksCompanion task)`
- `updateTask(Task task)`
- `deleteTask(Task task)`
- `getTasksForUser(int userId)`
- `getTaskById(int id)`
- `watchAllTasks()`
- `watchTasksWithUsers()` (join query for tasks and their assigned users)

---

## Domain Layer

Contains core business logic and entities.

### Use Cases

- `SignInUseCase` — user login
- `SignUpUseCase` — user registration
- `GetAllTasksUseCase` — fetch all tasks
- `GetSingleTasksUseCase` — fetch all tasks
- `AddTaskUseCase` — add a new task
- `UpdateTaskUseCase` — update a task
- `DeleteTaskUseCase` — delete a task

---

## BLoC / Cubit

Each feature uses either a BLoC or Cubit to manage state transitions and business logic.

---

### 🌐 App BLoC

The `AppBloc` is responsible for managing the global state of the application, such as the user's authentication status, onboarding flow, and user session.

It communicates with other BLoCs (e.g., `AuthBloc`) using `flutter_bloc_mediator`, allowing the app to react to changes like login/logout events without tight coupling between BLoCs.

#### Events (`app_event.dart`)

- `LaunchAppEvent`: Triggered on app startup; checks onboarding and authentication status.
- `SetAppStatusEvent`: Sets the app's authentication status and user data (typically triggered by the `AuthBloc` via `sendTo`).
- `LogoutEvent`: Clears session and resets authentication status.

#### States (`app_state.dart`)

- `isLaunched`: Indicates whether the app has finished its launch logic.
- `isFirstTime`: Tracks if the app is launched for the first time.
- `appStatus`: Represents the authentication status (`Status.authorized` or `Status.unauthorized`).
- `me`: Holds the currently authenticated user's information (`UserModel?`).

#### Mediator Communication (`receive` method)

The `AppBloc` listens for messages from other BLoCs through `flutter_bloc_mediator`:

```dart
@override
void receive(String from, CommunicationType data) {
  switch (data.runtimeType) {
    case const (AppStatus):
      setAppStatus(data as AppStatus);
      break;
  }
}
```
It primarily reacts to AppStatus updates sent from `AuthBloc`:

```dart
sendTo(
AppStatus(data: Status.authorized, userModel: result.data),
BlocMembersNames.appBloc,
);
```
This allows `AuthBloc` to handle the authentication process while `AppBloc` reacts accordingly and updates the app-wide state.

### Launch Logic

When `LaunchAppEvent` is triggered:

- Checks if the app is opened for the first time using `InitAppStore`.
- Verifies if a valid session token exists.
- If authenticated, retrieves the user using `GetUserUseCase`.
- Emits a final state with updated `isLaunched`, `isFirstTime`, and `appStatus`.

### Logout

When `LogoutEvent` is triggered:

- Deletes the stored token via `SessionManager`.
- Emits a state with `appStatus: Status.unauthorized`.

### Architecture Overview

This architecture ensures clean separation of concerns:

- `AuthBloc` focuses on authentication workflows.
- `AppBloc` manages global app lifecycle and reacts to auth changes.
- Both communicate via `flutter_bloc_mediator` for loose coupling.

### AuthBloc

This BLoC handles login and registration workflows using clean architecture principles and the `flutter_bloc_mediator` package for inter-BLoC communication.

#### Events (`auth_event.dart`)

- `SetLoginDataEvent`: Updates login form fields (email, password).
- `SetRegisterDataEvent`: Updates registration form fields (full name, email, password).
- `LoginEvent`: Initiates login process after validation.
- `RegisterEvent`: Initiates registration process after validation.
- `ResetLoginState`: Resets the login state to its initial state.
- `ResetRegisterState`: Resets the register state to its initial state.
- `ResetLoginErrorState`: Clears login errors and resets status.
- `ResetRegisterErrorState`: Clears register errors and resets status.

#### States (`auth_state.dart`)

- `loginState`: Holds login-specific state (email, password, validation status, error, and loading state).
- `registerState`: Holds registration-specific state.
- Uses enums like `PageStatus` to reflect each phase: `init`, `loading`, `success`, `error`.

#### Logic (`auth_bloc.dart`)

- **Form Data Update**: `SetLoginDataEvent` and `SetRegisterDataEvent` update respective form fields in the state.
- **Validation & Submission**:
    - On `LoginEvent`:
        - Validates inputs using `LoginValidatorUseCase`.
        - If valid, calls `LoginUseCase`, persists token, and sends `AppStatus` with `Status.authorized` to `AppBloc`.
        - Emits success or failure states accordingly.
    - On `RegisterEvent`:
        - Similar flow using `RegisterValidatorUseCase` and `RegisterUseCase`.
- **Error and State Reset**:
    - `ResetLoginState` / `ResetRegisterState`: Reset the form to its initial state.
    - `ResetLoginErrorState` / `ResetRegisterErrorState`: Clear errors and reset status to `init`.

#### Mediator Communication

This BLoC uses `flutter_bloc_mediator` to send authentication status to `AppBloc`:

```dart
sendTo(
  AppStatus(data: Status.authorized, userModel: result.data),
  BlocMembersNames.appBloc,
);
```

This keeps BLoCs decoupled yet coordinated, promoting modular and scalable architecture.

---

### TasksCubit

A lightweight state management solution using Cubit from `flutter_bloc` to handle task creation and updates.

#### Features

- Manages form state for creating and updating tasks.
- Emits states such as initial, loading, success, and error.
- Provides reactive updates for task-related UI.

#### File Structure

- `create_task_cubit.dart`: Contains `CreateTaskCubit` managing creation form and submission.
- `create_task_state.dart`: Defines immutable state for task creation.
- `update_task_state.dart`: Defines state for updating existing tasks with validation support.

---

## Dependencies

- [Flutter](https://flutter.dev/)
- [Drift](https://drift.simonbinder.eu/)
- [flutter_bloc](https://bloclibrary.dev/)
- [Equatable](https://pub.dev/packages/equatable)
- [GetIt](https://pub.dev/packages/get_it)
- [flutter_bloc_mediator](https://pub.dev/packages/flutter_bloc_mediator) – Developed and maintained by me to enable decoupled BLoC communication.
 

---

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

---

## License

This project is licensed under the MIT License.
