import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'scheduled_grab_screen.dart';
import 'payment_screen.dart';

class GrabPreferenceScreen extends StatelessWidget {
  final String restaurantName;
  const GrabPreferenceScreen({super.key, required this.restaurantName});

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 50,
              left: 24,
              right: 24,
            ),
            decoration: const BoxDecoration(
              color: brandYellow,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(60),
                bottomRight: Radius.circular(60),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () => Navigator.of(context).pop(),
                  child: const Icon(
                    Icons.arrow_back,
                    size: 32,
                    color: primaryText,
                  ),
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text(
                    "Select your grab",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.inter(
                      fontSize: 32,
                      fontWeight: FontWeight.w800,
                      color: primaryText,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const Spacer(),

          // Instant Grab Button
          _buildPreferenceButton(
            title: "Instant Grab",
            icon: Icons.local_pizza,
            onTap: () {
              _showInstantGrabBottomSheet(context, restaurantName);
            },
          ),

          const SizedBox(height: 40),

          // Scheduled Grab Button
          _buildPreferenceButton(
            title: "Scheduled\nGrab",
            icon: Icons.access_time_filled,
            onTap: () {
              Navigator.of(context).push(
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      ScheduledGrabScreen(restaurantName: restaurantName),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(1.0, 0.0),
                          end: Offset.zero,
                        ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
                        child: child,
                      ),
                    );
                  },
                  transitionDuration: const Duration(milliseconds: 500),
                ),
              );
            },
          ),

          const Spacer(flex: 2),
        ],
      ),
    );
  }

  Widget _buildPreferenceButton({
    required String title,
    required IconData icon,
    required VoidCallback onTap,
  }) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 24),
        padding: const EdgeInsets.only(
          left: 20,
          right: 12,
          top: 12,
          bottom: 12,
        ),
        decoration: BoxDecoration(
          color: brandYellow,
          borderRadius: BorderRadius.circular(60),
        ),
        child: Row(
          children: [
            Expanded(
              child: Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.inter(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: primaryText,
                    height: 1.1,
                  ),
                ),
              ),
            ),
            Container(
              width: 90,
              height: 90,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Center(child: Icon(icon, size: 50, color: primaryText)),
            ),
          ],
        ),
      ),
    );
  }

  void _showInstantGrabBottomSheet(BuildContext context, String restaurantName) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _InstantGrabBottomSheet(restaurantName: restaurantName),
    );
  }
}

class _InstantGrabBottomSheet extends StatefulWidget {
  final String restaurantName;
  const _InstantGrabBottomSheet({required this.restaurantName});

  @override
  State<_InstantGrabBottomSheet> createState() => _InstantGrabBottomSheetState();
}

class _InstantGrabBottomSheetState extends State<_InstantGrabBottomSheet> {
  int _guestCount = 4;

  void _incrementGuest() {
    setState(() => _guestCount++);
  }

  void _decrementGuest() {
    if (_guestCount > 0) {
      setState(() => _guestCount--);
    }
  }

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return Container(
      padding: const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 40),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag handle
          Container(
            width: 50,
            height: 5,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          const SizedBox(height: 30),
          
          Text(
            "How many guests?",
            style: GoogleFonts.inter(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: primaryText,
            ),
          ),
          
          const SizedBox(height: 40),
          
          // Guests Counter
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: _decrementGuest,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: brandYellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.remove, color: primaryText, size: 28),
                ),
              ),
              const SizedBox(width: 24),
              Container(
                width: 140,
                height: 60,
                decoration: BoxDecoration(
                  border: Border.all(color: brandYellow, width: 2),
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0.0, 0.3),
                        end: Offset.zero,
                      ).animate(animation),
                      child: FadeTransition(
                        opacity: animation,
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    '$_guestCount',
                    key: ValueKey<int>(_guestCount),
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: primaryText,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 24),
              GestureDetector(
                onTap: _incrementGuest,
                child: Container(
                  width: 50,
                  height: 50,
                  decoration: const BoxDecoration(
                    color: brandYellow,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(Icons.add, color: primaryText, size: 28),
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 50),
          
          // Continue Button
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // close bottom sheet
                Navigator.of(context).push(
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        PaymentScreen(
                          guestCount: _guestCount, 
                          grabType: "Instant Grab",
                          restaurantName: widget.restaurantName,
                        ),
                    transitionsBuilder: (context, animation, secondaryAnimation, child) {
                      return FadeTransition(
                        opacity: animation,
                        child: SlideTransition(
                          position: Tween<Offset>(
                            begin: const Offset(1.0, 0.0),
                            end: Offset.zero,
                          ).chain(CurveTween(curve: Curves.easeOutQuart)).animate(animation),
                          child: child,
                        ),
                      );
                    },
                    transitionDuration: const Duration(milliseconds: 500),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: brandYellow,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                "Continue to Payment",
                style: GoogleFonts.inter(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  color: primaryText,
                ),
              ),
            ),
          ),
          
          const SizedBox(height: 10), // Bottom padding
        ],
      ),
    );
  }
}

