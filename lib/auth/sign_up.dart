import 'package:flutter/material.dart';
import 'package:futureme/auth/auth_service.dart';
import 'package:futureme/auth/sign_in.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:futureme/presentation/pages/main_screen.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  bool isLoading = false;

  void register(BuildContext context) async {
    final auth = AuthService();

    if (passwordController.text == confirmPasswordController.text) {
      setState(() {
        isLoading = true;
      });
      try {
        await auth.signUpWithEmailPassword(
            emailController.text, passwordController.text, usernameController.text);
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MainScreen()),
        );
      } catch (e) {
        showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text('Error signing up'),
                  content: Text(e.toString()),
                  actions: [
                    TextButton(
                      child: Text('OK'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ));
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    } else {
      showDialog(
          context: context,
          builder: (context) => AlertDialog(
                title: Text('Error'),
                content: Text('Passwords don\'t match'),
                actions: [
                  TextButton(
                    child: Text('OK'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Color(0xFFF3E9E3),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 60),
                        Text(
                          "Create Account",
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFFE57373),
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "Sign up to start your journey",
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 48),
                        _buildTextField(
                            "Username", Icons.person, usernameController),
                        const SizedBox(height: 16),
                        _buildTextField("Email", Icons.email, emailController),
                        const SizedBox(height: 16),
                        _buildTextField(
                            "Password", Icons.lock, passwordController,
                            isPassword: true),
                        const SizedBox(height: 16),
                        _buildTextField("Confirm Password", Icons.lock,
                            confirmPasswordController,
                            isPassword: true),
                        const SizedBox(height: 24),
                        _buildSignUpButton(),
                        const SizedBox(height: 16),
                        Text(
                          "By signing up, you agree to our Terms of Service and Privacy Policy",
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
                _buildSignInPrompt(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      String hint, IconData icon, TextEditingController controller,
      {bool isPassword = false}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
          prefixIcon: Icon(icon, color: const Color(0xFFE57373)),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
        style: GoogleFonts.poppins(color: Colors.black87),
      ),
    );
  }

  Widget _buildSignUpButton() {
    return SizedBox(
      height: 56,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: const Color(0xFFE57373),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          elevation: 2,
        ),
        onPressed: isLoading ? null : () => register(context),
        child: isLoading
            ? SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  strokeWidth: 2,
                ),
              )
            : Text(
                "Sign Up",
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
      ),
    );
  }

  Widget _buildSignInPrompt() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Already have an account? ",
            style: GoogleFonts.poppins(color: Colors.grey[600]),
          ),
          TextButton(
            child: Text(
              "Sign in",
              style: GoogleFonts.poppins(
                color: const Color(0xFFE57373),
                fontWeight: FontWeight.w600,
              ),
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => SignInPage()));
            },
          ),
        ],
      ),
    );
  }
}