import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Scaffold(
      backgroundColor: Colors.white,
      body: ProjectsSection(),
    ),
  ));
}

class ProjectsSection extends StatefulWidget {
  @override
  _ProjectsSectionState createState() => _ProjectsSectionState();
}

class _ProjectsSectionState extends State<ProjectsSection> {
  int selectedIndex = -1;

  final List<Map<String, String>> projects = [
    {
      'title': 'AI Powered Health Chatbot',
      'description':
      'Built using Django and Ollama 3, this health chatbot offers users AI-driven medical advice. It responds to natural language inputs and provides instant, context-aware feedback. Designed for accessibility, privacy, and 24/7 support, it helps bridge the gap between healthcare professionals and the general public using intelligent automation.',
      'image': 'https://botup.com/images/ai-chatbot-screenshot-1.png?v=1681707593517652013',
    },
    {
      'title': 'Todo List App',
      'description':
      'A Flutter-based to-do list application that integrates REST APIs for seamless data sync. It offers tagging, due dates, and smart reminders. With clean animations and a futuristic UI, it delivers performance, cloud sync, and a responsive interface to help users stay productive and focused every day.',
      'image': 'https://th.bing.com/th/id/OIP.SBQkA8MAA97QwbVxuLiCqQHaFj?w=288&h=216&c=8&rs=1&qlt=90&o=6&dpr=1.3&pid=3.1&rm=2',
    },
    {
      'title': 'Blinkit Clone',
      'description':
      'This frontend Flutter clone of Blinkit features dynamic category scrolling, item grids, and animated navigation. The clone replicates the look and feel of real-world delivery apps, showcasing best practices in Flutter layout, interactivity, UI performance, and design for ultra-fast grocery experiences.',
      'image': 'https://i.pinimg.com/736x/36/7c/d4/367cd4a3a1510bf52f1acbea26228a57.jpg',
    },
  ];

  @override
  Widget build(BuildContext context) {
    double containerHeight = MediaQuery.of(context).size.height * 0.55;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 30),
          child: ShaderMask(
            shaderCallback: (bounds) {
              return LinearGradient(
                colors: [Colors.cyanAccent, Colors.pinkAccent],
              ).createShader(bounds);
            },
            child: Center(
              child: Text(
                'PROJECTS',
                style: TextStyle(
                  fontFamily: 'Orbitron',
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 3,
                ),
              ),
            ),
          ),
        ),
        Container(
          height: containerHeight,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.white, Color(0xFFE3F2FD)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: ListView(
            physics: selectedIndex == projects.length - 1
                ? AlwaysScrollableScrollPhysics()
                : NeverScrollableScrollPhysics(),
            children: [
              Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.95,
                  ),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(projects.length, (index) {
                        bool isSelected = selectedIndex == index;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedIndex = selectedIndex == index ? -1 : index;
                            });
                          },
                          child: AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            width: isSelected ? 650 : 300,
                            height: containerHeight * 0.9,
                            margin: EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.cyanAccent.withOpacity(0.3),
                                  blurRadius: 15,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(20),
                                    right: Radius.circular(isSelected ? 0 : 20),
                                  ),
                                  child: Image.network(
                                    projects[index]['image']!,
                                    width: 250,
                                    height: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                if (isSelected)
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(20),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          ShaderMask(
                                            shaderCallback: (bounds) {
                                              return LinearGradient(
                                                colors: [
                                                  Colors.cyanAccent,
                                                  Colors.pinkAccent,
                                                ],
                                              ).createShader(bounds);
                                            },
                                            child: Text(
                                              projects[index]['title']!,
                                              style: TextStyle(
                                                fontFamily: 'Orbitron',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                          SizedBox(height: 12),
                                          ShaderMask(
                                            shaderCallback: (bounds) {
                                              return LinearGradient(
                                                colors: [
                                                  Colors.pinkAccent.shade100,
                                                  Colors.cyanAccent.shade100,
                                                ],
                                              ).createShader(bounds);
                                            },
                                            child: Text(
                                              projects[index]['description']!,
                                              style: TextStyle(
                                                fontFamily: 'Orbitron',
                                                fontSize: 13,
                                                height: 1.4,
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
