import 'package:flutter/material.dart';
class CertificatesSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      color: Colors.purple,
      alignment: Alignment.center,
      child: Text("📜 Certificates & Achievements", style: TextStyle(fontSize: 28, color: Colors.white, fontWeight: FontWeight.bold)),
    );
  }
}