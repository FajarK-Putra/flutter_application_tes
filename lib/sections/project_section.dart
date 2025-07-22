import 'package:flutter/material.dart';
import '../styles/home_style.dart';
import '../widgets/project_card.dart';
import '../models/project_model.dart';
import '../screens/project_detail_screen.dart';

class ProjectSection extends StatefulWidget {
  const ProjectSection({super.key});

  @override
  State<ProjectSection> createState() => _ProjectSectionState();
}

class _ProjectSectionState extends State<ProjectSection> 
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _controller;
  late Animation<double> _opacityAnimation;
  late Animation<Offset> _slideAnimation;
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..forward();
    
    _opacityAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0, 0.5, curve: Curves.easeOut),
      ),
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeOutQuad,
    ));

    _scrollController.addListener(_updateScrollPosition);
  }

  @override
  void dispose() {
    _controller.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _updateScrollPosition() {
    // Untuk logika tambahan jika diperlukan
  }

  void _scrollToIndex(int index) {
  final scrollOffset = index * (300 + 24); // 300 width + 24 padding
  final maxOffset = _scrollController.position.maxScrollExtent;

  _scrollController.animateTo(
    scrollOffset.clamp(0.0, maxOffset).toDouble(), // Konversi ke double
    duration: const Duration(milliseconds: 500),
    curve: Curves.easeOut,
  );
}

  @override
  Widget build(BuildContext context) {
    final List<ProjectModel> projects = [
      ProjectModel(
    imageUrl: '/assets/img/proyekcafe.png',
    title: 'Antrian Cafe',
    description:
        'Aplikasi web untuk mengelola antrian di cafe secara digital. Dibuat dengan HTML, CSS, JavaScript, dan backend Python (Flask). Pengguna dapat mengambil nomor antrian online dan melihat estimasi waktu tunggu secara real-time.',
    techLogos: [
      'assets/tech/python.png',
      'assets/tech/html5.png',
      'assets/tech/css3.png',
      'assets/tech/javascript.png',
    ],
    liveUrl: 'https://program-cafe.vercel.app/',
    githubUrl: 'https://github.com/FajarK-Putra/program-cafe',
  ),
  ProjectModel(
    imageUrl: '/assets/img/sawitkita.png',
    title: 'Web App "Sawit Kita" – eLearning & Sosial Media Petani Sawit',
    description:
        'Sawit Kita" adalah platform web terpadu yang menggabungkan eLearning dan jejaring sosial untuk petani kelapa sawit di Indonesia. Dibangun menggunakan HTML, CSS, JavaScript, Bootstrap untuk tampilan, serta Python dan Golang di sisi backend. Aplikasi ini menyediakan modul pembelajaran interaktif untuk petani, forum diskusi berbasis chatbot sebagai asisten virtual, dan platform komunitas mandiri bernama Soswit, yaitu sosial media khusus petani sawit untuk saling berbagi pengalaman, berdiskusi, dan membangun jaringan.',
    techLogos: [
      'assets/tech/python.png',
      'assets/tech/html5.png',
      'assets/tech/css3.png',
      'assets/tech/javascript.png',
      'assets/tech/bootstrap.png',
      'assets/tech/go.png',
    ],
    liveUrl: 'https://sawitkita.org/',
    githubUrl: '',
  ),
  ProjectModel(
    imageUrl: '/assets/img/manajemenaset.png',
    title: 'Sistem Manajemen Aset',
    description:
        'Desain UI/UX sistem manajemen aset berbasis web menggunakan Figma. Bertujuan untuk membantu organisasi mencatat, melacak, dan mengelola aset dengan antarmuka yang intuitif dan efisien.',
    techLogos: [
      'assets/tech/figma.png',
    ],
    liveUrl: 'https://www.figma.com/proto/YQphQ5LiFK66jODPhNY5uO/Project-RPL?node-id=214-1028&t=zNFoWikgxtsDyJA4-1&scaling=contain&content-scaling=fixed&page-id=0%3A1&starting-point-node-id=2%3A130',
    githubUrl: '',
  ),
  ProjectModel(
    imageUrl: '/assets/img/sistemdeteksi.png',
    title: 'Sistem Pendeteksi Wajah Menggunakan Python dan OpenCV',
    description:
        'Deteksi dan pengenalan wajah telah menjadi bagian penting dari berbagai aplikasi keamanan, autentikasi, dan sistem cerdas lainnya. Dalam era digital saat ini, kebutuhan terhadap sistem identifikasi yang akurat dan otomatis menjadi sangat krusial. Salah satu cara efisien untuk mengenali identitas seseorang adalah dengan teknologi pengenalan wajah.',
    techLogos: [
      'assets/tech/python.png',
    ],
    liveUrl: '',
    githubUrl: 'https://github.com/FajarK-Putra/SISTEM-PENDETEKSI-WAJAH-MENGGUNAKAN-PYTHON-DAN-OPENCV',
  ),

  ProjectModel(
    imageUrl: '/assets/img/regresi.png',
    title: 'Prediksi Harga Smartphone Menggunakan Xgboost Regressor',
    description:
        'Prediksi harga smartphone adalah proses penting dalam industri teknologi untuk membantu konsumen membuat keputusan pembelian yang lebih baik. Dengan banyaknya pilihan smartphone yang tersedia, penting untuk memiliki alat yang dapat memberikan perkiraan harga berdasarkan berbagai fitur dan spesifikasi.',
    techLogos: [
      'assets/tech/python.png',
    ],
    liveUrl: '',
    githubUrl: 'https://github.com/FajarK-Putra/PREDIKSI-HARGA-SMARTPHONE-MENGGUNAKAN-XGBOOST-REGRESSOR',
  ),
  ProjectModel(
    imageUrl: '/assets/img/klasifikasi.png',
    title: 'Klasifikasi Penyakit Jantung Menggunakan Random Forest Classifier',
    description:
        'Klasifikasi penyakit jantung adalah proses penting dalam bidang kesehatan untuk mengidentifikasi risiko penyakit jantung pada individu berdasarkan data medis. Proyek ini bertujuan untuk mengembangkan model klasifikasi yang dapat membantu dalam mendeteksi kemungkinan adanya penyakit jantung pada pasien.',
    techLogos: [
      'assets/tech/python.png',
    ],
    liveUrl: '',
    githubUrl: 'https://github.com/FajarK-Putra/KLASIFIKASI-PENYAKIT-JANTUNG-MENGGUNAKAN-RANDOM-FOREST-CLASSIFIER',
  ),
  ProjectModel(
    imageUrl: '/assets/img/clustering.png',
    title: 'Segmentasi Pelanggan Menggunakan Algoritma K-Means Clustering Pada Dataset Transaksi Retail',
    description:
        'Segmentasi pelanggan adalah proses mengelompokkan pelanggan ke dalam kelompok-kelompok yang memiliki karakteristik serupa. Tujuan dari segmentasi ini adalah untuk memahami perilaku pelanggan, preferensi, dan kebutuhan mereka, sehingga perusahaan dapat menyesuaikan strategi pemasaran dan layanan yang lebih efektif.',
    techLogos: [
      'assets/tech/python.png',
    ],
    liveUrl: '',
    githubUrl: 'https://github.com/FajarK-Putra/SEGMENTASI-PELANGGAN-MENGGUNAKAN-ALGORITMA-K-MEANS-CLUSTERING-PADA-DATASET-TRANSAKSI-RETAIL',
  ),
    ];

    final screenWidth = MediaQuery.of(context).size.width;
    final totalWidth = projects.length * (300 + 24); // 300 width + 24 padding
    final shouldCenter = projects.length < 4 && totalWidth < screenWidth;

    return SlideTransition(
      position: _slideAnimation,
      child: FadeTransition(
        opacity: _opacityAnimation,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 40, horizontal: 20),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "My Projects",
                style: HomeStyle.titleTextStyle.copyWith(
                  fontSize: 32,
                  color: HomeStyle.textPrimary,
                ),
              ),
              const SizedBox(height: 24),
              
              // Container pembungkus untuk scroll
              SizedBox(
                height: 450, // Sesuaikan dengan tinggi card
                child: Stack(
                  children: [
                    // Daftar proyek
                    NotificationListener<ScrollNotification>(
                      onNotification: (notification) {
                        if (notification is ScrollEndNotification) {
                          final page = (_scrollController.offset / (300 + 24)).round();
                          setState(() => _currentIndex = page);
                        }
                        return true;
                      },
                      child: ListView.builder(
                        controller: _scrollController,
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: shouldCenter ? (screenWidth - totalWidth) / 2 : 24,
                        ),
                        itemCount: projects.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            child: AnimatedProjectCard(
                              project: projects[index],
                              animation: _controller,
                              index: index,
                              onView: () {
                                Navigator.push(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (_, __, ___) => ProjectDetailScreen(project: projects[index]),
                                    transitionsBuilder: (_, animation, __, child) {
                                      return FadeTransition(
                                        opacity: animation,
                                        child: child,
                                      );
                                    },
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ),
                    
                    // Tombol navigasi
                    if (projects.length >= 4)
                      Align(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          icon: Icon(Icons.arrow_back_ios, color: HomeStyle.accentColor),
                          onPressed: _currentIndex > 0 
                              ? () => _scrollToIndex(_currentIndex - 1)
                              : null,
                        ),
                      ),
                    if (projects.length >= 4)
                      Align(
                        alignment: Alignment.centerRight,
                        child: IconButton(
                          icon: Icon(Icons.arrow_forward_ios, color: HomeStyle.accentColor),
                          onPressed: _currentIndex < projects.length - 1
                              ? () => _scrollToIndex(_currentIndex + 1)
                              : null,
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class AnimatedProjectCard extends StatelessWidget {
  final ProjectModel project;
  final Animation<double> animation;
  final int index;
  final VoidCallback onView;

  const AnimatedProjectCard({
    super.key,
    required this.project,
    required this.animation,
    required this.index,
    required this.onView,
  });

  @override
  Widget build(BuildContext context) {
    final cardAnimation = CurvedAnimation(
      parent: animation,
      curve: Interval(
        0.1 + (0.1 * index), 
        0.5 + (0.1 * index), 
        curve: Curves.easeOut
      ),
    );

    return AnimatedBuilder(
      animation: cardAnimation,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..translate(0.0, (1 - cardAnimation.value) * 20)
            ..scale(cardAnimation.value),
          child: Opacity(
            opacity: cardAnimation.value,
            child: child,
          ),
        );
      },
      child: SizedBox(
        width: 300,
        child: ProjectCard(
          project: project,
          onView: onView,
        ),
      ),
    );
  }
}