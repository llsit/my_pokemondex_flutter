# 📱 My Pokemon Dex

A Flutter Pokédex application built with Clean Architecture, Riverpod, and PokeAPI.

This project demonstrates modern Flutter architecture including:
- Clean Architecture (Data / Domain / Presentation)
- Riverpod for State Management & Dependency Injection
- Dio for Networking
- GoRouter for Navigation
- Pagination (Infinite Scroll)
- Pokemon Detail Page
- Hero Animation
- Theming System

---

## 📸 Screenshots
| Pokemon List | Pokemon Detail |
|--------------|----------------|
| Grid View | Stats & Abilities |

---

## 🏗️ Project Architecture

This project uses **Clean Architecture**:

lib/
│
├── core/
│ ├── data/
│ │ └── pokemon_repository.dart
│ ├── di/
│ │ ├── pokemon_provider.dart
│ │ └── pokemon_pagination_provider.dart
│ ├── network/
│ └── pokedex_theme.dart
│
├── features/
│ ├── pokemon_list/
│ │ ├── data/
│ │ │ └── pokemon.dart
│ │ ├── domain/
│ │ │ └── get_pokemon_list_usecase.dart
│ │ └── presentation/
│ │ ├── pokemon_list.dart
│ │ └── pokemon_card.dart
│ │
│ └── pokemon_detail/
│ ├── data/
│ │ └── pokemon_detail_model.dart
│ ├── domain/
│ │ └── get_pokemon_detail_usecase.dart
│ └── presentation/
│ └── pokemon_detail.dart
│
└── main.dart

---

## 🚀 Features

- 📋 Pokemon List (Grid View)
- 🔍 Infinite Scroll Pagination
- 📄 Pokemon Detail Page
- 📊 Base Stats
- 🧬 Abilities
- 🎨 Dynamic Theme Colors
- 🖼 Cached Images
- 🔗 Hero Animation
- 🌐 API Integration (PokeAPI)

---

## 🧠 Tech Stack

| Technology | Usage |
|------------|-------|
| Flutter | UI Framework |
| Riverpod | State Management & DI |
| Dio | Networking |
| GoRouter | Navigation |
| Freezed | Data Models |
| CachedNetworkImage | Image Caching |
| Palette Generator | Extract Pokemon Colors |
| PokeAPI | Pokemon Data |

---

## 🌐 API

This app uses: https://pokeapi.co/

Endpoints used:
- `/pokemon?limit=20&offset=0`
- `/pokemon/{name}`
- `/pokemon-species/{name}` (optional)
- `/evolution-chain/{id}` (optional)

---

## 📦 Installation

```bash
git clone https://github.com/yourusername/my_pokemon_dex.git
cd my_pokemon_dex
flutter pub get
flutter run

---

📚 What I Learned
Clean Architecture in Flutter
Riverpod State Management
Pagination with AsyncNotifier
REST API Integration
JSON Serialization
Modular Feature Structure
Hero Animations
Theming System

📄 License

This project is for educational and portfolio purposes.