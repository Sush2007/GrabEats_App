import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
// Note: Real Google Sign-In logic removed due to package API version mismatches.
// Keep a placeholder flow so the UI and navigation remain functional.

import 'welcome_screen.dart';
import 'login_screen.dart';
import 'dashboard_screen.dart';

// ⚠️ Converted to StatefulWidget to handle the loading spinner state
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;

  // 🧠 The Core Authentication Logic (placeholder)
Future<void> _signInWithGoogle() async {
    setState(() => _isLoading = true);
    // Simulate a quick sign-in flow so UI remains responsive while we
    // defer implementing the real Google/Firebase integration.
    await Future.delayed(const Duration(milliseconds: 500));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => const DashboardScreen()),
      (route) => false,
    );
  }
  @override
  Widget build(BuildContext context) {
    const Color primaryText = Color(0xFF2D2D36);
    const Color backgroundGray = Color(0xFFF9F9FC);
    const Color brandYellow = Color(0xFFFFC502);
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  const WelcomeScreen(),
                          transitionsBuilder:
                              (context, animation, secondaryAnimation, child) {
                                return SlideTransition(
                                  position:
                                      Tween<Offset>(
                                            begin: const Offset(-1.0, 0.0),
                                            end: Offset.zero,
                                          )
                                          .chain(
                                            CurveTween(
                                              curve: Curves.easeOutQuart,
                                            ),
                                          )
                                          .animate(animation),
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
                  )
                  .animate()
                  .fade(duration: 400.ms)
                  .slideX(begin: -0.2, end: 0, curve: Curves.easeOutQuart),

              const SizedBox(height: 32),

              // Title
              Text(
                    "Create Account",
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: primaryText,
                      letterSpacing: -0.5,
                      height: 1.1,
                    ),
                  )
                  .animate()
                  .fade(delay: 100.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 12),

              // Subtitle
              Text(
                    "Join the Grab Eats family and get the premium dining experince",
                    style: GoogleFonts.inter(
                      fontSize: 15,
                      color: labelGray,
                      height: 1.5,
                      fontWeight: FontWeight.w400,
                    ),
                  )
                  .animate()
                  .fade(delay: 200.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 32),

              // Continue with Google button
              _buildGoogleButton()
                  .animate()
                  .fade(delay: 250.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Login text
              Center(
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const LoginScreen(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                        transitionDuration: const Duration(milliseconds: 600),
                      ),
                    );
                  },
                  child: RichText(
                    text: TextSpan(
                      style: GoogleFonts.inter(fontSize: 14, color: labelGray),
                      children: [
                        const TextSpan(text: "Already have an account? "),
                        TextSpan(
                          text: "Login",
                          style: GoogleFonts.inter(
                            fontWeight: FontWeight.bold,
                            color: const Color(
                              0xFF98710B,
                            ), // Darker yellow/brown text
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ).animate().fade(delay: 650.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton() {
    const Color textColor = Color(0xFF2D2D36);
    return InkWell(
      // ⚠️ Button now triggers the async auth function instead of a raw navigator push
      onTap: _isLoading ? null : _signInWithGoogle,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: double.infinity,
        height: 56,
        decoration: BoxDecoration(
          color: _isLoading ? Colors.grey.shade100 : Colors.transparent,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.grey.shade300, width: 1.2),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // ⚠️ If loading, show spinner. Otherwise, show Google logo.
            if (_isLoading)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF98710B)),
                ),
              )
            else
              Container(
                width: 28,
                height: 28,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(6),
                  color: Colors.white,
                ),
                padding: const EdgeInsets.all(2),
                child: Image.asset(
                  'lib/assets/google_logo.png',
                  width: 24,
                  height: 24,
                  fit: BoxFit.contain,
                ),
              ),
            const SizedBox(width: 12),
            Text(
              _isLoading ? 'Signing in...' : 'Continue with Google',
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
