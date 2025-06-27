import 'package:flutter/material.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  void togglePasswordVisibility() {
    setState(() {
      _obscurePassword = !_obscurePassword;
    });
  }

  void handleLogin() {
    final email = _emailController.text;
    final password = _passwordController.text;

    // TODO: Implement actual login logic
    print('Email: $email');
    print('Password: $password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Sign In',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBackgroundColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      backgroundColor: kBackgroundColor,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              maxWidth: 400,
            ), // ✅ Optional for tablets
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),

                // ✅ Intro Text Centered
                const Text(
                  'Welcome back!',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Please sign in to continue.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // ✅ Email Field
                TextField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                    labelText: 'Email Address',
                    labelStyle: TextStyle(color: Colors.brown),
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.mail_outline),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Password Field with Toggle
                TextField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.brown),
                    border: const OutlineInputBorder(),
                    prefixIcon: const Icon(Icons.key),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                      ),
                      onPressed: togglePasswordVisibility,
                    ),
                    focusedBorder: const OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.brown, width: 2),
                    ),
                  ),
                ),

                const SizedBox(height: 10),

                // ✅ Forgot Password Text
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Navigate to forgot password screen
                    },
                    child: const Text(
                      'Forgot Password?',
                      style: TextStyle(
                        color: Colors.brown,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Login Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: handleLogin,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kSecondaryColor,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      'Login',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                // ✅ Divider
                Row(
                  children: const [
                    Expanded(child: Divider(thickness: 1)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8),
                      child: Text('OR'),
                    ),
                    Expanded(child: Divider(thickness: 1)),
                  ],
                ),

                const SizedBox(height: 10),

                // ✅ Already have an account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don’t have an account? '),
                    GestureDetector(
                      onTap: () {
                        // TODO: Navigate to Sign Up screen
                      },
                      child: const Text(
                        'Sign Up',
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
        ),
      ),
    );
  }
}
