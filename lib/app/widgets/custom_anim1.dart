import 'dart:developer';

import 'package:assignment1/app/app.dart';
import 'package:flutter/material.dart';
// import 'package:visibility_detector/visibility_detector.dart';

class CustomAnim1Widget extends StatefulWidget {
  const CustomAnim1Widget({
    super.key,
    required this.childMainAxisAlignment,
    required this.children,
    required this.fadeInChildren,
    this.backgroundColor,
    this.padding,
    required this.visibilityKey,
  });

  final MainAxisAlignment childMainAxisAlignment;
  final List<Widget> children;
  final List<Widget> fadeInChildren;
  final Color? backgroundColor;
  final EdgeInsetsGeometry? padding;
  final String visibilityKey;

  @override
  State<CustomAnim1Widget> createState() => _CustomAnim1WidgetState();
}

class _CustomAnim1WidgetState extends State<CustomAnim1Widget>
    with TickerProviderStateMixin {
  late AnimationController _sizeController;
  late AnimationController _fadeController;
  late Animation<double> _sizeAnimation;
  late Animation<double> _fadeAnimation;
  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();

    // Initialize the size controller for SizeTransition
    _sizeController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    // Define the animation to grow the container
    _sizeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(CurvedAnimation(
      parent: _sizeController,
      curve: Curves.easeInOut,
    ));

    // Initialize the fade controller for FadeTransition
    _fadeController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    // Define the fade animation
    _fadeAnimation =
        Tween<double>(begin: 0.0, end: 1.0).animate(_fadeController);

    // Start fade animation after size animation completes
    _sizeController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _fadeController.forward();
      }
    });
    _sizeController.forward();
    // Start the size animation
    Future.delayed(const Duration(seconds: 5), () {});
  }

  @override
  void dispose() {
    _sizeController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _sizeAnimation,
      axisAlignment: MediaQuery.of(context).size.width * 0.5,
      axis: Axis.horizontal,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: widget.backgroundColor ?? Colors.grey.withOpacity(0.4)),
        child: Row(
          mainAxisAlignment: widget.childMainAxisAlignment,
          children: [
            const Text(''),
            Expanded(
              child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Row(
                    children: widget.fadeInChildren,
                  )),
            ),
            ...widget.children
          ],
        ),
      ),
    );
  }
}
