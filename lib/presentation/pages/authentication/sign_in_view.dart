import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_delivery_app/core/constants/colors.dart';
import 'package:flutter_delivery_app/core/constants/validators.dart';
import 'package:flutter_delivery_app/core/error/failures.dart';
import 'package:flutter_delivery_app/core/router/app_router.dart';
import 'package:flutter_delivery_app/domain/usecases/user/login_use_case.dart';
import 'package:flutter_delivery_app/presentation/blocs/home/navbar_cubit.dart';
import 'package:flutter_delivery_app/presentation/blocs/user/user_bloc.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_form_button.dart';
import 'package:flutter_delivery_app/presentation/widgets/input_text_form_field.dart';
import 'package:flutter_delivery_app/presentation/widgets/loading_overlay.dart';
import 'package:toastification/toastification.dart';

class SignInView extends StatefulWidget {
  const SignInView({super.key});

  @override
  State<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends State<SignInView> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  void _onSignIn(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      context.read<UserBloc>().add(
        LoginUserEvent(
          LoginParams(
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

        if (state is UserLogged) {
          context.read<NavbarCubit>().update(0);
          Navigator.of(context).pushNamedAndRemoveUntil(
            AppRouter.home,
            (Route<dynamic> route) => false,
          );

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Login Success"),
            description: Text("Account Login Successfully!"),
            type: ToastificationType.success,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        } else if (state is UserLoggedFail) {
          String errorMessage = " An error occurred. Please try again";
          if (state.failure is CredentialFailure) {
            errorMessage = "Invalid email or password";
          } else if (state.failure is NetworkFailure) {
            errorMessage = "Network error. Check your internet connection";
          } else if (state.failure is ServerFailure) {
            errorMessage = "Server error. Please try again later";
          }

          // ✅ Show toast
          toastification.show(
            context: context,
            title: Text("Login Failed"),
            description: Text(errorMessage),
            type: ToastificationType.error,
            style: ToastificationStyle.minimal,
            autoCloseDuration: const Duration(seconds: 10),
            dragToClose: true,
          );
        }
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
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

                  // ✅ Email
                  InputTextFormField(
                    controller: _emailController,
                    textInputAction: TextInputAction.next,
                    hint: "Email Address",
                    prefixIcon: Icon(Icons.mail_outline),
                    keyboardType: TextInputType.emailAddress,
                    validation: (String? val) => Validators.validateEmail(val),
                  ),

                  const SizedBox(height: 20),

                  // ✅ Password with toggle
                  InputTextFormField(
                    controller: _passwordController,
                    textInputAction: TextInputAction.next,
                    hint: "Password",
                    isSecureField: true,
                    prefixIcon: Icon(Icons.key),
                    validation: (String? val) =>
                        Validators.validateField(val, "Password"),
                    onFieldSubmitted: (_) => _onSignIn(context),
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

                  // ✅ Create Account Button
                  InputFormButton(
                    onClick: () => _onSignIn(context),
                    titleText: "Login",
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
                          Navigator.of(context).pushNamed(AppRouter.register);
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
      ),
    );
  }
}
