
# 📱 iTunes Clone - SwiftUI App

A modern SwiftUI-based clone of the iTunes app, showcasing top songs, apps, podcasts, books, and more. This app fetches live data from Apple's open RSS and iTunes Search APIs.

---

## ✨ Features

- 🎵 Browse top **Songs**, **Apps**, **Podcasts**, **Books**, and **Audiobooks**
- 📊 Segmented filters per category (e.g., genres, types)
- 📡 Real-time data fetching from Apple's open APIs
- 🖼 Async image loading with caching
- 🔄 Loading states and error handling
- 📱 Fully responsive SwiftUI layout

---

## 🔗 Public APIs Used

### 1. Apple Marketing RSS Feed

> `https://rss.applemarketingtools.com`

Provides trending and top charts for Apple Music, App Store, Podcasts, and more.

**Example:**
```
https://rss.applemarketingtools.com/api/v2/us/music/most-played/50/songs.json
```

### 2. iTunes Search API

> `https://itunes.apple.com`

Provides detailed search results by media type (music, apps, podcasts, etc.)

**Example:**
```
https://itunes.apple.com/search?term=jack+johnson&entity=musicTrack
```

📖 [Read the official iTunes Search API documentation](https://developer.apple.com/library/archive/documentation/AudioVideo/Conceptual/iTuneSearchAPI/)

---

## 🧱 Architecture

- **SwiftUI** for declarative UI
- **MVVM** (Model-View-ViewModel) pattern
- **Combine** for reactive state management
- **Modular components** for reusable UI and logic
- **Stateless views**, bindable via `@StateObject` or `@ObservedObject`

---

## 🏗 Getting Started

### Requirements

- macOS 13 or later
- Xcode 15 or later
- Swift 5.9+

### Installation

1. Clone the repository

2. Open the project in Xcode

3. Build and run the app

---

## 🚧 Roadmap / TODO

- [ ] Improve loading animations and transitions
- [ ] Add local caching for offline browsing
- [ ] Unit tests for ViewModels and networking
- ...

---

## 🧪 Known Limitations

- Some RSS feeds may not update frequently or be available for certain regions
- Error handling for rate limits and network issues is basic (to be improved)
