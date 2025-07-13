import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:auto_size_text/auto_size_text.dart';
import '/styles/home_style.dart';

class SkillsCertificationSection extends StatefulWidget {
  const SkillsCertificationSection({super.key});

  @override
  State<SkillsCertificationSection> createState() => _SkillsCertificationSectionState();
}

class _SkillsCertificationSectionState extends State<SkillsCertificationSection> 
    with SingleTickerProviderStateMixin {
  final ScrollController _skillScrollController = ScrollController();
  final ScrollController _certScrollController = ScrollController();
  bool _showSkillArrows = false;
  bool _showCertArrows = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  final List<Map<String, String>> skills = [
    {"name": "Flutter", "icon": "assets/tech/flutter.png"},
    {"name": "HTML5", "icon": "assets/tech/html5.png"},
    {"name": "CSS3", "icon": "assets/tech/css3.png"},
    {"name": "JavaScript", "icon": "assets/tech/javascript.png"},
    {"name": "Figma", "icon": "assets/tech/figma.png"},
    {"name": "Bootstrap", "icon": "assets/tech/bootstrap.png"},
    {"name": "Go", "icon": "assets/tech/go.png"},
    {"name": "Linux", "icon": "assets/tech/linux.png"},
    {"name": "MongoDB", "icon": "assets/tech/mongodb.png"},
    {"name": "MySQL", "icon": "assets/tech/mysql.png"},
    {"name": "Python", "icon": "assets/tech/python.png"},
    {"name": "Windows", "icon": "assets/tech/windows.png"},
  ];

  final List<Map<String, dynamic>> certificates = [
    {
      "title": "Flutter Course",
      "thumbnail": "assets/certificates/thumbnails/Flutter Course.png",
      "full": "assets/certificates/thumbnails/Flutter Course.png",
      "downloadUrl": "https://drive.google.com/file/d/14V-uMx88BCQhFSJ2oT343LgmuWkpS4AI/view",
    },
    {
      "title": "MTCNA - MikroTik Certified Network Associate",
      "thumbnail": "assets/certificates/thumbnails/MTCNA.png",
      "full": "assets/certificates/thumbnails/MTCNA.png",
      "downloadUrl": "https://drive.google.com/file/d/12DJ5S3VxINVBk238FkeQkD8YmYNBq2up/view",
    },
    {
      "title": "RCNA Routing & Switching",
      "thumbnail": "assets/certificates/thumbnails/RCNA Routing & Switching.png",
      "full": "assets/certificates/thumbnails/RCNA Routing & Switching.png",
      "downloadUrl": "https://drive.google.com/file/d/1qmEPDi1K8aEi_Hu0zqW3uaaBrxzAyYIa/view",
    },
    {
      "title": "RCNA WLAN - Wireless Local Area Network",
      "thumbnail": "assets/certificates/thumbnails/RCNA WLAN.png",
      "full": "assets/certificates/thumbnails/RCNA WLAN.png",
      "downloadUrl": "https://drive.google.com/file/d/1RVBchlVDrhSDU_-H8GqJYlUjN8SPUAUD/view",
    },
    {
      "title": "Riset Sawit BPDPKS",
      "thumbnail": "assets/certificates/thumbnails/Riset Sawit BPDPKS.png",
      "full": "assets/certificates/thumbnails/Riset Sawit BPDPKS.png",
      "downloadUrl": "https://drive.google.com/file/d/1x1yeHXIG5fe8QUaD8BTvvbWvo7kxDAfS/view",
    },
    {
      "title": "Udemy Laravel Framework Complete Course",
      "thumbnail": "assets/certificates/thumbnails/Udemy Laravel.png",
      "full": "assets/certificates/thumbnails/Udemy Laravel.png",
      "downloadUrl": "https://drive.google.com/file/d/1q5oNJrw6CrdJGZXs5UiVkfGmbROQPAj7/view",
    },
  ];

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateArrows();
    });
    _skillScrollController.addListener(_updateArrows);
    _certScrollController.addListener(_updateArrows);
  }

  void _updateArrows() {
    if (_skillScrollController.hasClients) {
      final skillMaxScroll = _skillScrollController.position.maxScrollExtent;
      final skillCurrentScroll = _skillScrollController.position.pixels;
      
      setState(() {
        _showSkillArrows = skillMaxScroll > 0 && 
                         (skillCurrentScroll > 0 || 
                          skillCurrentScroll < skillMaxScroll);
      });
    }

    if (_certScrollController.hasClients) {
      final certMaxScroll = _certScrollController.position.maxScrollExtent;
      final certCurrentScroll = _certScrollController.position.pixels;
      
      setState(() {
        _showCertArrows = certMaxScroll > 0 && 
                         (certCurrentScroll > 0 || 
                          certCurrentScroll < certMaxScroll);
      });
    }
  }

  void _scrollLeft(ScrollController controller) {
    controller.animateTo(
      (controller.offset - 300).clamp(0.0, controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  void _scrollRight(ScrollController controller) {
    controller.animateTo(
      (controller.offset + 300).clamp(0.0, controller.position.maxScrollExtent),
      duration: const Duration(milliseconds: 400),
      curve: Curves.easeOut,
    );
  }

  Widget _buildScrollButton(IconData icon, VoidCallback onPressed, bool isLeft) {
    return AnimatedOpacity(
      opacity: _showSkillArrows ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 200),
      child: Container(
        width: 32,
        height: 32,
        margin: EdgeInsets.only(
          left: isLeft ? 4 : 0,
          right: isLeft ? 0 : 4,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white.withOpacity(0.15),
          border: Border.all(
            color: HomeStyle.accentColor.withOpacity(0.4),
            width: 1,
          ),
        ),
        child: IconButton(
          icon: Icon(icon, size: 18, color: HomeStyle.accentColor),
          style: IconButton.styleFrom(
            padding: EdgeInsets.zero,
            shape: const CircleBorder(),
          ),
          onPressed: onPressed,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
        color: HomeStyle.sectionBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Skills Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Skills',
                  style: HomeStyle.titleTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 140,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _skillScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: skills.map((skill) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 12),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Container(
                                      width: 70,
                                      height: 70,
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        color: Colors.white.withOpacity(0.1),
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          color: HomeStyle.accentColor.withOpacity(0.3),
                                        ),
                                        boxShadow: [
                                          BoxShadow(
                                            color: HomeStyle.accentColor.withOpacity(0.2),
                                            blurRadius: 10,
                                            spreadRadius: 2,
                                          ),
                                        ],
                                      ),
                                      child: Image.asset(
                                        skill['icon']!,
                                        width: 40,
                                        height: 40,
                                        errorBuilder: (context, error, stackTrace) => 
                                          Icon(Icons.broken_image, color: Colors.grey[400]),
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 80,
                                      child: Text(
                                        skill['name']!,
                                        style: HomeStyle.descriptionTextStyle.copyWith(
                                          fontSize: 12,
                                        ),
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      if (_showSkillArrows) ...[
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: _buildScrollButton(
                              Icons.chevron_left,
                              () => _scrollLeft(_skillScrollController),
                              true,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: _buildScrollButton(
                              Icons.chevron_right,
                              () => _scrollRight(_skillScrollController),
                              false,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),

            // Certificates Section
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Certificates',
                  style: HomeStyle.titleTextStyle.copyWith(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  height: 240,
                  child: Stack(
                    children: [
                      SingleChildScrollView(
                        controller: _certScrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Row(
                            children: certificates.map((cert) {
                              return Padding(
                                padding: const EdgeInsets.symmetric(horizontal: 8),
                                child: _buildCertificateCard(context, cert),
                              );
                            }).toList(),
                          ),
                        ),
                      ),
                      if (_showCertArrows) ...[
                        Positioned(
                          left: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: _buildScrollButton(
                              Icons.chevron_left,
                              () => _scrollLeft(_certScrollController),
                              true,
                            ),
                          ),
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          bottom: 0,
                          child: Center(
                            child: _buildScrollButton(
                              Icons.chevron_right,
                              () => _scrollRight(_certScrollController),
                              false,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCertificateCard(BuildContext context, Map<String, dynamic> cert) {
    return GestureDetector(
      onTap: () => _showCertificateDialog(context, cert),
      child: Container(
        width: 200,
        height: 220,
        margin: const EdgeInsets.symmetric(vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white.withOpacity(0.05),
          border: Border.all(
            color: HomeStyle.accentColor.withOpacity(0.2),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12)),
              child: AspectRatio(
                aspectRatio: 4/3,
                child: Image.asset(
                  cert['thumbnail']!,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) => Container(
                    color: Colors.grey[200],
                    child: Center(
                      child: Icon(
                        Icons.broken_image,
                        color: Colors.grey[400],
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: AutoSizeText(
                cert['title']!,
                maxLines: 2,
                minFontSize: 10,
                textAlign: TextAlign.center,
                style: HomeStyle.descriptionTextStyle.copyWith(
                  fontSize: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showCertificateDialog(BuildContext context, Map<String, dynamic> cert) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(20),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: Container(
              color: HomeStyle.sectionBackground,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      cert['title']!,
                      style: HomeStyle.titleTextStyle.copyWith(
                        fontSize: 20,
                        color: HomeStyle.textPrimary,
                      ),
                    ),
                  ),
                  Expanded(
                    child: InteractiveViewer(
                      child: Image.asset(
                        cert['full']!,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Center(
                          child: Text(
                            'Gambar tidak ditemukan',
                            style: HomeStyle.descriptionTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(),
                          child: const Text('Tutup'),
                        ),
                        const SizedBox(width: 16),
                        ElevatedButton(
                          onPressed: () => _launchDownloadUrl(cert['downloadUrl']!),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HomeStyle.accentColor,
                            foregroundColor: Colors.black,
                          ),
                          child: const Text('Unduh'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchDownloadUrl(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Tidak dapat membuka URL')),
        );
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  void dispose() {
    _animationController.dispose();
    _skillScrollController.dispose();
    _certScrollController.dispose();
    super.dispose();
  }
}