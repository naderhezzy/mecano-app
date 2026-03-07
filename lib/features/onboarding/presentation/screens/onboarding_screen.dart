import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:mecano_app/theme/app_spacing.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _pageController = PageController();
  int _currentPage = 0;

  static const _totalPages = 3;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNext() {
    if (_currentPage < _totalPages - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go('/auth/login');
    }
  }

  void _onSkip() {
    context.go('/auth/login');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  _OnboardingPage(
                    icon: Icons.build_circle,
                    title: 'Welcome to Mecano',
                    description:
                        'Your personal virtual mechanic. Keep your car '
                        'in top shape with smart maintenance tracking and '
                        'trusted garage connections.',
                  ),
                  _OnboardingPage(
                    icon: Icons.directions_car,
                    title: 'Track Your Vehicles',
                    description:
                        'Add your cars, log maintenance history, and get '
                        'timely reminders so you never miss an oil change '
                        'or service appointment.',
                  ),
                  _OnboardingPage(
                    icon: Icons.store,
                    title: 'Find Trusted Garages',
                    description:
                        'Browse verified garages near you, read reviews, '
                        'compare prices, and book appointments in just '
                        'a few taps.',
                  ),
                ],
              ),
            ),
            Padding(
              padding: AppSpacing.paddingLg,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: _onSkip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: theme.colorScheme.onSurfaceVariant,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: _totalPages,
                    effect: WormEffect(
                      dotHeight: 10,
                      dotWidth: 10,
                      spacing: AppSpacing.sm,
                      activeDotColor: theme.colorScheme.primary,
                      dotColor: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  FilledButton(
                    onPressed: _onNext,
                    child: Text(
                      _currentPage == _totalPages - 1
                          ? 'Get Started'
                          : 'Next',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardingPage extends StatelessWidget {
  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.description,
  });

  final IconData icon;
  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: AppSpacing.paddingHorizontalLg,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            size: 120,
            color: theme.colorScheme.primary,
          ),
          AppSpacing.verticalXl,
          Text(
            title,
            style: theme.textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.onSurface,
            ),
            textAlign: TextAlign.center,
          ),
          AppSpacing.verticalMd,
          Text(
            description,
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
