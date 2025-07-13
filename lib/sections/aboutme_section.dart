import 'package:flutter/material.dart';
import '../styles/aboutme_style.dart';

class AboutMeSection extends StatefulWidget {
  const AboutMeSection({super.key});

  @override
  State<AboutMeSection> createState() => _AboutMeSectionState();
}

class _AboutMeSectionState extends State<AboutMeSection> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;
  late Animation<Color?> _borderColorAnimation;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: AboutMeStyle.entranceDuration,
      vsync: this,
    )..forward();
    
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
    
    _translateAnimation = Tween<double>(begin: 50, end: 0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeOut,
      ),
    );

    _borderColorAnimation = ColorTween(
      begin: AboutMeStyle.accentColor.withOpacity(0.3),
      end: AboutMeStyle.accentColor.withOpacity(0.7),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
            AboutMeStyle.sectionBackground,
            AboutMeStyle.sectionBackground.withOpacity(0.9),
            Colors.black.withOpacity(0.95),
          ],
        ),
      ),
      padding: AboutMeStyle.containerPadding(context),
      child: isMobile
          ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildProfileImage(isMobile),
                const SizedBox(height: 32),
                _buildAboutText(isMobile),
              ],
            )
          : Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: _buildProfileImage(isMobile),
                ),
                Expanded(
                  child: _buildAboutText(isMobile),
                ),
              ],
            ),
    );
  }

  Widget _buildProfileImage(bool isMobile) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _opacityAnimation.value,
          child: Padding(
            padding: EdgeInsets.all(isMobile ? 16 : 24),
            child: Center(
              child: MouseRegion(
                onEnter: (_) => setState(() => _isHovered = true),
                onExit: (_) => setState(() => _isHovered = false),
                child: AnimatedContainer(
                  duration: AboutMeStyle.hoverDuration,
                  width: AboutMeStyle.profileImageSize(context),
                  height: AboutMeStyle.profileImageSize(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: AboutMeStyle.accentColor
                            .withOpacity(_isHovered ? 0.3 : 0.1),
                        blurRadius: _isHovered ? 40 : 30,
                        spreadRadius: _isHovered ? 8 : 5,
                      ),
                    ],
                    border: Border.all(
                      color: _borderColorAnimation.value!,
                      width: _isHovered ? 3 : 2,
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
          ),
        );
      },
    );
  }

  Widget _buildAboutText(bool isMobile) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, _translateAnimation.value),
          child: Opacity(
            opacity: _opacityAnimation.value,
            child: Padding(
              padding: EdgeInsets.all(isMobile ? 16 : 24),
              child: Column(
                crossAxisAlignment: isMobile 
                    ? CrossAxisAlignment.center 
                    : CrossAxisAlignment.start,
                children: [
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 300),
                    child: _isHovered
                        ? Text(
                            'About Me',
                            key: const ValueKey('about'),
                            style: AboutMeStyle.titleTextStyle.copyWith(
                              color: AboutMeStyle.accentColor,
                            ),
                          )
                        : Text(
                            'About Me',
                            key: const ValueKey('about'),
                            style: AboutMeStyle.titleTextStyle,
                          ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'I am an active student majoring in Informatics with a focus on programming. '
                    'Experienced in working on projects as a Frontend, Backend, and Fullstack Developer, '
                    'and have an interest in UI/UX Design. I continue to develop my technical and design '
                    'skills to create digital solutions that are functional and user-friendly.',
                    style: AboutMeStyle.bodyTextStyle,
                    textAlign: isMobile ? TextAlign.center : TextAlign.start,
                  ),
                  const SizedBox(height: 24),
                  _buildSkillChips(isMobile),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSkillChips(bool isMobile) {
    final skills = [
      // 'Flutter',
      // 'Dart',
      // 'JavaScript',
      // 'React',
      // 'Node.js',
      // 'UI/UX Design',
      // 'Firebase',
      // 'MongoDB',
    ];
    
    return Wrap(
      alignment: isMobile ? WrapAlignment.center : WrapAlignment.start,
      spacing: 8,
      runSpacing: 8,
      children: skills.map((skill) {
        return AnimatedContainer(
          duration: AboutMeStyle.hoverDuration,
          transform: Matrix4.identity()
            ..scale(_isHovered ? 1.05 : 1.0),
          child: Chip(
            backgroundColor: AboutMeStyle.accentColor.withOpacity(0.1),
            label: Text(
              skill,
              style: TextStyle(
                color: AboutMeStyle.accentColor,
                fontWeight: FontWeight.w600,
              ),
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(
                color: AboutMeStyle.accentColor.withOpacity(0.3),
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}