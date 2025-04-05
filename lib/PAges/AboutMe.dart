import 'package:flutter/material.dart';
import 'package:visibility_detector/visibility_detector.dart';

class AboutMeSection extends StatefulWidget {
  @override
  _AboutMeSectionState createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late List<Animation<double>> _fadeAnimations;

  final List<String> lines = [
    "I am a passionate developer with expertise in Flutter, Django, and AI/ML.",
    "I enjoy building innovative and scalable applications that push the boundaries of technology.",
    "My focus is on deepening AI knowledge, refining competitive programming skills, and working on impactful AI-driven projects.",
    "I love solving real-world problems through technology and always strive to learn and grow.",
    "Whether it's mobile app development, AI-powered solutions, or backend systems, I aim to create something meaningful and efficient."
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _fadeAnimations = List.generate(
      lines.length,
          (index) => Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.15, 1.0, curve: Curves.easeIn),
        ),
      ),
    );
  }

  void _startAnimation() {
    if (!_controller.isAnimating && !_controller.isCompleted) {
      _controller.forward();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600;

    return VisibilityDetector(
      key: Key("about_me_section"),
      onVisibilityChanged: (visibilityInfo) {
        if (visibilityInfo.visibleFraction > 0.3) {
          _startAnimation();
        }
      },
      child: Container(
        height: MediaQuery.of(context).size.height,
        color: Colors.white,
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: isMobile ? 20 : 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Cyberpunk-Themed Heading
            Center(
              child: ShaderMask(
                shaderCallback: (bounds) => LinearGradient(
                  colors: [Color(0xff00FFFF), Color(0xffFF00FF)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ).createShader(bounds),
                child: Text(
                  "ABOUT ME",
                  style: TextStyle(
                    fontSize: isMobile ? 36 : 50,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),

            // Animated Text Lines
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: List.generate(lines.length, (index) {
                return AnimatedBuilder(
                  animation: _fadeAnimations[index],
                  builder: (context, child) {
                    return Opacity(
                      opacity: _fadeAnimations[index].value,
                      child: Padding(
                        padding: EdgeInsets.only(bottom: 8),
                        child: ShaderMask(
                          shaderCallback: (bounds) => LinearGradient(
                            colors: [Color(0xffFF00FF), Color(0xff00FFFF)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ).createShader(bounds),
                          child: Text(
                            lines[index],
                            style: TextStyle(
                              fontSize: isMobile ? 20 : 32,
                              fontWeight: FontWeight.bold,
                              height: 1.5,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
