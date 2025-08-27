import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const CVApp());
}

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Muhammad Imtiaz CV',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
      ),
      home: const CVScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CVScreen extends StatelessWidget {
  const CVScreen({super.key});

  Future<void> _launchUrl(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  Future<void> _launchEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'cose101048@gmail.com',
      query: 'subject=Job Opportunity&body=Hello Muhammad,',
    );
    if (!await launchUrl(emailUri)) {
      throw Exception('Could not launch email');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF667eea), Color(0xFF764ba2)],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.15),
                    blurRadius: 30,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                children: [
                  _buildHeader(),
                  _buildContactInfo(),
                  _buildContent(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Header with Image
  Widget _buildHeader() {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFF4f46e5), Color(0xFF7c3aed)],
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: 60,
            backgroundImage: const AssetImage('assets/images/ppp.jpg'),
            backgroundColor: Colors.grey[300],
          ),
          const SizedBox(width: 25),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Muhammad Imtiaz',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'Flutter Developer',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w400,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Contact Info
  Widget _buildContactInfo() {
    return Container(
      color: const Color(0xFFf8fafc),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 30),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildContactItem(Icons.phone, '0341-0333820', () {}),
              ),
              Expanded(
                child: _buildContactItem(Icons.email, 'cose101048@gmail.com', _launchEmail),
              ),
            ],
          ),
          const SizedBox(height: 15),
          Row(
            children: [
              Expanded(
                child: _buildContactItem(Icons.location_on, 'Sadiqabad, Rahim Yar Khan, Punjab', () {}),
              ),
              Expanded(
                child: _buildContactItem(Icons.code, 'GitHub: MuhammadImtiaz48',
                    () => _launchUrl('https://github.com/MuhammadImtiaz48')),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 38,
            height: 38,
            decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [Color(0xFF4f46e5), Color(0xFF7c3aed)]),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 14, color: Color(0xFF4b5563)),
            ),
          ),
        ],
      ),
    );
  }

  // 🔹 Content Body
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Professional Objective', _buildObjective()),
          _buildSection('Education', _buildEducation()),
          _buildSection('Experience', _buildExperience()),
          _buildSection('Technical Skills', _buildSkills(context)),
          _buildSection('Projects', _buildProjects()),
          _buildSection('Languages & Interests', _buildLanguagesInterests()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Color(0xFF4f46e5))),
          const SizedBox(height: 10),
          content,
        ],
      ),
    );
  }

  Widget _buildObjective() {
    return const Text(
      'Passionate Flutter Developer with 2 years of experience building scalable, cross-platform apps using Flutter & Firebase. '
      'Currently completing BSCS (Final Semester) from KFUEIT. Looking to contribute technical expertise and innovative solutions in a dynamic team.',
      style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
      textAlign: TextAlign.justify,
    );
  }

  Widget _buildEducation() {
    return const Text(
      '🎓 BSCS (Final Semester – In Progress)\n'
      'Khwaja Fareed University of Engineering & Information Technology (KFUEIT)',
      style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
    );
  }

  Widget _buildExperience() {
    return const Text(
      '👨‍💻 Flutter Developer – 2 Years Freelance & Self-employed\n'
      '• Built cross-platform apps with Flutter & Dart\n'
      '• Integrated Firebase Auth, Firestore & Push Notifications\n'
      '• Developed real-time chat, property management apps\n'
      '• Worked with modern UI/UX and clean architecture',
      style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
    );
  }

  Widget _buildSkills(BuildContext context) {
    final skills = [
      'Flutter', 'Dart', 'Firebase', 'REST APIs',
      'Git & GitHub', 'Clean Architecture', 'GetX / Provider'
    ];
    return Wrap(
      spacing: 10,
      runSpacing: 10,
      children: skills.map((s) {
        return Chip(
          label: Text(s, style: const TextStyle(color: Colors.white)),
          backgroundColor: const Color(0xFF4f46e5),
        );
      }).toList(),
    );
  }

  Widget _buildProjects() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('📱 MeChat – Real-time Chat App (In Progress)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 5),
        const Text('A modern chat application with Firebase, WebRTC & real-time messaging.',
            style: TextStyle(color: Color(0xFF4b5563))),
        const SizedBox(height: 15),
        const Text('🏡 Real Estate App – Property Listings (In Progress)',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16)),
        const SizedBox(height: 5),
        GestureDetector(
          onTap: () => _launchUrl('https://github.com/MuhammadImtiaz48/real_estate.git'),
          child: const Text(
            'GitHub Repository → Click Here',
            style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
          ),
        ),
      ],
    );
  }

  Widget _buildLanguagesInterests() {
    return const Text(
      '🌐 Languages: English (Professional), Urdu (Native)\n'
      '💡 Interests: Mobile App Development, UI/UX, Open-source Contribution',
      style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
    );
  }
}
