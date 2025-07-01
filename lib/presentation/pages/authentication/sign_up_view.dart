import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/images.dart';
import 'package:flutter_delivery_app/core/constants/validators.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/usecases/user/register_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_text_form_field.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

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
  final _formKey = GlobalKey<FormState>();

  void _onSignUp(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      if (_passwordController.text != _confirmPasswordController.text) {
        return;
      }

      context.read<UserBloc>().add(
        RegisterUserEvent(
          RegisterParams(
            firstName: _firstNameController.text,
            lastName: _lastNameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserLoading) {
          LoadingOverlay.show();
        } else {
          LoadingOverlay.hide();
        }

        if (state is UserSuccess) {
          Navigator.of(context).pushNamed(AppRouter.login);

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Registration Success"),
            description: Text("Account created Successfully!"),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        } else if (state is UserRegisteredFail) {
          String errorMessage = " An error occurred. Please try again";
          if (state.failure is CredentialFailure) {
            errorMessage = "User already exists. Try logging in.";
          } else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your internet connection";
          } else if (state.failure is ServerFailure) {
            errorMessage = "Server error. Please try again later";
          }

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Registration Failed"),
            description: Text(errorMessage),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        }
      },
      child: Scaffold(
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
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // ✅ Logo and Header Text
                Row(
                  children: [
                    Image.asset(
                      kAppLogo, // Replace with your logo path
                      width: 60,
                      height: 60,
                    ),
                    const SizedBox(width: 12),
                    const Expanded(
                      child: Text(
                        'Create your K-Labs Delivery Account',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // ✅ First Name
                InputTextFormField(
                  controller: _firstNameController,
                  textInputAction: TextInputAction.next,
                  hint: "First Name",
                  prefixIcon: Icon(Icons.person_outline),
                  validation: (String? val) =>
                      Validators.validateField(val, "First Name"),
                ),
                const SizedBox(height: 12),

                // ✅ Last Name
                InputTextFormField(
                  controller: _lastNameController,
                  textInputAction: TextInputAction.next,
                  hint: "Last Name",
                  prefixIcon: Icon(Icons.person_outline),
                  validation: (String? val) =>
                      Validators.validateField(val, "Last Name"),
                ),
                const SizedBox(height: 12),

                // ✅ Email
                InputTextFormField(
                  controller: _emailController,
                  textInputAction: TextInputAction.next,
                  hint: "Email Address",
                  prefixIcon: Icon(Icons.mail_outline),
                  keyboardType: TextInputType.emailAddress,
                  validation: (String? val) => Validators.validateEmail(val),
                ),
                const SizedBox(height: 12),

                // ✅ Password with toggle
                InputTextFormField(
                  controller: _passwordController,
                  textInputAction: TextInputAction.next,
                  hint: "Password",
                  isSecureField: true,
                  prefixIcon: Icon(Icons.key),
                  validation: (String? val) =>
                      Validators.validateField(val, "Password"),
                ),
                const SizedBox(height: 12),

                // ✅ Confirm Password with toggle
                InputTextFormField(
                  controller: _confirmPasswordController,
                  textInputAction: TextInputAction.go,
                  hint: "Confirm Password",
                  isSecureField: true,
                  prefixIcon: Icon(Icons.key),
                  validation: (String? val) => Validators.validatePasswordMatch(
                    val,
                    _passwordController.text,
                  ),
                  onFieldSubmitted: (_) => _onSignUp(context),
                ),
                const SizedBox(height: 20),

                // ✅ Create Account Button
                InputFormButton(
                  onClick: () => _onSignUp(context),
                  titleText: "Create Account",
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
                    InkWell(
                      onTap: () {
                        Navigator.of(context).pushNamed(AppRouter.login);
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
        ),
      ),
    );
  }
}
