import 'package:flutter/material.dart';
import '../styles/home_style.dart';
import '../styles/topbar_style.dart';

class CustomTopbar extends StatefulWidget {
  final Map<String, GlobalKey> sectionKeys;
  
  const CustomTopbar({
    super.key,
    required this.sectionKeys,
  });

  @override
  State<CustomTopbar> createState() => _CustomTopbarState();
}

class _CustomTopbarState extends State<CustomTopbar> {
  bool _menuOpen = false;
  int? _hoveredIndex;
  bool _logoHovered = false;

  final List<String> _menuItems = [
    'Home',
    'About Me',
    'Projects',
    'Skills & Certification',
    'Education & Experience',
    'Contact',
  ];

  void _toggleMenu() {
    setState(() {
      _menuOpen = !_menuOpen;
    });
  }

  Widget _buildDesktopMenuItem(String text, int index) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hoveredIndex = index),
      onExit: (_) => setState(() => _hoveredIndex = null),
      child: AnimatedContainer(
        duration: TopbarStyle.hoverDuration,
        curve: TopbarStyle.hoverCurve,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _hoveredIndex == index 
              ? HomeStyle.accentColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: InkWell(
          onTap: () => _navigateTo(text),
          borderRadius: BorderRadius.circular(8),
          hoverColor: Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Text(
              text,
              style: TopbarStyle.menuItemStyle(context, _hoveredIndex == index),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMobileMenuItem(String text) {
    return InkWell(
      onTap: () => _navigateTo(text),
      borderRadius: BorderRadius.circular(8),
      child: AnimatedContainer(
        duration: TopbarStyle.hoverDuration,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: _hoveredIndex == _menuItems.indexOf(text)
              ? HomeStyle.accentColor.withOpacity(0.1)
              : Colors.transparent,
        ),
        child: Text(
          text,
          style: TopbarStyle.menuItemStyle(
            context, 
            _hoveredIndex == _menuItems.indexOf(text),
          ),
        ),
      ),
    );
  }

  void _navigateTo(String text) {
    final key = widget.sectionKeys[text];
    if (key != null && key.currentContext != null) {
      Scrollable.ensureVisible(
        key.currentContext!,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeInOut,
        alignment: 0.1, // Slightly below top to account for app bar
      );
    }
    
    if (_menuOpen) _toggleMenu();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth >= 1024;

    return SafeArea(
      bottom: false,
      child: Material(
        elevation: 0,
        color: Colors.transparent,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 500),
          padding: TopbarStyle.containerPadding(context),
          decoration: BoxDecoration(
            color: HomeStyle.sectionBackground.withOpacity(0.9),
            boxShadow: [
              BoxShadow(
                color: HomeStyle.accentColor.withOpacity(0.05),
                blurRadius: 20,
                spreadRadius: 2,
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  MouseRegion(
                    onEnter: (_) => setState(() => _logoHovered = true),
                    onExit: (_) => setState(() => _logoHovered = false),
                    child: GestureDetector(
                      onTap: () => _navigateTo('Home'),
                      child: AnimatedContainer(
                        duration: TopbarStyle.hoverDuration,
                        padding: const EdgeInsets.all(8),
                        transform: Matrix4.identity()
                          ..scale(_logoHovered ? 1.05 : 1.0),
                        child: Text(
                          "FK",
                          style: TopbarStyle.logoTextStyle.copyWith(
                            color: _logoHovered 
                                ? HomeStyle.accentColor 
                                : Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  
                  if (!isDesktop)
                    IconButton(
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 300),
                        child: _menuOpen
                            ? Icon(
                                Icons.close,
                                key: const ValueKey('close'),
                                color: HomeStyle.accentColor,
                              )
                            : const Icon(
                                Icons.menu,
                                key: ValueKey('menu'),
                                color: Colors.white,
                              ),
                        transitionBuilder: (child, animation) {
                          return RotationTransition(
                            turns: Tween<double>(
                              begin: _menuOpen ? 0.5 : 0,
                              end: 1,
                            ).animate(animation),
                            child: FadeTransition(
                              opacity: animation,
                              child: child,
                            ),
                          );
                        },
                      ),
                      onPressed: _toggleMenu,
                    )
                  else
                    Row(
                      children: _menuItems
                          .asMap()
                          .entries
                          .map((e) => _buildDesktopMenuItem(e.value, e.key))
                          .toList(),
                    ),
                ],
              ),
              
              if (!isDesktop && _menuOpen)
                AnimatedSize(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  child: Material(
                    color: Colors.transparent,
                    child: Column(
                      children: _menuItems
                          .map(_buildMobileMenuItem)
                          .toList(),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}