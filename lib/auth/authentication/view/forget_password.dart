import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ForgetPasswordView extends ConsumerStatefulWidget {
  const ForgetPasswordView({super.key});

  @override
  ConsumerState<ForgetPasswordView> createState() => _ForgetPasswordViewState();
}

class _ForgetPasswordViewState extends ConsumerState<ForgetPasswordView> {
  late final GlobalKey<FormState> _formKey;
  late final TextEditingController _emailController;

  @override
  void initState() {
    super.initState();
    _formKey = GlobalKey<FormState>();
    _emailController = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
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
            children: [
              _buildLogo(),
              const SizedBox(height: 40),
              _forgetPasswordForm(AutovalidateMode.onUserInteraction, context),
              const SizedBox(height: 20),
              _buildBackToLoginText(context),
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
            color: Colors.deepPurple,
          ),
        ),
      ],
    );
  }

  Form _forgetPasswordForm(
      AutovalidateMode validateMode, BuildContext context) {
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
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          _resetPasswordButton(context),
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

  Widget _resetPasswordButton(BuildContext context) {
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
        onPressed: () {
          FocusManager.instance.primaryFocus?.unfocus();
          if (_formKey.currentState!.validate()) {
            // Handle reset password logic here
          }
        },
        child: const Text(
          'Reset Password',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _buildBackToLoginText(BuildContext context) {
    return TextButton(
      onPressed: () {
        Navigator.pop(context);
      },
      child: Text(
        'Back to Login',
        style: TextStyle(
          color: Colors.deepPurple,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
