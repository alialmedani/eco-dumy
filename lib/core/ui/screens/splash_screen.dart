import 'package:eco_dumy/core/constant/app_colors/app_colors.dart';
import 'package:eco_dumy/featuers/auth/new/screen/login_screen.dart';
import 'package:eco_dumy/featuers/home/screen/tad/ss.dart';
import 'package:eco_dumy/featuers/login/ui/login_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'dart:ui';

import '../../classes/cashe_helper.dart';
import '../../classes/notification.dart';
import '../../utils/Navigation/navigation.dart';

class SplashSscreen1 extends StatefulWidget {
  const SplashSscreen1({super.key});

  @override
  State<SplashSscreen1> createState() => _SplashSscreen1State();
}

class _SplashSscreen1State extends State<SplashSscreen1>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _slideController;
  late AnimationController _scaleController;
  late AnimationController _timerController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _timerAnimation;

  int _countdown = 3;

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
    _checkUserAuthentication();
  }

  void _checkUserAuthentication() async {
    _startAnimations();

    // انتظر 3 ثواني (الأنيميشن/العداد)
    await Future.delayed(const Duration(seconds: 3));

    if (!mounted) return;

    final hasToken = (CacheHelper.token?.isNotEmpty ?? false);

    if (hasToken) {
      _navigateToHome();
    } else {
      _navigateToLogin();
    }
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => HomeScreenA(), // أو RootScreen إذا عندك
        transitionsBuilder: (_, animation, __, child) =>
            FadeTransition(opacity: animation, child: child),
      ),
    );
  }

  void _initializeAnimations() {
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _slideController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    );
    _timerController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.5), end: Offset.zero).animate(
          CurvedAnimation(parent: _slideController, curve: Curves.easeOutCubic),
        );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _timerAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _timerController, curve: Curves.linear));
  }

  void _startAnimations() {
    Future.delayed(const Duration(milliseconds: 300), () {
      _fadeController.forward();
    });
    Future.delayed(const Duration(milliseconds: 600), () {
      _slideController.forward();
    });
    Future.delayed(const Duration(milliseconds: 900), () {
      _scaleController.forward();
    });

    // Start timer after animations complete
    Future.delayed(const Duration(milliseconds: 1500), () {
      _startTimer();
    });
  }

  void _startTimer() {
    _timerController.forward();

    // Update countdown every second for 3 seconds
    for (int i = 1; i <= 3; i++) {
      Future.delayed(Duration(seconds: i), () {
        if (mounted) {
          setState(() {
            _countdown = 3 - i;
          });
        }
      });
    }
  }

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      PageRouteBuilder(
        pageBuilder: (_, a, __) => const LoginScreen(),
        transitionsBuilder: (_, animation, __, child) => FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(1, 0),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _slideController.dispose();
    _scaleController.dispose();
    _timerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        height: size.height,
        width: size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.black87,
              Colors.black.withValues(alpha: 0.7),
              AppColors.xprimaryColor.withValues(alpha: 0.2),
            ],
          ),
        ),
        child: Stack(
          children: [
            // Background Image with Parallax Effect
            Positioned.fill(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: ShaderMask(
                  shaderCallback: (rect) {
                    return LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.8),
                      ],
                    ).createShader(
                      Rect.fromLTRB(0, 0, rect.width, rect.height),
                    );
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    "assets/images/bg.png",
                    height: size.height,
                    width: size.width,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),

            // Floating Coffee Bean Decoration
            Positioned(
              top: size.height * 0.15,
              right: size.width * 0.1,
              child: AnimatedBuilder(
                animation: _scaleAnimation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _scaleAnimation.value * 0.6,
                    child: Opacity(
                      opacity: 0.3,
                      child: Image.asset(
                        "assets/images/bean.png",
                        width: 60,
                        height: 60,
                      ),
                    ),
                  );
                },
              ),
            ),

            // Main Content
            Positioned(
              bottom: 0,
              right: 0,
              left: 0,
              child: SlideTransition(
                position: _slideAnimation,
                child: Container(
                  height: size.height * 0.55,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.transparent,
                        Colors.black.withValues(alpha: 0.3),
                        Colors.black.withValues(alpha: 0.8),
                        Colors.black,
                      ],
                    ),
                  ),
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                            colors: [
                              Colors.white.withValues(alpha: 0.1),
                              Colors.white.withValues(alpha: 0.05),
                            ],
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 20,
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Logo/Brand Icon
                              ScaleTransition(
                                scale: _scaleAnimation,
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    gradient: RadialGradient(
                                      colors: [
                                        AppColors.xprimaryColor.withValues(
                                          alpha: 0.3,
                                        ),
                                        AppColors.xprimaryColor.withValues(
                                          alpha: 0.1,
                                        ),
                                      ],
                                    ),
                                    border: Border.all(
                                      color: AppColors.xprimaryColor.withValues(
                                        alpha: 0.5,
                                      ),
                                      width: 2,
                                    ),
                                  ),
                                  child: Image.asset(
                                    "assets/images/logo.png",
                                    width: 60,
                                    height: 60,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 20),

                              // Main Heading
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: ShaderMask(
                                  shaderCallback: (bounds) => LinearGradient(
                                    colors: [
                                      Colors.white,
                                      Colors.white.withValues(alpha: 0.9),
                                      AppColors.xprimaryColor.withValues(
                                        alpha: 0.8,
                                      ),
                                    ],
                                  ).createShader(bounds),
                                  child: const Text(
                                    "Fall in Love with\nCoffee in Blissful\nDelight!",
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 28,
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      height: 1.1,
                                      letterSpacing: -0.5,
                                    ),
                                  ),
                                ),
                              ),

                              const SizedBox(height: 12),

                              // Subtitle
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: Text(
                                  "Welcome to our cozy coffee corner, where every cup is a delightful experience crafted just for you.",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w400,
                                    height: 1.5,
                                    letterSpacing: 0.2,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 32),

                              // Timer Countdown Display
                              ScaleTransition(
                                scale: _scaleAnimation,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    // Circular Progress Indicator
                                    SizedBox(
                                      width: 80,
                                      height: 80,
                                      child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          // Background Circle
                                          Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                color: Colors.white.withValues(
                                                  alpha: 0.2,
                                                ),
                                                width: 3,
                                              ),
                                            ),
                                          ),
                                          // Progress Circle
                                          AnimatedBuilder(
                                            animation: _timerAnimation,
                                            builder: (context, child) {
                                              return CircularProgressIndicator(
                                                value: _timerAnimation.value,
                                                strokeWidth: 4,
                                                valueColor:
                                                    AlwaysStoppedAnimation<
                                                      Color
                                                    >(AppColors.xprimaryColor),
                                                backgroundColor:
                                                    Colors.transparent,
                                              );
                                            },
                                          ),
                                          // Countdown Number
                                          AnimatedSwitcher(
                                            duration: const Duration(
                                              milliseconds: 300,
                                            ),
                                            child: Text(
                                              '$_countdown',
                                              key: ValueKey(_countdown),
                                              style: TextStyle(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w700,
                                                color: AppColors.xprimaryColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    const SizedBox(height: 16),

                                    // Starting message
                                    FadeTransition(
                                      opacity: _fadeAnimation,
                                      child: Text(
                                        "Starting in $_countdown seconds...",
                                        style: TextStyle(
                                          color: Colors.white.withValues(
                                            alpha: 0.8,
                                          ),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              const SizedBox(height: 24),

                              // Tap to skip option
                              FadeTransition(
                                opacity: _fadeAnimation,
                                child: GestureDetector(
                                  onTap: _navigateToLogin,
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20,
                                      vertical: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                        color: Colors.white.withValues(
                                          alpha: 0.3,
                                        ),
                                        width: 1,
                                      ),
                                    ),
                                    child: Text(
                                      "Tap to skip",
                                      style: TextStyle(
                                        color: Colors.white.withValues(
                                          alpha: 0.7,
                                        ),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
