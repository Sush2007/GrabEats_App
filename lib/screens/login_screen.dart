import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'register_screen.dart';
import 'forget_password_screen.dart';
import 'welcome_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryText = Color(0xFF2D2D36);
    const Color backgroundGray = Color(0xFFF9F9FC);
    const Color brandYellow = Color(0xFFFFC502);
    const Color fieldGray = Color(0xFFF1F1F5);
    const Color labelGray = Color(0xFF6C757D);

    return Scaffold(
      backgroundColor: backgroundGray,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top circular close button
              InkWell(
                onTap: () {
                  Navigator.of(context).pushReplacement(
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const WelcomeScreen(),
                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                        return SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(-1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
                          child: child,
                        );
                      },
                      transitionDuration: const Duration(milliseconds: 800),
                    ),
                  );
                },
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  width: 48,
                  height: 48,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: brandYellow,
                  ),
                  child: const Icon(
                    Icons.close,
                    color: Color(0xFF2D2D2D),
                    size: 24,
                  ),
                ),
              ).animate().fade(duration: 400.ms).slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuart),

              const SizedBox(height: 32),

              // Title
              Text(
                "Welcome Back",
                style: GoogleFonts.inter(
                  fontSize: 32,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                  letterSpacing: -0.5,
                  height: 1.1,
                ),
              ).animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                "Sign in to continue your curated dining experience.",
                style: GoogleFonts.inter(
                  fontSize: 15,
                  color: labelGray,
                  height: 1.5,
                  fontWeight: FontWeight.w400,
                ),
              ).animate().fade(delay: 200.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Fields
              _buildField("EMAIL ADDRESS", "julian@curated.com", Icons.alternate_email, fieldGray, labelGray)
                  .animate().fade(delay: 300.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              // Password
              _buildField("PASSWORD", "••••••••", Icons.lock_outline, fieldGray, labelGray, obscureText: true)
                  .animate().fade(delay: 400.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 16),

              // Forgot Password
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const ForgetPasswordScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(1.0, 0.0),
                              end: Offset.zero,
                            ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
                            child: child,
                          );
                        },
                        transitionDuration: const Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: Text(
                    "Forgot Password?",
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF98710B),
                    ),
                  ),
                ),
              ).animate().fade(delay: 500.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Sign In button
              InkWell(
                onTap: () {},
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  width: double.infinity,
                  height: 60,
                  decoration: BoxDecoration(
                    color: brandYellow,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: brandYellow.withOpacity(0.3),
                        blurRadius: 15,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Login",
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                ),
              ).animate().fade(delay: 600.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Or register with
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OR LOGIN WITH",
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey.shade400,
                        letterSpacing: 1.0,
                      ),
                    ),
                  ),
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                ],
              ).animate().fade(delay: 700.ms, duration: 400.ms),

              const SizedBox(height: 24),

              // Social logos
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialIcon(
                    child: Text(
                      "G",
                      style: GoogleFonts.roboto(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.blue.shade600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 24),
                  _buildSocialIcon(
                    child: const Icon(
                      Icons.apple,
                      size: 28,
                      color: Colors.black,
                    ),
                  ),
                ],
              ).animate().fade(delay: 800.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Register text
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const RegisterScreen(),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
                        },
                        transitionDuration: const Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        color: labelGray,
                      ),
                      children: [
                        const TextSpan(text: "Don't have an account? "),
                        TextSpan(
                          text: "Register",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(0xFF98710B),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fade(delay: 900.ms, duration: 400.ms),

            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(String label, String hint, IconData icon, Color bg, Color labelGray, {bool obscureText = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.w700,
            color: labelGray,
            letterSpacing: 1.0,
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
          ),
          child: TextField(
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: GoogleFonts.inter(
                color: Colors.grey.shade400,
                fontSize: 15,
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
              border: InputBorder.none,
              suffixIcon: Icon(icon, color: Colors.grey.shade400, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialIcon({required Widget child}) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      alignment: Alignment.center,
      child: child,
    );
  }
}
