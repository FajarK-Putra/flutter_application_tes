import 'package:flutter/material.dart';
import '../models/project_model.dart';
import '../styles/home_style.dart';

class ProjectCard extends StatelessWidget {
  final ProjectModel project;
  final VoidCallback onView;

  const ProjectCard({
    super.key,
    required this.project,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: HomeStyle.sectionBackground.withOpacity(0.7),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          minHeight: 400, // Tinggi minimal yang konsisten
          maxHeight: 450, // Tinggi maksimal yang konsisten
          minWidth: 300,  // Lebar yang tetap
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            // Bagian gambar dengan fixed height
            Container(
              height: 180, // Tinggi gambar yang tetap
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                color: Colors.grey[900],
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                child: _buildProjectImage(),
              ),
            ),
            
            // Bagian konten
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          project.title,
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: HomeStyle.textPrimary,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          project.description,
                          style: TextStyle(
                            fontSize: 14,
                            color: HomeStyle.textSecondary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                    
                    Column(
                      children: [
                        const SizedBox(height: 12),
                        _buildTechLogos(),
                        const SizedBox(height: 12),
                        ElevatedButton(
                          onPressed: onView,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: HomeStyle.accentColor,
                            foregroundColor: Colors.black,
                            minimumSize: const Size(double.infinity, 48),
                          ),
                          child: const Text('View Details'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProjectImage() {
    try {
      if (project.imageUrl.startsWith('http')) {
        return Image.network(
          project.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
        );
      } else {
        return Image.asset(
          project.imageUrl.startsWith('/') 
              ? project.imageUrl.substring(1) // Hapus slash depan jika ada
              : project.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) => _buildPlaceholderImage(),
        );
      }
    } catch (e) {
      return _buildPlaceholderImage();
    }
  }

  Widget _buildTechLogos() {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: project.techLogos.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          try {
            return Image.asset(
              project.techLogos[index].startsWith('/')
                  ? project.techLogos[index].substring(1) // Hapus slash depan jika ada
                  : project.techLogos[index],
              width: 32,
              height: 32,
              errorBuilder: (_, __, ___) => _buildTechPlaceholder(),
            );
          } catch (e) {
            return _buildTechPlaceholder();
          }
        },
      ),
    );
  }

  Widget _buildPlaceholderImage() {
    return Center(
      child: Icon(
        Icons.image_not_supported,
        size: 50,
        color: HomeStyle.accentColor.withOpacity(0.5),
      ),
    );
  }

  Widget _buildTechPlaceholder() {
    return Container(
      width: 32,
      height: 32,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: HomeStyle.accentColor.withOpacity(0.1),
      ),
      child: Icon(
        Icons.code,
        size: 16,
        color: HomeStyle.accentColor,
      ),
    );
  }
}