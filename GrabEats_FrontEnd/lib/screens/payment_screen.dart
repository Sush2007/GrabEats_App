import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'dashboard_screen.dart';
import '../models/orders_manager.dart';

class PaymentScreen extends StatefulWidget {
  final int guestCount;
  final String grabType; // "Instant Grab" or "Scheduled Grab"
  final String restaurantName;

  const PaymentScreen({
    super.key, 
    required this.guestCount, 
    required this.grabType,
    required this.restaurantName,
  });

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  int _selectedPaymentMethod = 0; // 0: Card, 1: Apple Pay, 2: Google Pay
  bool _isProcessing = false;
  bool _isSuccess = false;

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          SafeArea(
            top: false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header
            Container(
              padding: const EdgeInsets.only(top: 60, bottom: 40, left: 24, right: 24),
              decoration: const BoxDecoration(
                color: brandYellow,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(50),
                  bottomRight: Radius.circular(50),
                ),
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: const Icon(Icons.arrow_back, size: 32, color: primaryText),
                    ),
                  ),
                  Text(
                    "Checkout",
                    style: GoogleFonts.inter(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: primaryText,
                    ),
                  ),
                ],
              ),
            ),
            
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Section
                    Text(
                      "Order Summary",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ).animate().fade().slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: Colors.grey.shade200),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.03),
                            blurRadius: 10,
                            offset: const Offset(0, 5),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          _buildSummaryRow("Type", widget.grabType),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(height: 1),
                          ),
                          _buildSummaryRow("Guests", "${widget.guestCount} People"),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 16),
                            child: Divider(height: 1),
                          ),
                          _buildSummaryRow("Reservation Fee", "Free"),
                        ],
                      ),
                    ).animate().fade(delay: 100.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 40),
                    
                    // Payment Methods
                    Text(
                      "Payment Method",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ).animate().fade(delay: 200.ms).slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    _buildPaymentMethod(
                      index: 0,
                      title: "Credit / Debit Card",
                      icon: Icons.credit_card,
                    ).animate().fade(delay: 300.ms).slideX(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 12),
                    

                    _buildPaymentMethod(
                      index: 2,
                      title: "Google Pay",
                      imagePath: 'lib/assets/google_logo.png',
                    ).animate().fade(delay: 500.ms).slideX(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 50),
                    
                    // Pay Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: _isProcessing 
                            ? null 
                            : () async {
                                setState(() {
                                  _isProcessing = true;
                                  _isSuccess = false;
                                });
                                
                                // Simulate network processing delay
                                await Future.delayed(const Duration(seconds: 2));
                                
                                OrdersManager().addOrder(Order(
                                  restaurantName: widget.restaurantName,
                                  grabType: widget.grabType,
                                  guestCount: widget.guestCount,
                                  timestamp: DateTime.now(),
                                ));
                                
                                setState(() {
                                  _isSuccess = true;
                                });
                                
                                // Wait for success animation
                                await Future.delayed(const Duration(seconds: 2));
                                
                                if (mounted) {
                                  Navigator.of(context).pushAndRemoveUntil(
                                    PageRouteBuilder(
                                      pageBuilder: (context, animation, secondaryAnimation) => const DashboardScreen(),
                                      transitionsBuilder: (context, animation, secondaryAnimation, child) {
                                        return FadeTransition(opacity: animation, child: child);
                                      },
                                      transitionDuration: const Duration(milliseconds: 600),
                                    ),
                                    (route) => false,
                                  );
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: brandYellow,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Text(
                          "Confirm & Pay",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: primaryText,
                          ),
                        ),
                      ),
                    ).animate().fade(delay: 600.ms).slideY(begin: 0.2, end: 0),
                    
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
          ),
          
          // The loading overlay
          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.white.withOpacity(0.95),
                child: Center(
                  child: AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    child: _isSuccess
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 100,
                                height: 100,
                                decoration: const BoxDecoration(
                                  color: brandYellow,
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 60,
                                ).animate().scale(delay: 200.ms, duration: 400.ms, curve: Curves.easeOutBack),
                              ).animate().scale(duration: 400.ms, curve: Curves.easeOutBack),
                              const SizedBox(height: 24),
                              Text(
                                "Payment Successful!",
                                style: GoogleFonts.inter(
                                  fontSize: 24,
                                  fontWeight: FontWeight.w800,
                                  color: primaryText,
                                ),
                              ).animate().fade(delay: 400.ms).slideY(begin: 0.2, end: 0),
                            ],
                          )
                        : Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              SizedBox(
                                width: 80,
                                height: 80,
                                child: CircularProgressIndicator(
                                  valueColor: const AlwaysStoppedAnimation<Color>(brandYellow),
                                  strokeWidth: 6,
                                  backgroundColor: brandYellow.withOpacity(0.2),
                                ),
                              ),
                              const SizedBox(height: 30),
                              Text(
                                "Processing Payment...",
                                style: GoogleFonts.inter(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                  color: primaryText,
                                ),
                              ).animate(onPlay: (controller) => controller.repeat(reverse: true)).fade(begin: 0.5, end: 1.0, duration: 800.ms),
                            ],
                          ),
                  ),
                ),
              ).animate().fade(duration: 300.ms),
            ),
        ],
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    const Color primaryText = Color(0xFF111111);
    
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryText.withOpacity(0.6),
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: primaryText,
          ),
        ),
      ],
    );
  }

  Widget _buildPaymentMethod({required int index, required String title, IconData? icon, String? imagePath}) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);
    bool isSelected = _selectedPaymentMethod == index;

    return Column(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedPaymentMethod = index;
            });
          },
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isSelected ? brandYellow.withOpacity(0.1) : Colors.white,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isSelected ? brandYellow : Colors.grey.shade200,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                if (icon != null)
                  Icon(icon, size: 28, color: primaryText)
                else if (imagePath != null)
                  Image.asset(imagePath, width: 28, height: 28),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.inter(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w600,
                      color: primaryText,
                    ),
                  ),
                ),
                if (isSelected)
                  const Icon(Icons.check_circle, color: brandYellow, size: 24)
                else
                  Icon(Icons.circle_outlined, color: Colors.grey.shade300, size: 24),
              ],
            ),
          ),
        ),
        
        // Show Credit Card Form if selected
        if (index == 0)
          AnimatedSize(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            alignment: Alignment.topCenter,
            child: isSelected
                ? Container(
                    margin: const EdgeInsets.only(top: 12),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.grey.shade200),
                    ),
                    child: Column(
                      children: [
                        _buildTextField("Card Number", "0000 0000 0000 0000", TextInputType.number),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(child: _buildTextField("Expiry Date", "MM/YY", TextInputType.datetime)),
                            const SizedBox(width: 16),
                            Expanded(child: _buildTextField("CVV", "123", TextInputType.number)),
                          ],
                        ),
                        const SizedBox(height: 16),
                        _buildTextField("Cardholder Name", "John Doe", TextInputType.name),
                      ],
                    ),
                  )
                : const SizedBox(width: double.infinity, height: 0),
          ),
      ],
    );
  }

  Widget _buildTextField(String label, String hint, TextInputType type) {
    const Color primaryText = Color(0xFF111111);
    const Color brandYellow = Color(0xFFFFC502);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: primaryText.withOpacity(0.8),
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          keyboardType: type,
          style: GoogleFonts.inter(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: primaryText,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.inter(
              color: Colors.grey.shade400,
              fontWeight: FontWeight.w500,
            ),
            filled: true,
            fillColor: Colors.grey.shade50,
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: brandYellow, width: 2),
            ),
          ),
        ),
      ],
    );
  }
}
