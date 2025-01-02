import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:i/auth/authentication/repository/auth_service.dart';
import 'package:sign_in_button/sign_in_button.dart';

import 'sigup_view.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _SignupViewState();
}

class _SignupViewState extends ConsumerState<LoginView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;
  late final TextEditingController _passwordController;
  bool _isloading = false;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        reverse: true,
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 20,
            children: [
              _buildLogo(),
              const SizedBox(height: 20),
              _signupForm(AutovalidateMode.onUserInteraction, context),
              _buildOR(context),
              _buildSignInWithGoogle(context),
              _buildLoginText(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.asset(
          'assets/icon/icon.png',
          height: 100,
        ),
        const SizedBox(height: 20),
        Text(
          'Loop of Knowledge',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.deepOrangeAccent,
          ),
        ),
      ],
    );
  }

  Form _signupForm(AutovalidateMode validateMode, BuildContext context) {
    return Form(
      autovalidateMode: validateMode,
      key: _formKey,
      child: Column(
        children: [
          _buildTextFormField(
            controller: _emailController,
            labelText: 'Email',
            icon: Icons.email,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              } else if (!value.contains('@')) {
                return 'Please enter a valid email';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _buildTextFormField(
            controller: _passwordController,
            labelText: 'Password',
            icon: Icons.lock,
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              } else if (value.length < 6) {
                return 'Password must be at least 6 characters';
              } else if (!value.contains(RegExp(r'[A-Z]'))) {
                return 'Must contain one uppercase letter';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _signupButton(context),
        ],
      ),
    );
  }

  Widget _buildTextFormField({
    required TextEditingController controller,
    required String labelText,
    required IconData icon,
    bool obscureText = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(icon, color: Colors.deepPurple),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: Colors.deepPurple),
        ),
        filled: true,
        fillColor: Colors.grey[200],
      ),
      obscureText: obscureText,
      validator: validator,
    );
  }

  Widget _signupButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.deepOrangeAccent,
          padding: const EdgeInsets.symmetric(vertical: 10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
        ),
        onPressed: _isloading
            ? null
            : () async {
                FocusManager.instance.primaryFocus?.unfocus();
                if (_formKey.currentState!.validate()) {
                  setState(() {
                    _isloading = true;
                  });
                  final result = await ref
                      .read(authServiceProvider)
                      .signInWithEmailAndPassword(
                        _emailController.text,
                        _passwordController.text,
                      );

                  if (result) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('login successful'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Failed to login'),
                      ),
                    );
                  }
                  setState(() {
                    _isloading = false;
                  });
                }
              },
        child: 2 > 3
            ? const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              )
            : const Text(
                'Login',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
      ),
    );
  }

  Widget _buildOR(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 2,
          ),
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8),
          child: Text('OR',
              style:
                  TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
        ),
        Expanded(
          child: Divider(
            color: Colors.grey,
            thickness: 2,
          ),
        ),
      ],
    );
  }

  Widget _buildSignInWithGoogle(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: SignInButton(
          elevation: 1,
          padding: const EdgeInsets.symmetric(vertical: 5),
          Buttons.google,
          text: 'Sign in with Google',
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          onPressed: () async {
            await ref.read(authServiceProvider).signInWithGoogle();
          },
        ),
      ),
    );
  }

  Widget _buildLoginText(BuildContext context) {
    return RichText(
        text: TextSpan(
      text: 'Don\'t have an account?  ',
      style: TextStyle(color: Colors.black, fontSize: 16),
      children: [
        TextSpan(
          text: 'Sign Up',
          recognizer: TapGestureRecognizer()
            ..onTap = () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return const SignupView();
              }));
            },
          style: TextStyle(
            color: Colors.deepOrange,
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ],
    ));
  }
}