import 'package:flutter/material.dart';
import '/styles/home_style.dart';

class EducationExperienceSection extends StatefulWidget {
  const EducationExperienceSection({super.key});

  @override
  State<EducationExperienceSection> createState() => _EducationExperienceSectionState();
}

class _EducationExperienceSectionState extends State<EducationExperienceSection> 
    with SingleTickerProviderStateMixin {
  final List<bool> _educationExpanded = List.filled(2, false);
  final List<bool> _experienceExpanded = List.filled(3, false);
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: HomeStyle.entranceDuration,
      vsync: this,
    )..forward();
    
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOutQuart,
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    final double containerWidth = isMobile 
        ? MediaQuery.of(context).size.width - 48 
        : (MediaQuery.of(context).size.width - 120) / 2;

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: double.infinity,
        padding: HomeStyle.containerPadding(context),
        color: HomeStyle.sectionBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.center,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Education & Experience',
                    style: TextStyle(
                      fontSize: isMobile ? 28 : 36,
                      fontWeight: FontWeight.w800,
                      color: HomeStyle.textPrimary,
                      letterSpacing: -0.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'My academic background and professional journey',
                    style: TextStyle(
                      fontSize: isMobile ? 14 : 16,
                      fontWeight: FontWeight.w400,
                      color: HomeStyle.textSecondary,
                      height: 1.6,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),
            
            isMobile ? _buildMobileLayout(context, containerWidth) : _buildDesktopLayout(context, containerWidth),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopLayout(BuildContext context, double width) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: width,
            child: _buildEducationColumn(context),
          ),
          const SizedBox(width: 32),
          SizedBox(
            width: width,
            child: _buildExperienceColumn(context),
          ),
        ],
      ),
    );
  }

  Widget _buildMobileLayout(BuildContext context, double width) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(
            width: width,
            child: _buildEducationColumn(context),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: width,
            child: _buildExperienceColumn(context),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationColumn(BuildContext context) {
    return _buildSection(
      context: context,
      title: '📚 Education',
      icon: Icons.school_outlined,
      items: [
        _buildInteractiveItem(
          context: context,
          isExpanded: _educationExpanded[0],
          onTap: () => setState(() => _educationExpanded[0] = !_educationExpanded[0]),
          title: 'S1 Ilmu Komputer',
          subtitle: 'Universitas Metamedia',
          period: '2022–Present',
          description: 'Currently pursuing a S1 in Informatics with a focus on software development and programming.',
          bulletPoints: const [
            'Recipient of 2024 Palm Oil Research Grant from BPDPKS',
            'Active in web development',
          ],
        ),
        const SizedBox(height: 16),
        _buildInteractiveItem(
          context: context,
          isExpanded: _educationExpanded[1],
          onTap: () => setState(() => _educationExpanded[1] = !_educationExpanded[1]),
          title: 'Teknik Komputer dan Jaringan (TKJ)',
          subtitle: 'SMK Muhammadiyah Batam',
          period: '2018–2021',
          description: 'Learned computer networks, hardware, and the basics of programming and IT troubleshooting.',
          bulletPoints: const [
            'Specialized in network administration',
            'Internship as IT Support at Bapelkes',
          ],
        ),
      ],
    );
  }

  Widget _buildExperienceColumn(BuildContext context) { 
    return _buildSection(
      context: context,
      title: '💼 Experience',
      icon: Icons.work_outline,
      items: [
        _buildInteractiveItem(
          context: context,
          isExpanded: _experienceExpanded[0],
          onTap: () => setState(() => _experienceExpanded[0] = !_experienceExpanded[0]),
          title: 'Frontend Developer',
          subtitle: 'Kompetisi Riset Sawit Tingkat Mahasiswa Nasional 2024',
          period: 'Juni 2023 – Oktober 2024',
          description: 'Developed web applications for oil palm farmers as part of a national competition team.',
          bulletPoints: const [
            'Worked as part of the Frontend team',
            'Collaborated with the Backend team in web app development',
          ],
        ),
        const SizedBox(height: 16),
        _buildInteractiveItem(
          context: context,
          isExpanded: _experienceExpanded[1],
          onTap: () => setState(() => _experienceExpanded[1] = !_experienceExpanded[1]),
          title: 'Multimedia Team',
          subtitle: 'PT. Kita Media Visindo',
          period: 'Juli 2022 – Agustus 2022',
          description: 'Worked in multimedia and digital publishing at a local media company.',
          bulletPoints: const [
            'Designed digital content',
            'Assisted in video production',
            'Managed social media content',
          ],
        ),
        const SizedBox(height: 16),
        _buildInteractiveItem(
          context: context,
          isExpanded: _experienceExpanded[2],
          onTap: () => setState(() => _experienceExpanded[2] = !_experienceExpanded[2]),
          title: 'IT Support Intern',
          subtitle: 'Balai Pelatihan Kesehatan (Bapelkes) Batam',
          period: 'Januari 2021 – Maret 2021',
          description: 'Provided installation and maintenance of computer hardware and networks.',
          bulletPoints: const [
            'Troubleshot hardware issues',
            'Maintained network infrastructure',
            'Provided user support and training',
          ],
        ),
      ],
    );
  }

  Widget _buildSection({
    required BuildContext context,
    required String title,
    required IconData icon,
    required List<Widget> items,
  }) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: MediaQuery.of(context).size.width - 48,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFF112240),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: const Color(0xFF1E2D4A),
            width: 1,
          ),
        ),
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                    color: HomeStyle.textPrimary,
                  ),
                ),
                const Spacer(),
                Icon(
                  icon,
                  color: HomeStyle.accentColor,
                  size: 28,
                ),
              ],
            ),
            const SizedBox(height: 16),
            ...items,
          ],
        ),
      ),
    );
  }

  Widget _buildInteractiveItem({
    required BuildContext context,
    required bool isExpanded,
    required VoidCallback onTap,
    required String title,
    required String subtitle,
    required String period,
    required String description,
    required List<String> bulletPoints,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTap: onTap,
            child: AnimatedContainer(
              duration: HomeStyle.hoverDuration,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: isExpanded 
                    ? HomeStyle.accentColor.withOpacity(0.05)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: isExpanded 
                      ? HomeStyle.accentColor.withOpacity(0.2)
                      : Colors.transparent,
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 24,
                        height: 24,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: HomeStyle.accentColor,
                            width: 2,
                          ),
                        ),
                        child: Center(
                          child: Container(
                            width: 8,
                            height: 8,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: HomeStyle.accentColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                                color: HomeStyle.textPrimary,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              subtitle,
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: HomeStyle.accentColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              period,
                              style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: HomeStyle.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                      AnimatedRotation(
                        turns: isExpanded ? 0.5 : 0,
                        duration: HomeStyle.hoverDuration,
                        child: Icon(
                          Icons.expand_more,
                          color: HomeStyle.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  if (isExpanded) ...[
                    const SizedBox(height: 12),
                    Divider(
                      height: 1,
                      color: HomeStyle.textSecondary.withOpacity(0.2),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: HomeStyle.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...bulletPoints.map((point) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 4, right: 8),
                            child: Icon(
                              Icons.circle,
                              size: 8,
                              color: HomeStyle.accentColor,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              point,
                              style: TextStyle(
                                fontSize: 14,
                                height: 1.5,
                                color: HomeStyle.textPrimary.withOpacity(0.9),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}