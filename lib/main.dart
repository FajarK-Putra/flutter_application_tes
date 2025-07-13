import 'package:flutter/material.dart';
import 'package:flutter_application_tes/sections/aboutme_section.dart';
import 'package:flutter_application_tes/sections/contact_section.dart';
import 'package:flutter_application_tes/sections/education_experience_section.dart';
import 'package:flutter_application_tes/sections/home_section.dart';
import 'package:flutter_application_tes/sections/project_section.dart';
import 'package:flutter_application_tes/sections/skills_certification_section.dart';
import 'sections/custom_topbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'My Portofolio',
      home: MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  final GlobalKey homeKey = GlobalKey();
  final GlobalKey aboutKey = GlobalKey();
  final GlobalKey projectsKey = GlobalKey();
  final GlobalKey skillsKey = GlobalKey();
  final GlobalKey educationKey = GlobalKey();
  final GlobalKey contactKey = GlobalKey();

  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    const baseTopbarHeight = 40.0;

    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.only(top: baseTopbarHeight + statusBarHeight),
            child: SingleChildScrollView(
              controller: _scrollController,
              child: Column(
                children: [
                  HomeSection(
                    key: homeKey,
                    scrollToProjects: () => _scrollToSection(projectsKey),
                  ),
                  AboutMeSection(key: aboutKey),
                  ProjectSection(key: projectsKey),
                  SkillsCertificationSection(key: skillsKey),
                  EducationExperienceSection(key: educationKey),
                  ContactSection(key: contactKey),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CustomTopbar(
              sectionKeys: {
                'Home': homeKey,
                'About Me': aboutKey,
                'Projects': projectsKey,
                'Skills & Certification': skillsKey,
                'Education & Experience': educationKey,
                'Contact': contactKey,
              },
            ),
          ),
        ],
      ),
    );
  }
}