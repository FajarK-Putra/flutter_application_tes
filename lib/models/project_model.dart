class ProjectModel {
  final String imageUrl;
  final String title;
  final String description;
  final List<String> techLogos;
  final String liveUrl;
  final String githubUrl;

  ProjectModel({
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.techLogos,
    required this.liveUrl,
    required this.githubUrl,
  });

  // Tambahkan factory constructor untuk penanganan null
  factory ProjectModel.fallback() {
    return ProjectModel(
      imageUrl: 'assets/img/placeholder.png',
      title: 'Project Title',
      description: 'Project description',
      techLogos: ['assets/tech/placeholder.png'],
      liveUrl: '',
      githubUrl: '',
    );
  }
}