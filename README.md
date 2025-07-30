# LLM to Display

A Flutter application that demonstrates real-time UI modifications using natural language commands. The app allows users to input text commands that dynamically change the layout, colors, and text of the UI components.

## Features

- Dynamic UI modifications through text commands
- Real-time layout updates with smooth animations
- Color scheme changes using natural language
- Text field label customization
- State management using Flutter Bloc (Cubit)

## Prerequisites

Before running this project, make sure you have the following installed:
- **Flutter SDK version 3.32.7** -  !REQUIRED FOR THIS PROJECT !
  - [Download from Flutter SDK Archive](https://docs.flutter.dev/release/archive)
  - Or use FVM (Flutter Version Management): `fvm install 3.32.7`
- A compatible IDE (VS Code, Android Studio, or IntelliJ)
- Git

If you have a different Flutter version installed, you can use Flutter Version Management (FVM) to switch between versions without affecting other projects.

## Getting Started

1. Clone the repository:
```bash
git clone https://github.com/DeTakaki/llmtodisplay.git
cd llmtodisplay
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## Usage Examples

The app responds to natural language commands. Here are some examples:

- "make everything bigger" - Increases button size
- "use dark theme" - Changes to dark color scheme
- "make it colorful" - Applies vibrant colors
- "make it small" - Reduces UI component sizes
- "make it professional" - Applies a business-like appearance

## Project Structure

```
lib/
├── constants/          # App-wide constants
├── core/
│   ├── presentation/  # Shared widgets
│   └── services/      # Core services (LLM)
└── features/
    └── dashboard/
        ├── cubit/     # State management
        └── screens/   # UI screens
```

## Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add some amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## License

This project is licensed under the MIT License - see the LICENSE file for details
