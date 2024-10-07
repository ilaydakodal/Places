# Places

## Requirements
- Xcode 16
- iOS 18.0+
- Swift 5.9

## Comments

- Deep linking functionality may not work as expected after adding the deep linking opener while creating tests. 🥲
- To test deep links, please revert to the commits made before the addition of the tests. This can be done using the following Git command:

  ```bash
  git checkout e7de74a0a8a630ca87518569a8c15e5691f06c5e

- The integration with the Wikipedia app is currently not implemented. Didn't have time to check the current deep/universal linking structure.
- Localization support has not been added yet but is planned for future implementation if time allows.
# App Architecture

The app is built using a modular and testable architecture with a focus on separation of concerns and maintainability. Key architectural components are:

### 1. SwiftUI for UI Layer
The app leverages **SwiftUI** to construct its user interface, providing a declarative and reactive approach for building views. The main view displays a list of locations fetched from a JSON file, presented in a `ListView` with reusable and composable SwiftUI components.

### 2. Model-View-ViewModel (MVVM) Pattern

### 3. Network Layer

### 4. DeepLinkManager
The **DeepLinkManager** handles app-wide deep link routing. It listens for incoming URL schemes and navigates the app to the correct screen, such as directly opening the Places tab with a specified location. The deep linking logic integrates with the app’s navigation to handle custom deep links.

### 5. Dependency Injection
View Model is injected with dependencies like the network manager and the deep link manager. This approach makes the architecture more flexible and testable.

## 6. Testing
The app is designed with unit tests in mind, especially for the ViewModel and DeepLinkManager layers.
