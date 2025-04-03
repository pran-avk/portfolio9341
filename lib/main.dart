import 'package:flutter/material.dart';
import 'package:portfolio/PAges/AboutMe.dart';
import 'package:portfolio/PAges/HomePAge.dart';
import 'package:portfolio/PAges/Skills.dart';
import 'package:portfolio/PAges/certificates.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MainPage(),
  ));
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final ScrollController _scrollController = ScrollController();
  int _selectedIndex = 0;
  int _hoveredIndex = -1;

  void _scrollToSection(int index) {
    double position = index * MediaQuery.of(context).size.height;
    _scrollController.animateTo(
      position,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _onScroll() {
    double offset = _scrollController.offset;
    double screenHeight = MediaQuery.of(context).size.height;
    int newIndex = (offset / screenHeight).round();
    if (newIndex != _selectedIndex) {
      setState(() {
        _selectedIndex = newIndex;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    bool isMobile = screenWidth < 600; // Check for mobile screen

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                HomeSection(),
                AboutMeSection(),
                ProjectsSection(),
                CertificatesSection(),
              ],
            ),
          ),

          // 🔝 Centered Navigation Bar (Responsive)
          Positioned(
            top: 10,
            left: isMobile ? 10 : screenWidth * 0.3, // Adjust for mobile
            right: isMobile ? 10 : screenWidth * 0.3,
            height: 50,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal, // Allows scrolling on small screens
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(40),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 5,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 10,
                  children: [
                    NavbarText(text: "Home", index: 0, selectedIndex: _selectedIndex, hoveredIndex: _hoveredIndex, onTap: () => _scrollToSection(0), onHover: (hover) { setState(() { _hoveredIndex = hover ? 0 : -1; }); }),
                    NavbarText(text: "About Me", index: 1, selectedIndex: _selectedIndex, hoveredIndex: _hoveredIndex, onTap: () => _scrollToSection(1), onHover: (hover) { setState(() { _hoveredIndex = hover ? 1 : -1; }); }),
                    NavbarText(text: "Projects", index: 2, selectedIndex: _selectedIndex, hoveredIndex: _hoveredIndex, onTap: () => _scrollToSection(2), onHover: (hover) { setState(() { _hoveredIndex = hover ? 2 : -1; }); }),
                    NavbarText(text: "Certificates", index: 3, selectedIndex: _selectedIndex, hoveredIndex: _hoveredIndex, onTap: () => _scrollToSection(3), onHover: (hover) { setState(() { _hoveredIndex = hover ? 3 : -1; }); }),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NavbarText extends StatelessWidget {
  final String text;
  final int index;
  final int selectedIndex;
  final int hoveredIndex;
  final VoidCallback onTap;
  final Function(bool)? onHover;

  const NavbarText({
    Key? key,
    required this.text,
    required this.index,
    required this.selectedIndex,
    required this.hoveredIndex,
    required this.onTap,
    this.onHover,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isHovered = index == hoveredIndex;
    bool isSelected = index == selectedIndex;

    return MouseRegion(
      onEnter: (_) => onHover?.call(true),
      onExit: (_) => onHover?.call(false),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: isSelected ? Colors.black : Colors.transparent,
            borderRadius: BorderRadius.circular(5),
            border: isHovered
                ? Border.all(color: Colors.black, width: 2)
                : Border.all(color: Colors.transparent, width: 0),
          ),
          child: Text(
            text,
            style: TextStyle(
              fontSize: 16, // Slightly reduced for better fit
              fontWeight: FontWeight.bold,
              fontFamily: 'Pacifico',
              color: isSelected ? Colors.white : Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
