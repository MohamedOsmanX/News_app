# NewsApp

A modern Flutter application that lets users browse the latest news headlines and save their favorite articles.

## Features

- **News Feed**: Browse the latest news headlines from around the world
- **Article Viewing**: View detailed articles with images and descriptions
- **Bookmarking**: Save favorite articles for later reading
- **Smooth UI**: Beautiful and responsive user interface with animations
- **Pull to Refresh**: Update news feed with the latest articles
- **Web View**: Open full articles in an integrated in-app browser


## Technologies Used

- **Flutter**: Cross-platform UI framework
- **Riverpod**: State management solution
- **HTTP**: Network requests to fetch news from the API
- **URL Launcher**: In-app web browser for opening articles
- **Intl**: Formatting dates and localization

## Getting Started

### Prerequisites

- Flutter SDK (version 3.7.0 or higher)
- Dart SDK (version 3.0.0 or higher)
- An IDE (Android Studio, VS Code, etc.)

### Installation

1. Clone the repository
   ```
   git clone https://github.com/yourusername/news_app.git
   cd news_app
   ```

2. Install the dependencies
   ```
   flutter pub get
   ```

3. Configure API keys
   ```
   cp lib/config/api_config_sample.dart lib/config/api_config.dart
   ```
   Then edit `lib/config/api_config.dart` to add your own API key.

4. Run the app
   ```
   flutter run
   ```

## API Key

The app uses the [News API](https://newsapi.org/) to fetch headlines.

To get your own API key:
1. Register at [newsapi.org](https://newsapi.org/)
2. Get your API key
3. Add your API key to `lib/config/api_config.dart`

The API configuration file is excluded from version control to protect your API key.

## Project Structure

- `lib/models/` - Data models for the application
- `lib/provider/` - State management using Riverpod
- `lib/screens/` - Main screens of the application
- `lib/services/` - API and other services
- `lib/widgets/` - Reusable UI components
- `lib/config/` - Configuration files including API keys


