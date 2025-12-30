# Movie App

A comprehensive iOS Movie application built with SwiftUI, designed to help users discover, search, and manage their favorite movies.

## 📱 Features

- **Authentication**: Secure user signup and login powered by Firebase Auth.
- **Home Feed**: Browse trending and popular movies with a beautiful UI.
- **Movie Details**: detailed view of movie information.
- **Search**: Search for movies by title.
- **Favorites**: Save your favorite movies for quick access.
- **Downloads**: Manage downloaded content (if applicable).
- **Tab Bar Navigation**: Seamless navigation between Home, Search, Downloads, and Profile.

## 🛠 Tech Stack

- **Language**: Swift
- **UI Framework**: SwiftUI
- **Architecture**: MVVM (Model-View-ViewModel)
- **Backend & Auth**: Firebase (Auth, Firestore)
- **Concurrency**: Swift Async/Await
- **Dependency Management**: Swift Package Manager (SPM)

## 🚀 Getting Started

### Prerequisites

- Xcode 15+
- iOS 16.0+

### Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/y0ussefmohamed/Movie.git
   cd Movie
   ```

2. **Open in Xcode**
   Open the `Movie.xcodeproj` file.

3. **Firebase Setup**

   - Ensure you have a valid `GoogleService-Info.plist` in the project root.
   - If missing, create a new Firebase project and download the configuration file.

4. **Run the App**
   Select your target simulator or device and press `Cmd + R`.
