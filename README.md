# Flick - OTT App Prototype

A Flutter-based Over-the-Top (OTT) video streaming application prototype built for Android, featuring a Netflix-style UI with reels-style video navigation.

## Features

### Home Screen
- **Netflix-style Interface**: Vertical scrolling layout with horizontal video carousels
- **Category-based Organization**: Videos organized by genres (Trending, Action, Comedy, Drama, Sci-Fi)
- **Hero Banner**: Featured content display with video information

### Video Player
- **Reels-style Navigation**: Vertical swipe to navigate between videos
- **Auto-play**: Videos start playing automatically
- **Basic Controls**: Play/pause

### Architecture
- **BLoC State Management**: Clean separation of business logic and UI
- **Modular Design**: Organized code structure with separate models, services, and widgets
- **Error Handling**: Comprehensive error handling with user-friendly messages
- **Loading States**: Proper loading indicators throughout the app

## Tech Stack

- **Framework**: Flutter (3.35.0)
- **State Management**: BLoC (flutter_bloc)
- **Video Player Library**: video_player

**Note**: the video player library in the assignment doc: better_player is outdated and not compatible with latest flutter version. Used video_player package instead that has support for latest flutter version
