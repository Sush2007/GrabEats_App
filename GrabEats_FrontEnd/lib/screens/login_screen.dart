import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'register_screen.dart';
import 'welcome_screen.dart';
import 'dashboard_screen.dart';
// otp_verification_screen import not used here

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryText = Color(0xFF2D2D36);
    const Color backgroundGray = Color(0xFFF9F9FC);
    const Color brandYellow = Color(0xFFFFC502);
  // fieldGray removed (no inline input fields on this screen)
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

              const SizedBox(height: 32),

              // Continue with Google button (centered)
              Center(
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: _buildSocialButton(
                    context,
                    "Continue with Google",
                    "lib/assets/google_logo.png",
                    Colors.blue.shade600,
                    Colors.transparent,
                    primaryText,
                  ),
                ),
              ).animate().fade(delay: 250.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),

              // Or register with
              const SizedBox(height: 24),

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

// Removed email/password input helper (not used when login uses social only)

  Widget _buildSocialButton(
    BuildContext context,
    String text,
    String? imagePath,
    Color iconColor,
    Color backgroundColor,
    Color textColor,
  ) {
    return InkWell(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const DashboardScreen()),
        );
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(30),
          border: (backgroundColor == Colors.white || backgroundColor == Colors.transparent)
              ? Border.all(
                  color: Colors.grey.shade300,
                  width: 1.2,
                )
              : null,
          boxShadow: backgroundColor == Colors.transparent
              ? []
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (imagePath != null)
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  imagePath,
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              )
            else
              Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Colors.white,
                ),
                child: Center(
                  child: Text(
                    'G',
                    style: GoogleFonts.roboto(
                      fontSize: 16,
                      fontWeight: FontWeight.w900,
                      color: Colors.blue.shade600,
                    ),
                  ),
                ),
              ),
            const SizedBox(width: 12),
            Text(
              text,
              style: GoogleFonts.inter(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: textColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
