import 'dart:async';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../styles/home_style.dart';

class HomeSection extends StatefulWidget {
  final VoidCallback scrollToProjects;
  const HomeSection({
    super.key,
    required this.scrollToProjects,
  });

  @override
  State<HomeSection> createState() => _HomeSectionState();
}

class _HomeSectionState extends State<HomeSection> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;
  bool _isHovered = false;
  
  // State untuk animasi teks
  String _currentText = "";
  bool _isTyping = true;
  bool _showGreeting = true;
  Timer? _typingTimer;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    
    Future.delayed(const Duration(milliseconds: 300), () {
      if (mounted) {
        _controller.forward();
      }
    });
    
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );
    
    _translateAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    // Mulai animasi typing
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    const typingSpeed = 100; // kecepatan mengetik (ms per karakter)
    const pauseBetween = Duration(seconds: 2); // jeda antar teks
    
    const greeting = "Hi, I'm Fajar Kurnia";
    const title = "A Full-Stack Web Developer";

    _typingTimer = Timer.periodic(const Duration(milliseconds: typingSpeed), (timer) {
      if (_isTyping) {
        // Mode mengetik
        if (_showGreeting) {
          if (_currentText.length < greeting.length) {
            setState(() {
              _currentText = greeting.substring(0, _currentText.length + 1);
            });
          } else {
            // Teks sudah selesai diketik, tunggu sebentar lalu mulai hapus
            _isTyping = false;
            Future.delayed(pauseBetween, () {
              if (mounted) setState(() {});
            });
          }
        } else {
          if (_currentText.length < title.length) {
            setState(() {
              _currentText = title.substring(0, _currentText.length + 1);
            });
          } else {
            // Teks sudah selesai diketik, tunggu sebentar lalu mulai hapus
            _isTyping = false;
            Future.delayed(pauseBetween, () {
              if (mounted) setState(() {});
            });
          }
        }
      } else {
        // Mode menghapus
        if (_currentText.isNotEmpty) {
          setState(() {
            _currentText = _currentText.substring(0, _currentText.length - 1);
          });
        } else {
          // Teks sudah terhapus semua, ganti ke teks berikutnya
          _isTyping = true;
          _showGreeting = !_showGreeting;
        }
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _typingTimer?.cancel();
    super.dispose();
  }

  Future<void> _launchCVUrl() async {
    const cvUrl = 'https://drive.google.com/file/d/1VNxrpWXtZahNc6N8O8H1d3m6XBuJO4Wb/view?usp=sharing';
    if (await canLaunchUrl(Uri.parse(cvUrl))) {
      await launchUrl(Uri.parse(cvUrl));
    } else {
      throw 'Could not launch $cvUrl';
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 700;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            HomeStyle.sectionBackground,
            HomeStyle.sectionBackground.withOpacity(0.9),
            Colors.black.withOpacity(0.95),
          ],
        ),
      ),
      padding: HomeStyle.containerPadding(context),
      width: double.infinity,
      child: isMobile
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _buildProfileImage(isMobile),
                const SizedBox(height: 32),
                _buildIntroSection(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildIntroSection(isMobile),
                ),
                Expanded(
                  child: _buildProfileImage(isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildIntroSection(bool isMobile) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _translateAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Padding(
              padding: HomeStyle.contentPadding(context),
              child: Column(
                crossAxisAlignment: isMobile ? CrossAxisAlignment.center : CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    _currentText,
                    style: _showGreeting
                        ? HomeStyle.nameTextStyle.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                            fontSize: isMobile ? 28 : 36,
                          )
                        : HomeStyle.nameTextStyle.copyWith(
                            color: HomeStyle.accentColor,
                            fontWeight: FontWeight.w600,
                            fontSize: isMobile ? 24 : 32,
                          ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Experienced in Frontend, Backend, and Fullstack Development. "
                    "I'm also passionate about UI/UX Design and always learning "
                    "to build impactful digital solutions.",
                    style: HomeStyle.descriptionTextStyle.copyWith(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: isMobile ? 14 : 16,
                    ),
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  ),
                  const SizedBox(height: 32),
                  _buildActionButtons(isMobile),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildActionButtons(bool isMobile) {
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 16,
      runSpacing: 12,
      children: [
        MouseRegion(
          onEnter: (_) => setState(() => _isHovered = true),
          onExit: (_) => setState(() => _isHovered = false),
          child: AnimatedContainer(
            duration: HomeStyle.hoverDuration,
            transform: Matrix4.identity()
              ..translate(0.0, _isHovered ? -5.0 : 0.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: _isHovered
                  ? [
                      BoxShadow(
                        color: HomeStyle.accentColor.withOpacity(0.5),
                        blurRadius: 20,
                        spreadRadius: 2,
                      )
                    ]
                  : null,
            ),
            child: ElevatedButton(
              onPressed: widget.scrollToProjects,
              style: HomeStyle.primaryButtonStyle,
              child: const Text("View Project"),
            ),
          ),
        ),
        MouseRegion(
          cursor: SystemMouseCursors.click,
          child: AnimatedContainer(
            duration: HomeStyle.hoverDuration,
            transform: Matrix4.identity()
              ..scale(_isHovered ? 1.05 : 1.0),
            child: OutlinedButton(
              onPressed: _launchCVUrl,
              style: HomeStyle.secondaryButtonStyle.copyWith(
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) => BorderSide(
                    color: states.contains(MaterialState.hovered)
                        ? Colors.white
                        : HomeStyle.accentColor,
                    width: 2,
                  ),
                ),
                foregroundColor: MaterialStateProperty.resolveWith<Color>(
                  (states) => states.contains(MaterialState.hovered)
                      ? Colors.white
                      : HomeStyle.accentColor,
                ),
              ),
              child: const Text("Download CV"),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Padding(
            padding: HomeStyle.contentPadding(context),
            child: Center(
              child: AnimatedContainer(
                duration: HomeStyle.hoverDuration,
                width: HomeStyle.profileImageSize(context),
                height: HomeStyle.profileImageSize(context),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: HomeStyle.accentColor.withOpacity(0.3),
                      blurRadius: 30,
                      spreadRadius: 5,
                    ),
                  ],
                  border: Border.all(
                    color: Colors.white.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(16),
                  child: Image.asset(
                    'assets/img/profil.jpg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}