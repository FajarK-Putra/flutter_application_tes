import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../models/project_model.dart';
import '../styles/home_style.dart';

class ProjectDetailScreen extends StatelessWidget {
  final ProjectModel project;

  const ProjectDetailScreen({super.key, required this.project});

  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HomeStyle.sectionBackground,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          project.title,
          style: TextStyle(color: HomeStyle.textPrimary),
        ),
        iconTheme: IconThemeData(color: HomeStyle.accentColor),
      ),
      body: Container(
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
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          project.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 24),
                    Expanded(
                      flex: 1,
                      child: _buildDetails(context),
                    ),
                  ],
                );
              } else {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        project.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 24),
                    _buildDetails(context),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          project.title,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: HomeStyle.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Text(
          project.description,
          style: TextStyle(
            fontSize: 16,
            color: HomeStyle.textSecondary,
          ),
        ),
        const SizedBox(height: 24),
        Text(
          "Technology:",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: HomeStyle.accentColor,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: project.techLogos.map((tech) => Image.asset(
            tech,
            width: 36,
            height: 36,
          )).toList(),
        ),
        const SizedBox(height: 32),
        Row(
         children: [
  if (project.liveUrl.isNotEmpty)
    ElevatedButton(
      onPressed: () => _launchUrl(project.liveUrl),
      style: ElevatedButton.styleFrom(
        backgroundColor: HomeStyle.accentColor,
        foregroundColor: Colors.black,
      ),
      child: const Text("View Live"),
    ),
  if ((project.liveUrl.isNotEmpty) && (project.githubUrl.isNotEmpty))
    const SizedBox(width: 16),
  if (project.githubUrl.isNotEmpty)
    OutlinedButton(
      onPressed: () => _launchUrl(project.githubUrl),
      style: OutlinedButton.styleFrom(
        foregroundColor: HomeStyle.accentColor,
        side: BorderSide(color: HomeStyle.accentColor),
      ),
      child: const Text("GitHub Repo"),
    ),
],
        ),
      ],
    );
  }
}