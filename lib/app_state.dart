import 'package:flutter/material.dart';
import 'services/auth_service.dart'; // Import the AuthService

class AppState extends ChangeNotifier {
  // Instance of our authentication service
  final AuthService _authService = AuthService(); // Create an instance

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  // Login function - Now calls AuthService and returns success/failure
  Future<bool> loginUser(String username, String password) async {
    print('AppState: Attempting login via AuthService...');
    try {
      // Call the AuthService login method
      final bool success = await _authService.login(username, password);

      if (success) {
        print('AppState: Login successful. Updating state.');
        _isLoggedIn = true;
        notifyListeners(); // Notify widgets (like the Consumer in main.dart)
        return true; // Indicate success
      } else {
        print('AppState: Login failed.');
        _isLoggedIn = false; // Ensure state remains logged out
        // Don't notify listeners here, as the state didn't positively change
        return false; // Indicate failure
      }
    } catch (e) {
      // Handle potential errors during the API call (e.g., network issues)
      print('AppState: Error during login: $e');
      _isLoggedIn = false;
      return false; // Indicate failure
    }
  }

  // Logout function - Now calls AuthService
  Future<void> logoutUser() async {
    print('AppState: Logging out via AuthService...');
    try {
      await _authService.logout(); // Call the service's logout
    } catch (e) {
      // Handle potential errors during logout API call
       print('AppState: Error during logout: $e');
    } finally {
       // Always ensure the state is updated to logged out
       _isLoggedIn = false;
       // TODO: Clear any other user-specific data if necessary
       print('AppState: State updated to logged out.');
       notifyListeners(); // Notify widgets
    }
  }

  // --- Scan History (Placeholder) ---
}