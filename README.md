# Flick - OTT App Prototype

A Flutter-based Over-the-Top (OTT) video streaming application prototype built for Android, featuring a Netflix-style UI with reels-style video navigation.

## Features

### 🏠 Home Screen
- **Netflix-style Interface**: Vertical scrolling layout with horizontal video carousels
- **Category-based Organization**: Videos organized by genres (Trending, Action, Comedy, Drama, Sci-Fi)
- **Hero Banner**: Featured content display with video information
- **Pull-to-Refresh**: Refresh content by pulling down
- **Search & Profile**: Navigation icons for future functionality

### 🎬 Video Player
- **Reels-style Navigation**: Vertical swipe to navigate between videos
- **Auto-play**: Videos start playing automatically
- **Custom Controls**: Play/pause, next/previous, like/dislike, share
- **Full-screen Support**: Landscape mode support
- **Smooth Transitions**: Seamless video switching

### 🏗️ Architecture
- **BLoC State Management**: Clean separation of business logic and UI
- **Modular Design**: Organized code structure with separate models, services, and widgets
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Loading States**: Proper loading indicators throughout the app

## Tech Stack

- **Framework**: Flutter (Latest stable version)
- **State Management**: BLoC (flutter_bloc)
- **Video Player**: better_player
- **Network**: Dio (for future API integration)
- **Image Loading**: cached_network_image
- **Testing**: Integration tests, unit tests with bloc_test and mocktail

## Project Structure

```
lib/
├── bloc/                    # BLoC state management
│   ├── home_bloc.dart
│   └── video_player_bloc.dart
├── models/                  # Data models
│   ├── video_content.dart
│   ├── category.dart
│   └── app_state.dart
├── screens/                 # Main screens
│   ├── home_screen.dart
│   └── video_player_screen.dart
├── widgets/                 # Reusable widgets
│   ├── hero_banner.dart
│   ├── category_carousel.dart
│   ├── video_player_page.dart
│   └── loading_widget.dart
├── services/                # Data services
│   └── data_service.dart
├── utils/                   # Utility classes
│   └── error_handler.dart
└── main.dart               # App entry point

assets/
├── data/
│   └── mock_data.json      # Mock video data
└── images/                 # App images

test/                       # Unit tests
├── bloc/
├── models/
└── services/

integration_test/           # Integration tests
└── app_test.dart
```

## Getting Started

### Prerequisites
- Flutter SDK (latest stable version)
- Android Studio / VS Code
- Android device or emulator

### Installation

1. **Clone the repository**
   ```bash
   git clone <repository-url>
   cd flick_assignment
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Generate code (for JSON serialization)**
   ```bash
   flutter packages pub run build_runner build
   ```

4. **Run the app**
   ```bash
   flutter run
   ```

### Running Tests

**Unit Tests**
```bash
flutter test
```

**Integration Tests**
```bash
flutter test integration_test/
```

## Key Features Implementation

### 1. Netflix-style Home Screen
- Implemented using `CustomScrollView` with `SliverAppBar` and `SliverToBoxAdapter`
- Horizontal scrolling carousels using `ListView.builder`
- Hero banner with gradient overlay and video information
- Responsive design with proper spacing and typography

### 2. Reels-style Video Player
- `PageView` with vertical scroll direction for video navigation
- `BetterPlayer` integration for video playback
- Custom controls overlay with gesture detection
- Auto-play functionality with proper state management

### 3. State Management
- **HomeBloc**: Manages home screen state and data loading
- **VideoPlayerBloc**: Handles video player state and navigation
- Clean separation of concerns with proper event handling

### 4. Data Management
- Mock JSON data with realistic video content
- `DataService` for data operations
- Support for categories, trending videos, and search functionality

### 5. Error Handling
- `ErrorHandler` utility for consistent error management
- User-friendly error messages
- Retry mechanisms for failed operations
- Proper loading states throughout the app

## Customization

### Adding New Video Content
1. Update `assets/data/mock_data.json`
2. Add new categories or videos following the existing structure
3. The app will automatically load the new content

### Styling
- Theme configuration in `main.dart`
- Color scheme: Dark theme with red accent color
- Custom text themes for better readability

### Adding New Features
- Follow the existing BLoC pattern for new features
- Add corresponding tests for new functionality
- Update integration tests for new user flows

## Performance Considerations

- **Image Caching**: Using `cached_network_image` for efficient image loading
- **Lazy Loading**: Videos and images load as needed
- **Memory Management**: Proper disposal of video controllers
- **State Optimization**: Minimal rebuilds with proper BLoC usage

## Future Enhancements

- [ ] User authentication and profiles
- [ ] Search functionality
- [ ] Watchlist and favorites
- [ ] Offline video support
- [ ] Push notifications
- [ ] Analytics integration
- [ ] API integration for real data
- [ ] Chromecast support
- [ ] Download functionality

## Testing

The app includes comprehensive testing:

- **Unit Tests**: BLoC logic, models, and services
- **Integration Tests**: End-to-end user flows
- **Widget Tests**: Individual component testing

Run all tests:
```bash
flutter test
```

## Contributing

1. Follow the existing code structure and patterns
2. Add tests for new functionality
3. Update documentation as needed
4. Ensure all tests pass before submitting

## License

This project is created as an assignment for interview purposes.

---

**Note**: This is a prototype application built for demonstration purposes. For production use, additional considerations like security, performance optimization, and real API integration would be required.
