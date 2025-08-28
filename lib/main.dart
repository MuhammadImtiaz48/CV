import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';
import 'package:chewie/chewie.dart';

void main() {
  runApp(const CVApp());
}

class ProjectController extends GetxController {
  final projects = <Project>[].obs;
  final currentVideoIndex = (-1).obs;
  final isLoadingVideo = false.obs;
  ChewieController? videoController;
  VideoPlayerController? videoPlayerController;

  @override
  void onInit() {
    super.onInit();
    // Initialize projects
    projects.assignAll([
      Project(
        title: 'MeChat – Real-time Chat App',
        description: 'A modern chat application with Firebase, WebRTC & real-time messaging.',
        githubUrl: 'https://github.com/MuhammadImtiaz48',
        videoUrl: 'assets/vedios/Mechat_vedio.mp4',
        status: 'In Progress',
        technologies: ['Flutter', 'Firebase', 'WebRTC', 'Dart'],
      ),
      Project(
        title: 'Real Estate App',
        description: 'Property listings and management application with advanced filters.',
        githubUrl: 'https://github.com/MuhammadImtiaz48/real_estate.git',
        videoUrl: 'assets/vedios/Realix_real_estate_app_vedio.mp4',
        status: 'In Progress',
        technologies: ['Flutter', 'Dart', 'REST API', 'Firebase'],
      ),
    ]);
  }

  void playVideo(int index, String videoUrl) async {
    // Dispose previous controller if exists
    if (videoController != null) {
      videoController!.dispose();
      videoController = null;
    }
    
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
      videoPlayerController = null;
    }
    
    currentVideoIndex.value = index;
    isLoadingVideo.value = true;
    
    try {
      videoPlayerController = VideoPlayerController.asset(videoUrl);
      await videoPlayerController!.initialize();
      
      videoController = ChewieController(
        videoPlayerController: videoPlayerController!,
        autoPlay: true,
        looping: false,
        allowFullScreen: true,
        allowMuting: true,
        showControls: true,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.indigo,
          handleColor: Colors.indigoAccent,
          backgroundColor: Colors.grey[200]!,
          bufferedColor: Colors.grey[300]!,
        ),
        placeholder: Container(
          color: Colors.grey[200],
          child: const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.indigo),
            ),
          ),
        ),
        errorBuilder: (context, errorMessage) {
          return Container(
            color: Colors.grey[200],
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, color: Colors.red, size: 40),
                  const SizedBox(height: 10),
                  Text(
                    'Failed to load video',
                    style: TextStyle(
                      color: Colors.grey[700],
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: () => playVideo(index, videoUrl),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                    ),
                    child: const Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
          );
        },
      );
      
      isLoadingVideo.value = false;
      update();
    } catch (e) {
      isLoadingVideo.value = false;
      Get.snackbar(
        'Error', 
        'Failed to load video: $e',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        borderRadius: 12,
        margin: const EdgeInsets.all(16),
        icon: const Icon(Icons.error_outline, color: Colors.white),
      );
    }
  }

  void stopVideo() {
    if (videoController != null) {
      videoController!.dispose();
      videoController = null;
    }
    
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
      videoPlayerController = null;
    }
    
    currentVideoIndex.value = -1;
    isLoadingVideo.value = false;
    update();
  }

  @override
  void onClose() {
    if (videoController != null) {
      videoController!.dispose();
    }
    
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    
    super.onClose();
  }
}

class Project {
  final String title;
  final String description;
  final String githubUrl;
  final String videoUrl;
  final String status;
  final List<String> technologies;

  Project({
    required this.title,
    required this.description,
    required this.githubUrl,
    required this.videoUrl,
    required this.status,
    required this.technologies,
  });
}

class CVApp extends StatelessWidget {
  const CVApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Muhammad Imtiaz - Flutter Developer',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Roboto',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.white),
        ),
      ),
      home: const CVScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CVScreen extends StatelessWidget {
  const CVScreen({super.key});
  
  final double iconSize = 24.0;
  final double sectionSpacing = 25.0;

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

  Future<void> _launchWhatsApp() async {
    final Uri whatsappUri = Uri.parse('https://wa.me/923410333820');
    if (!await launchUrl(whatsappUri)) {
      throw Exception('Could not launch WhatsApp');
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
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height,
              ),
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
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      padding: const EdgeInsets.all(30),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          
          return isWideScreen 
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildProfileImage(70),
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
              )
            : Column(
                children: [
                  _buildProfileImage(60),
                  const SizedBox(height: 20),
                  Text(
                    'Muhammad Imtiaz',
                    style: TextStyle(
                      fontSize: 28,
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
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    'Flutter Developer',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.white.withOpacity(0.9),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
        },
      ),
    );
  }

  Widget _buildProfileImage(double radius) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.white, width: 3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: CircleAvatar(
        radius: radius,
        backgroundColor: Colors.grey[300],
        child: ClipOval(
          child: Image.asset(
            'assets/images/ppp.jpg',
            width: radius * 2,
            height: radius * 2,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) => Icon(
              Icons.person,
              size: radius,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }

  // 🔹 Contact Info
  Widget _buildContactInfo() {
    return Container(
      color: const Color(0xFFf8fafc),
      padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWideScreen = constraints.maxWidth > 600;
          
          if (isWideScreen) {
            return Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: _buildContactItem(Icons.phone, '+92 341 0333820', _launchWhatsApp),
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
            );
          } else {
            return Column(
              children: [
                _buildContactItem(Icons.phone, '+92 341 0333820', _launchWhatsApp),
                const SizedBox(height: 15),
                _buildContactItem(Icons.email, 'cose101048@gmail.com', _launchEmail),
                const SizedBox(height: 15),
                _buildContactItem(Icons.location_on, 'Sadiqabad, Rahim Yar Khan, Punjab', () {}),
                const SizedBox(height: 15),
                _buildContactItem(Icons.code, 'GitHub: MuhammadImtiaz48',
                    () => _launchUrl('https://github.com/MuhammadImtiaz48')),
              ],
            );
          }
        },
      ),
    );
  }

  Widget _buildContactItem(IconData icon, String text, VoidCallback onTap) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          margin: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  gradient: const LinearGradient(colors: [Color(0xFF4f46e5), Color(0xFF7c3aed)]),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.indigo.withOpacity(0.3),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Icon(icon, color: Colors.white, size: 20),
              ),
              const SizedBox(width: 15),
              Expanded(
                child: Text(
                  text,
                  style: const TextStyle(fontSize: 14, color: Color(0xFF4b5563), fontWeight: FontWeight.w500),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // 🔹 Content Body
  Widget _buildContent(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSection('Professional Objective', _buildObjective()),
          _buildSection('Education', _buildEducation()),
          _buildSection('Experience', _buildExperience()),
          _buildSection('Technical Skills', _buildSkills(context)),
          _buildSection('Projects', _buildProjects(context)),
          _buildSection('Languages & Interests', _buildLanguagesInterests()),
        ],
      ),
    );
  }

  Widget _buildSection(String title, Widget content) {
    return Padding(
      padding: EdgeInsets.only(bottom: sectionSpacing),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 24,
                width: 5,
                decoration: BoxDecoration(
                  color: const Color(0xFF4f46e5),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22, 
                  fontWeight: FontWeight.w600, 
                  color: Color(0xFF4f46e5),
                ),
              ),
            ],
          ),
          const SizedBox(height: 15),
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
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFf5f7ff),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFe0e7ff), width: 1),
      ),
      child: const Text(
        '🎓 BSCS (Final Semester – In Progress)\n'
        'Khwaja Fareed University of Engineering & Information Technology (KFUEIT)',
        style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
      ),
    );
  }

  Widget _buildExperience() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFf5f7ff),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFe0e7ff), width: 1),
      ),
      child: const Text(
        '👨‍💻 Flutter Developer – 2 Years Freelance & Self-employed\n'
        '• Built cross-platform apps with Flutter & Dart\n'
        '• Integrated Firebase Auth, Firestore & Push Notifications\n'
        '• Developed real-time chat, property management apps\n'
        '• Worked with modern UI/UX and clean architecture',
        style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
      ),
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
        return Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF4f46e5), Color(0xFF7c3aed)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.indigo.withOpacity(0.3),
                blurRadius: 5,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            s, 
            style: const TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w500),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProjects(BuildContext context) {
    return GetBuilder<ProjectController>(
      init: ProjectController(),
      builder: (controller) {
        return Column(
          children: [
            ...controller.projects.map((project) => _buildProjectCard(project, controller, context)).toList(),
          ],
        );
      },
    );
  }

  Widget _buildProjectCard(Project project, ProjectController controller, BuildContext context) {
    final isCurrentVideo = controller.currentVideoIndex.value == controller.projects.indexOf(project);
    final isWideScreen = MediaQuery.of(context).size.width > 600;
    final isVideoLoading = controller.isLoadingVideo.value && isCurrentVideo;
    
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    '📱 ${project.title}',
                    style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18, color: Color(0xFF374151)),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4f46e5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    project.status,
                    style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              project.description,
              style: const TextStyle(color: Color(0xFF6b7280), fontSize: 16, height: 1.5),
            ),
            const SizedBox(height: 12),
            
            // Technology chips
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: project.technologies.map((tech) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFeef2ff),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Text(
                    tech,
                    style: const TextStyle(fontSize: 12, color: Color(0xFF4f46e5), fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
            ),
            
            const SizedBox(height: 15),
            
            // Video section
            if (isVideoLoading)
              Container(
                height: isWideScreen ? 250 : 180,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Center(
                  child: CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF4f46e5)),
                  ),
                ),
              )
            else if (isCurrentVideo && controller.videoController != null)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Colors.grey[300]!),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: AspectRatio(
                    aspectRatio: isWideScreen 
                      ? 16/9 
                      : controller.videoController!.videoPlayerController.value.aspectRatio > 0
                        ? controller.videoController!.videoPlayerController.value.aspectRatio
                        : 16/9,
                    child: Chewie(controller: controller.videoController!),
                  ),
                ),
              )
            else
              GestureDetector(
                onTap: () => controller.playVideo(controller.projects.indexOf(project), project.videoUrl),
                child: Container(
                  height: isWideScreen ? 250 : 180,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.play_arrow, size: 40, color: Colors.white),
                    ),
                  ),
                ),
              ),
            
            const SizedBox(height: 15),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    icon: const Icon(Icons.code, size: 18),
                    label: const Text('View Code'),
                    onPressed: () => _launchUrl(project.githubUrl),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color(0xFF4f46e5),
                      side: const BorderSide(color: Color(0xFF4f46e5)),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                if (isCurrentVideo)
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.stop, size: 18),
                      label: const Text('Stop Video'),
                      onPressed: () => controller.stopVideo(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF4f46e5),
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguagesInterests() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: const Color(0xFFf5f7ff),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFFe0e7ff), width: 1),
      ),
      child: const Text(
        '🌐 Languages: English (Professional), Urdu (Native)\n'
        '💡 Interests: Mobile App Development, UI/UX, Open-source Contribution',
        style: TextStyle(fontSize: 16, height: 1.6, color: Color(0xFF4b5563)),
      ),
    );
  }
}