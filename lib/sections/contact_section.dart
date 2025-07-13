import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import '/styles/home_style.dart';

class ContactSection extends StatefulWidget {
  const ContactSection({super.key});

  @override
  State<ContactSection> createState() => _ContactSectionState();
}

class _ContactSectionState extends State<ContactSection> 
    with SingleTickerProviderStateMixin {
  // [1] Controller untuk form
  late GlobalKey<FormState> _formKey;
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _messageController;

  // [2] State variables
  bool _isSubmitting = false;
  bool _isSuccess = false;
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  // [3] Link social media
  final Map<String, String> socialLinks = {
    'GitHub': 'https://github.com/FajarK-Putra',
    'LinkedIn': 'https://www.linkedin.com/in/fajar-kurnia-84791836b/',
    'Instagram': 'https://instagram.com/fjrkurniaa_',
  };

  @override
  void initState() {
    super.initState();
    // Inisialisasi controller dan form key
    _initializeControllers();
    
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

  void _initializeControllers() {
    _formKey = GlobalKey<FormState>();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _messageController = TextEditingController();
  }

  // [4] Dispose controllers
  @override
  void dispose() {
    _animationController.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  // [5] Form submission logic
  // email fjrkurnia1112@gmail.com
  //service_yxeoms9
  //template_mi9umfv
Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isSubmitting = true);

    try {
      const serviceId = 'service_hgrn8jr';
      const templateId = 'template_5h3ix68';
      const publicKey = 'RpZGI6Eu0czX7Mci8';

      final response = await http.post(
        Uri.parse('https://api.emailjs.com/api/v1.0/email/send'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'service_id': serviceId,
          'template_id': templateId,
          'user_id': publicKey,
          'template_params': {
            'user_name': _nameController.text.trim(),
            'user_email': _emailController.text.trim(),
            'user_message': _messageController.text.trim(),
          }
        }),
      );

      if (response.statusCode == 200) {
        _resetForm(); // Reset form sebelum menampilkan pesan sukses
        
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('✅ Email berhasil dikirim!')),
        );
      } else {
        throw 'Gagal mengirim email: ${response.statusCode}';
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('❌ Error: $e')),
      );
    } finally {
      if (mounted) {
        setState(() => _isSubmitting = false);
      }
    }
  }

  void _resetForm() {
    // Method 3: Jika masih bermasalah, gunakan nuclear option (hapus komentar):
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          _nameController.dispose();
          _emailController.dispose();
          _messageController.dispose();
          
          _nameController = TextEditingController();
          _emailController = TextEditingController();
          _messageController = TextEditingController();
          
          _formKey = GlobalKey<FormState>();
        });
      }
    });
    

    setState(() => _isSuccess = true);
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() => _isSuccess = false);
      }
    });
  }

  // [6] Launch social media URLs
  Future<void> _launchSocial(String url) async {
    try {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(
          Uri.parse(url),
          mode: LaunchMode.externalApplication,
        );
      } else {
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch URL')),
        );
      }
    } catch (e) {
      // ignore: use_build_context_synchronously
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isMobile = MediaQuery.of(context).size.width < 768;
    // [7] Atur tinggi container disini (ubah angka 500 sesuai kebutuhan)
    final double cardHeight = isMobile ? 450 : 470; // Sama untuk mobile dan desktop

    return FadeTransition(
      opacity: _opacityAnimation,
      child: Container(
        width: double.infinity,
        padding: isMobile 
            ? const EdgeInsets.symmetric(vertical: 40, horizontal: 16)
            : EdgeInsets.symmetric(
                vertical: 80, 
                horizontal: MediaQuery.of(context).size.width * 0.1,
              ),
        color: HomeStyle.sectionBackground,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Contact Me',
              style: TextStyle(
                fontSize: isMobile ? 28 : 36,
                fontWeight: FontWeight.w800,
                color: HomeStyle.textPrimary,
                letterSpacing: -0.5,
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: isMobile ? 16 : 0,
              ),
              child: Text(
                'Feel free to get in touch with me for any questions or opportunities',
                style: TextStyle(
                  fontSize: isMobile ? 16 : 18,
                  fontWeight: FontWeight.w400,
                  color: HomeStyle.textSecondary,
                  height: 1.6,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 32),
            isMobile ? _buildMobileLayout(context, cardHeight) : _buildDesktopLayout(context, cardHeight),
          ],
        ),
      ),
    );
  }

  // [8] Layout untuk desktop
  Widget _buildDesktopLayout(BuildContext context, double cardHeight) {
    return SizedBox(
      height: cardHeight, // Gunakan tinggi yang sudah ditentukan
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: _buildContactForm(context, false, cardHeight),
          ),
          const SizedBox(width: 48),
          Expanded(
            child: _buildContactInfo(context, false, cardHeight),
          ),
        ],
      ),
    );
  }

  // [9] Layout untuk mobile
  Widget _buildMobileLayout(BuildContext context, double cardHeight) {
    return Column(
      children: [
        SizedBox(
          height: cardHeight, // Gunakan tinggi yang sama
          child: _buildContactForm(context, true, cardHeight),
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: cardHeight, // Gunakan tinggi yang sama
          child: _buildContactInfo(context, true, cardHeight),
        ),
      ],
    );
  }

  // [10] Form kontak
  Widget _buildContactForm(BuildContext context, bool isMobile, double height) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height, // Tetap gunakan tinggi yang ditentukan
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: HomeStyle.accentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF1E2D4A),
          width: 1,
        ),
      ),
      padding: isMobile 
          ? const EdgeInsets.all(20)
          : const EdgeInsets.all(32),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Send a Message',
              style: TextStyle(
                fontSize: isMobile ? 20 : 24,
                fontWeight: FontWeight.w700,
                color: HomeStyle.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            
            // [11] Input field untuk nama
            TextFormField(
              controller: _nameController,
              decoration: _inputDecoration(context, 'Your Name', 'Please enter your name'),
              style: const TextStyle(color: Colors.white),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your name'; // Pesan error
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // [12] Input field untuk email
            TextFormField(
              controller: _emailController,
              decoration: _inputDecoration(context, 'Email Address', 'Please enter a valid email'),
              style: const TextStyle(color: Colors.white),
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your email'; // Pesan error
                }
                if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
                  return 'Please enter a valid email'; // Pesan error
                }
                return null;
              },
            ),
            const SizedBox(height: 16),

            // [13] Input field untuk pesan
            Expanded(
              child: TextFormField(
                controller: _messageController,
                decoration: _inputDecoration(context, 'Your Message', 'Message should be at least 10 characters')
                  .copyWith(  // Tambahkan ini
                    alignLabelWithHint: true,
                    floatingLabelBehavior: FloatingLabelBehavior.always,
                  ),
                style: const TextStyle(color: Colors.white),
                maxLines: null,
                expands: true,
                textAlignVertical: TextAlignVertical.top,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your message';
                  }
                  if (value.length < 10) {
                    return 'Message should be at least 10 characters';
                  }
                  return null;
                },
              ),
            ),
            
            // [14] Tombol submit
            SizedBox(
              height: 50,
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 300),
                child: _isSuccess
                    ? _SuccessMessage(context: context)
                    : SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _submitForm, // Langsung panggil _submitForm
                          style: _buttonStyle(context),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 3,
                                    color: Colors.white,
                                  ),
                                )
                              : const Text('Send Message'),
                        ),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }

// [15] Dekorasi input field (modifikasi)
InputDecoration _inputDecoration(BuildContext context, String label, String hint) {
  return InputDecoration(
    labelText: label,
    alignLabelWithHint: true,  // Ini yang membuat label tetap di atas
    floatingLabelBehavior: FloatingLabelBehavior.always,  // Label selalu muncul di atas
    labelStyle: TextStyle(
      color: HomeStyle.textSecondary,
    ),
    errorStyle: TextStyle(
      color: Colors.orange[300],
      height: 1,
    ),
    hintText: hint,
    hintStyle: TextStyle(
      color: HomeStyle.textSecondary.withOpacity(0.6),
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color:  Color(0xFF1E2D4A)),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color:  Color(0xFF1E2D4A)),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        color: HomeStyle.accentColor,
        width: 2,
      ),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.orange[300]!),
    ),
    focusedErrorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: Colors.orange[300]!, width: 2),
    ),
    filled: true,
    fillColor: const Color(0xFF0A192F),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  );
}

  // [16] Informasi kontak
  Widget _buildContactInfo(BuildContext context, bool isMobile, double height) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      height: height, // Gunakan tinggi yang sama dengan form
      decoration: BoxDecoration(
        color: const Color(0xFF112240),
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: HomeStyle.accentColor.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
        border: Border.all(
          color: const Color(0xFF1E2D4A),
          width: 1,
        ),
      ),
      padding: isMobile 
          ? const EdgeInsets.all(20)
          : const EdgeInsets.all(32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Contact Information',
            style: TextStyle(
              fontSize: isMobile ? 20 : 24,
              fontWeight: FontWeight.w700,
              color: HomeStyle.textPrimary,
            ),
          ),
          const SizedBox(height: 16),
          
          _buildContactItem(
            context: context,
            icon: FontAwesomeIcons.envelope,
            title: 'Email',
            value: 'fjrkurnia1112@gmail.com',
            onTap: () => _launchSocial('mailto:fjrkurnia1112@gmail.com'),
            isMobile: isMobile,
          ),
          const SizedBox(height: 12),
          
          _buildContactItem(
            context: context,
            icon: FontAwesomeIcons.whatsapp,
            title: 'WhatsApp',
            value: '+62 823-9119-6711',
            onTap: () => _launchSocial('https://wa.me/6282391196711'),
            isMobile: isMobile,
          ),
          const SizedBox(height: 12),
          
          _buildContactItem(
            context: context,
            icon: Icons.location_on_outlined,
            title: 'Location',
            value: 'Batam, Kepulauan Riau, Indonesia',
            onTap: () => _launchSocial('https://maps.google.com/?q=Batam'),
            isMobile: isMobile,
          ),
          const SizedBox(height: 16),
          
          Text(
            'Social Media',
            style: TextStyle(
              fontSize: isMobile ? 13 : 14,
              fontWeight: FontWeight.w500,
              color: HomeStyle.textSecondary,
            ),
          ),
          const SizedBox(height: 8),
          
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _buildSocialIcon(
                context: context,
                icon: FontAwesomeIcons.github,
                platform: 'GitHub',
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                context: context,
                icon: FontAwesomeIcons.linkedin,
                platform: 'LinkedIn',
                isMobile: isMobile,
              ),
              _buildSocialIcon(
                context: context,
                icon: FontAwesomeIcons.instagram,
                platform: 'Instagram',
                isMobile: isMobile,
              ),
            ],
          ),
        ],
      ),
    );
  }

  // [17] Item kontak
  Widget _buildContactItem({
    required BuildContext context,
    required IconData icon,
    required String title,
    required String value,
    required VoidCallback onTap,
    required bool isMobile,
  }) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: EdgeInsets.all(isMobile ? 12 : 16),
          decoration: BoxDecoration(
            color: HomeStyle.accentColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(
                icon,
                size: isMobile ? 20 : 24,
                color: HomeStyle.accentColor,
              ),
              SizedBox(width: isMobile ? 12 : 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: isMobile ? 13 : 14,
                        fontWeight: FontWeight.w500,
                        color: HomeStyle.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      value,
                      style: TextStyle(
                        fontSize: isMobile ? 14 : 16,
                        color: Colors.white,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  // [18] Icon social media
  Widget _buildSocialIcon({
    required BuildContext context,
    required IconData icon,
    required String platform,
    required bool isMobile,
  }) {
    return Tooltip(
      message: platform,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () => _launchSocial(socialLinks[platform]!),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: EdgeInsets.all(isMobile ? 10 : 12),
            decoration: BoxDecoration(
              color: HomeStyle.accentColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: isMobile ? 20 : 24,
              color: HomeStyle.accentColor,
            ),
          ),
        ),
      ),
    );
  }

  // [19] Style tombol
  ButtonStyle _buttonStyle(BuildContext context) {
    return ButtonStyle(
      backgroundColor: MaterialStateProperty.resolveWith<Color>((states) {
        if (states.contains(MaterialState.disabled)) {
          return HomeStyle.accentColor.withOpacity(0.5);
        }
        if (states.contains(MaterialState.pressed)) {
          return HomeStyle.accentColor.withOpacity(0.8);
        }
        return HomeStyle.accentColor;
      }),
      foregroundColor: MaterialStateProperty.all(Colors.black),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 32, vertical: 18),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      elevation: MaterialStateProperty.resolveWith<double>((states) {
        if (states.contains(MaterialState.hovered)) return 4;
        return 2;
      }),
      textStyle: MaterialStateProperty.all(
        const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}

// [20] Pesan sukses
class _SuccessMessage extends StatelessWidget {
  final BuildContext context;

  const _SuccessMessage({required this.context});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.green[100]!),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: Colors.green[800],
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              'Message sent successfully! Please check your email client to complete sending.',
              style: TextStyle(
                color: Colors.green[800],
              ),
            ),
          ),
        ],
      ),
    );
  }
}