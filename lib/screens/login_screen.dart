import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../app_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    // Prevent multiple login attempts while one is processing
    if (_isLoading) return;

    setState(() { _isLoading = true; });

    final username = _usernameController.text;
    final password = _passwordController.text;

    // Get the AppState instance
    final appState = Provider.of<AppState>(context, listen: false);

    // Call the login function and wait for the result (true/false)
    final bool loginSuccess = await appState.loginUser(username, password);

    // --- Handle Login Result ---
    // Check if the widget is still mounted before updating state/showing UI
    if (!mounted) return;

    if (loginSuccess) {
      // If login is successful, the Consumer in main.dart will handle navigation.
      // We don't strictly need to do anything here, but we could hide loading if needed.
      // setState(() { _isLoading = false; }); // Might be hidden by navigation anyway
      print("LoginScreen: Login successful, navigation handled by Consumer.");
    } else {
      // If login failed, hide loading and show an error message
      setState(() { _isLoading = false; });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login failed. Please check username and password.'),
          backgroundColor: Colors.redAccent,
        ),
      );
      print("LoginScreen: Login failed, showing error message.");
    }
  }

  @override
  Widget build(BuildContext context) {
     // --- Build method remains the same as before ---
     // It already includes the _isLoading check for the button/indicator
     return Scaffold(
        appBar: AppBar(
          title: const Text('Employee Login'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                TextField(
                  controller: _usernameController,
                  decoration: const InputDecoration(labelText: 'Username'),
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 15),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(labelText: 'Password'),
                  obscureText: true, // Hide password
                ),
                const SizedBox(height: 30),
                _isLoading
                    ? const CircularProgressIndicator() // Show loading indicator
                    : ElevatedButton(
                        onPressed: _login, // Call the login function
                        child: const Text('Login'),
                      ),
              ],
            ),
          ),
        ),
      );
     // --- End of build method ---
  }
}