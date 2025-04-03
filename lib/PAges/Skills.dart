import 'package:flutter/material.dart';
class ProjectsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.orange,
      alignment: Alignment.center,
      child: Text("💻 My Projects: Showcasing Work", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}