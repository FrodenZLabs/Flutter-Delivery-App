import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class SignUpView extends StatefulWidget {
  const SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  bool _showPassword = false;
  bool _showConfirmPassword = false;

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign Up',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ✅ Logo and Header Text
            Row(
              children: [
                Image.asset(
                  'assets/images/logo.png', // Replace with your logo path
                  width: 60,
                  height: 60,
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Text(
                    'Create your K-Labs Delivery Account',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ✅ First Name
            TextField(
              controller: _firstNameController,
              decoration: const InputDecoration(
                labelText: 'First Name',
                labelStyle: TextStyle(color: Colors.brown),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.brown, // 👈 Your focus color
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Last Name
            TextField(
              controller: _lastNameController,
              decoration: const InputDecoration(
                labelText: 'Last Name',
                labelStyle: TextStyle(color: Colors.brown),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person_outline),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.brown, // 👈 Your focus color
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Email
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(color: Colors.brown),
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.mail_outline),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.brown, // 👈 Your focus color
                    width: 2,
                  ),
                ),
              ),
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 12),

            // ✅ Password with toggle
            TextField(
              controller: _passwordController,
              obscureText: !_showPassword,
              decoration: InputDecoration(
                labelText: 'Password',
                labelStyle: TextStyle(color: Colors.brown),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showPassword ? Icons.visibility : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showPassword = !_showPassword;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.brown, // 👈 Your focus color
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Confirm Password with toggle
            TextField(
              controller: _confirmPasswordController,
              obscureText: !_showConfirmPassword,
              decoration: InputDecoration(
                labelText: 'Confirm Password',
                labelStyle: TextStyle(color: Colors.brown),
                border: const OutlineInputBorder(),
                prefixIcon: Icon(Icons.key),
                suffixIcon: IconButton(
                  icon: Icon(
                    _showConfirmPassword
                        ? Icons.visibility
                        : Icons.visibility_off,
                  ),
                  onPressed: () {
                    setState(() {
                      _showConfirmPassword = !_showConfirmPassword;
                    });
                  },
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Colors.brown, // 👈 Your focus color
                    width: 2,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // ✅ Create Account Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle sign up logic
                  print('Creating account for: ${_emailController.text}');
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kSecondaryColor,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Create Account',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
            const SizedBox(height: 12),

            // ✅ Terms & Privacy Text
            const Text(
              'By creating an account, you agree to our Terms and Privacy Policy.',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 12, color: Colors.grey),
            ),
            const SizedBox(height: 20),

            // ✅ Divider
            Row(
              children: [
                const Expanded(child: Divider(thickness: 1)),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text('or'),
                ),
                const Expanded(child: Divider(thickness: 1)),
              ],
            ),
            const SizedBox(height: 12),

            // ✅ Already have account? Login
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Already have an account? '),
                GestureDetector(
                  onTap: () {
                    // TODO: Navigate to Sign In screen
                    print('Go to Sign In');
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
