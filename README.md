# Immersive Commerce App - Web 3.0

## Overview

Welcome to the Immersive Commerce mobile app project! This app is designed to provide users with a seamless experience in browsing and interacting with products from our decentralized marketplace. Developed using Flutter, this app incorporates key features such as product listing, detailed product information, user registration and login, favorites management, and user profile management.

## Requirements

### 1. Product Listing Screen

- Display a list of products fetched from a mock API.
- Utilize the [FakeStoreAPI](https://fakestoreapi.com/) or any alternative API.
- Each product entry should include its name, price, and an image.

### 2. Navigation Mechanism

- Implement a navigation mechanism allowing users to tap on a product to view its details.

### 3. Product Detail Screen

- Develop a detailed product information screen.
- Include additional information such as description, specifications, and user reviews.

### 4. Cross-Platform Compatibility

- Ensure the app is responsive and works seamlessly on both iOS and Android devices.

### 5. User Registration

- Create a user registration screen.
- Allow new users to sign up by providing their email address and creating a password.

### 6. User Login

- Implement secure user login functionality.
- Allow registered users to log in to the app securely.

### 7. Favorites Feature

- Enhance the product listing screen by adding a "Favorites" feature.
- Users should be able to mark products as favorites by tapping on a heart icon.

### 8. User Authentication State

- Persist user authentication state throughout the app.
- Users should remain logged in until they explicitly log out or the session expires.

### 9. Profile Management

- Develop a profile screen.
- Allow users to view and update their personal information, including name, email, and profile picture.

## Getting Started

1. Clone the repository to your local machine.

```bash
git clone https://github.com/your/repository.git
cd repository
```

2. Install Flutter dependencies.

```bash
flutter pub get
```

3. Run the app.

```bash
flutter run
```

## Dependencies

- [Flutter](https://flutter.dev/): UI toolkit for building natively compiled applications.
- [Http](https://pub.dev/packages/http): HTTP client for making API requests.
- [Provider](https://pub.dev/packages/provider): State management library for Flutter.
- [Shared Preferences](https://pub.dev/packages/shared_preferences): Persistent key-value storage.

## Contributing

Feel free to contribute by submitting bug reports, feature requests, or pull requests. Let's make this app an immersive commerce experience for everyone!

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.