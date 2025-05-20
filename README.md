
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

### AuthBloc

Manages authentication state and events following the BLoC pattern.

#### Events (`auth_event.dart`)

- `SignInRequested`: User attempts to sign in with email and password.
- `SignUpRequested`: User attempts to sign up.
- `SignOutRequested`: User signs out.
- `AuthCheckRequested`: Checks if the user is authenticated.

#### States (`auth_state.dart`)

- `AuthInitial`: Initial state before any action.
- `AuthLoading`: Authentication process ongoing.
- `AuthAuthenticated`: User is authenticated.
- `AuthUnauthenticated`: User is not authenticated.
- `AuthFailure`: Authentication failed with an error message.

#### Logic (`auth_bloc.dart`)

- On `SignInRequested`, attempts login with `SignInUseCase`. Emits `AuthAuthenticated` on success or `AuthFailure` on error.
- On `SignUpRequested`, uses `SignUpUseCase` to register a new user.
- On `SignOutRequested`, emits `AuthUnauthenticated`.
- On `AuthCheckRequested`, verifies existing session status.

This separation keeps authentication logic clean, testable, and UI-independent.

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

---

## Contributing

Contributions are welcome! Please fork the repository and submit a pull request.

---

## License

This project is licensed under the MIT License.
