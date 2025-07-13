import 'package:flutter/material.dart';

class TypingAnimation extends StatefulWidget {
  final String text;
  final TextStyle style;
  final Duration typingDuration;
  final Duration deletingDuration;
  final Duration pauseDuration;
  final Curve curve;

  const TypingAnimation({
    super.key,
    required this.text,
    required this.style,
    this.typingDuration = const Duration(milliseconds: 800),
    this.deletingDuration = const Duration(milliseconds: 400),
    this.pauseDuration = const Duration(milliseconds: 1000),
    this.curve = Curves.easeOut,
  });

  @override
  State<TypingAnimation> createState() => _TypingAnimationState();
}

class _TypingAnimationState extends State<TypingAnimation> 
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late String _currentText = '';
  bool _isDeleting = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
    )..addListener(_updateText);
    
    _startTyping();
  }

  void _startTyping() {
    _isDeleting = false;
    _controller.duration = widget.typingDuration;
    _controller.forward(from: 0);
  }

  void _startDeleting() {
    _isDeleting = true;
    _controller.duration = widget.deletingDuration;
    _controller.forward(from: 0);
  }

  void _updateText() {
    final double progress = _controller.value;
    final int length = widget.text.length;
    final int currentLength = _isDeleting
        ? length - (progress * length).round()
        : (progress * length).round();

    setState(() {
      _currentText = widget.text.substring(0, currentLength);
    });

    if (_controller.isCompleted) {
      if (_isDeleting) {
        Future.delayed(widget.pauseDuration, () {
          if (mounted) {
            _startTyping();
          }
        });
      } else {
        Future.delayed(widget.pauseDuration, () {
          if (mounted) {
            _startDeleting();
          }
        });
      }
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_updateText);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      _currentText,
      style: widget.style,
    );
  }
}