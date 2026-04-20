import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'payment_screen.dart';

class ScheduledGrabScreen extends StatefulWidget {
  final String restaurantName;
  const ScheduledGrabScreen({super.key, required this.restaurantName});

  @override
  State<ScheduledGrabScreen> createState() => _ScheduledGrabScreenState();
}

class _ScheduledGrabScreenState extends State<ScheduledGrabScreen> {
  int _guestCount = 4;
  DateTime _selectedDate = DateTime.now();
  String _selectedTime = "";

  final List<DateTime> _dates = [];
  final List<String> _times = [];

  @override
  void initState() {
    super.initState();
    // Generate next 7 dates
    for (int i = 0; i < 7; i++) {
      _dates.add(DateTime.now().add(Duration(days: i)));
    }
    
    // Generate times: 9:00 to 22:00 in 30 min intervals
    int startHour = 9;
    int endHour = 22; // 10 PM
    for (int i = startHour; i <= endHour; i++) {
      _times.add("$i:00");
      if (i != endHour) {
         _times.add("$i:30");
      }
    }
  }

  void _incrementGuest() {
    setState(() {
      _guestCount++;
    });
  }

  void _decrementGuest() {
    if (_guestCount > 0) {
      setState(() {
        _guestCount--;
      });
    }
  }

  String _getDayName(int weekday) {
    const days = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];
    return days[weekday - 1];
  }

  String _getOrdinal(int day) {
    if (day >= 11 && day <= 13) return '${day}th';
    switch (day % 10) {
      case 1: return '${day}st';
      case 2: return '${day}nd';
      case 3: return '${day}rd';
      default: return '${day}th';
    }
  }

  String _getFullMonthName(int month) {
    const months = ['January', 'February', 'March', 'April', 'May', 'June', 'July', 'August', 'September', 'October', 'November', 'December'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    const Color brandYellow = Color(0xFFFFC502);
    const Color primaryText = Color(0xFF111111);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
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
                    "Scheduled Grab",
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
                    // Guests Section
                    Text(
                      "Guests",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ).animate().fade(duration: 400.ms).slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        _buildRoundButton(
                          icon: Icons.remove, 
                          onTap: _decrementGuest,
                          brandYellow: brandYellow,
                        ),
                        const SizedBox(width: 20),
                        Container(
                          width: 140,
                          height: 50,
                          decoration: BoxDecoration(
                            border: Border.all(color: brandYellow, width: 1.5),
                            borderRadius: BorderRadius.circular(25),
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
                                fontSize: 24,
                                fontWeight: FontWeight.w600,
                                color: primaryText,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        _buildRoundButton(
                          icon: Icons.add, 
                          onTap: _incrementGuest,
                          brandYellow: brandYellow,
                        ),
                      ],
                    ).animate().fade(delay: 100.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 36),
                    
                    // Date Section
                    Text(
                      "Date",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ).animate().fade(delay: 200.ms, duration: 400.ms).slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    SizedBox(
                      height: 70,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        itemCount: _dates.length,
                        itemBuilder: (context, index) {
                          DateTime date = _dates[index];
                          bool isSelected = _selectedDate.day == date.day && _selectedDate.month == date.month;
                          
                          return GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedDate = date;
                              });
                            },
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              margin: const EdgeInsets.only(right: 12),
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected ? brandYellow.withOpacity(0.15) : Colors.transparent,
                                border: Border.all(
                                  color: isSelected ? brandYellow : brandYellow.withOpacity(0.5), 
                                  width: isSelected ? 2.5 : 1.5
                                ),
                                borderRadius: BorderRadius.circular(35),
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    _getDayName(date.weekday),
                                    style: GoogleFonts.inter(
                                      fontSize: 11,
                                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w600,
                                      color: primaryText.withOpacity(0.5),
                                    ),
                                  ),
                                  const SizedBox(height: 2),
                                  Text(
                                    "${_getOrdinal(date.day)} ${_getFullMonthName(date.month)}",
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                                      color: primaryText,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).animate().fade(delay: Duration(milliseconds: 250 + (index * 50))).slideX(begin: 0.1, end: 0);
                        },
                      ),
                    ),
                    
                    const SizedBox(height: 36),
                    
                    // Time Section
                    Text(
                      "Time",
                      style: GoogleFonts.inter(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: primaryText,
                      ),
                    ).animate().fade(delay: 400.ms, duration: 400.ms).slideX(begin: -0.2, end: 0),
                    
                    const SizedBox(height: 16),
                    
                    GridView.builder(
                      padding: EdgeInsets.zero,
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        childAspectRatio: 2.1,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 15,
                      ),
                      itemCount: _times.length,
                      itemBuilder: (context, index) {
                        String time = _times[index];
                        bool isSelected = _selectedTime == time;
                        
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedTime = time;
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 200),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: isSelected ? brandYellow.withOpacity(0.15) : Colors.transparent,
                              border: Border.all(
                                color: isSelected ? brandYellow : brandYellow.withOpacity(0.5), 
                                width: isSelected ? 2.5 : 1.5
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              time,
                              style: GoogleFonts.inter(
                                fontSize: 16,
                                fontWeight: isSelected ? FontWeight.w800 : FontWeight.w700,
                                color: primaryText,
                              ),
                            ),
                          ),
                        ).animate().fade(delay: Duration(milliseconds: 450 + (index * 15))).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1));
                      },
                    ),
                    
                    const SizedBox(height: 50),
                    
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) =>
                                  PaymentScreen(
                                    guestCount: _guestCount, 
                                    grabType: "Scheduled Grab",
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
                          "Continue",
                          style: GoogleFonts.inter(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: primaryText,
                          ),
                        ),
                      ),
                    ).animate().fade(delay: 700.ms, duration: 400.ms).slideY(begin: 0.1, end: 0),
                    
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRoundButton({required IconData icon, required VoidCallback onTap, required Color brandYellow}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: brandYellow,
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: const Color(0xFF111111)),
      ),
    );
  }
}
