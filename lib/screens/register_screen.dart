import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter/cupertino.dart';
import 'welcome_screen.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

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

              const SizedBox(height: 40),

              // Fields
              _buildField(
                    "FULL NAME",
                    "e.g. Julian Black",
                    Icons.person_outline,
                    fieldGray,
                    labelGray,
                  )
                  .animate()
                  .fade(delay: 300.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              _buildField(
                    "EMAIL ADDRESS",
                    "julian@curated.com",
                    Icons.alternate_email,
                    fieldGray,
                    labelGray,
                  )
                  .animate()
                  .fade(delay: 400.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              // Password
              _buildField(
                    "PASSWORD",
                    "••••••••",
                    Icons.lock_outline,
                    fieldGray,
                    labelGray,
                    obscureText: true,
                  )
                  .animate()
                  .fade(delay: 500.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 24),

              // Mobile number with verify
              Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "MOBILE NUMBER",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: labelGray,
                          letterSpacing: 1.0,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: _MobileNumberInput(fieldGray: fieldGray),
                          ),
                          const SizedBox(width: 12),
                          Container(
                            height: 58,
                            padding: const EdgeInsets.symmetric(horizontal: 24),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE2E2E8),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "Verify",
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: primaryText,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                  .animate()
                  .fade(delay: 600.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Sign Up button
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
                        "Sign Up",
                        style: GoogleFonts.inter(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: primaryText,
                        ),
                      ),
                    ),
                  )
                  .animate()
                  .fade(delay: 700.ms, duration: 400.ms)
                  .slideY(begin: 0.1, end: 0),

              const SizedBox(height: 40),

              // Or register with
              Row(
                children: [
                  Expanded(child: Divider(color: Colors.grey.shade300)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "OR REGISTER WITH",
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
              ).animate().fade(delay: 800.ms, duration: 400.ms),

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
                  )
                  .animate()
                  .fade(delay: 900.ms, duration: 400.ms)
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
                        transitionsBuilder: (context, animation, secondaryAnimation, child) {
                          return FadeTransition(opacity: animation, child: child);
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
              ).animate().fade(delay: 1000.ms, duration: 400.ms),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildField(
    String label,
    String hint,
    IconData icon,
    Color bg,
    Color labelGray, {
    bool obscureText = false,
  }) {
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
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
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

class _MobileNumberInput extends StatefulWidget {
  final Color fieldGray;
  const _MobileNumberInput({required this.fieldGray});
  @override
  State<_MobileNumberInput> createState() => _MobileNumberInputState();
}

class _MobileNumberInputState extends State<_MobileNumberInput> {
  String _selectedCountryCode = '+1';
  final List<String> _countryCodes = ['+1', '+44', '+91', '+61', '+81'];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.fieldGray,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCountryCode,
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                  size: 18,
                  color: Colors.grey,
                ),
                style: GoogleFonts.inter(
                  color: const Color(0xFF2D2D36),
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    if (newValue != null) _selectedCountryCode = newValue;
                  });
                },
                items: _countryCodes.map<DropdownMenuItem<String>>((
                  String value,
                ) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ),
          Container(
            height: 24,
            width: 1,
            color: Colors.grey.shade300,
            margin: const EdgeInsets.symmetric(horizontal: 8),
          ),
          Expanded(
            child: TextField(
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                hintText: "234 567 890",
                hintStyle: GoogleFonts.inter(
                  color: Colors.grey.shade400,
                  fontSize: 15,
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 18),
                border: InputBorder.none,
                suffixIcon: Icon(
                  Icons.phone_android,
                  color: Colors.grey.shade400,
                  size: 20,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
