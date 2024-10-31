import 'package:flutter/material.dart';

class WhatsComing extends StatelessWidget {
  const WhatsComing({super.key});

  @override
  Widget build(BuildContext context) {
    const Color primaryBeige = Color(0xFFF5F5DC);
    const Color darkBeige = Color(0xFFE5E5CC);
    const Color textDarkColor = Color(0xFF2C3E50);

    return Scaffold(
      backgroundColor: primaryBeige,
      appBar: AppBar(
        title: const Text(
          'What\'s Coming',
          style: TextStyle(
            color: Color(0xFF2C3E50),
            fontWeight: FontWeight.w600,
            fontSize: 24,
          ),
        ),
        backgroundColor: primaryBeige,
        elevation: 0,
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryBeige,
              darkBeige.withOpacity(0.5),
            ],
          ),
        ),
        child: ListView(
          padding: const EdgeInsets.all(20.0),
          children: [
            _FeatureSection(
              title: 'Express Yourself',
              textColor: textDarkColor,
              features: [
                _FeatureCard(
                  icon: Icons.language,
                  title: 'Multilingual Support',
                  description: 'Write messages in multiple languages with automatic translation support.',
                  gradientColors: const [Color(0xFF4EA8DE), Color(0xFF5E60CE)],
                ),
                _FeatureCard(
                  icon: Icons.mood,
                  title: 'Mood Tracking',
                  description: 'Attach your current mood to messages and track emotional growth over time.',
                  gradientColors: const [Color(0xFF48CAE4), Color(0xFF4EA8DE)],
                ),
              ],
            ),
            _FeatureSection(
              title: 'Capture Memories',
              textColor: textDarkColor,
              features: [
                _FeatureCard(
                  icon: Icons.photo_library,
                  title: 'Media Attachments',
                  description: 'Send photos, voice messages, and small video clips to your future self.',
                  gradientColors: const [Color(0xFFADE8F4), Color(0xFF48CAE4)],
                ),
                _FeatureCard(
                  icon: Icons.lock_clock,
                  title: 'Custom Delivery Times',
                  description: 'Set specific dates and times for message delivery with timezone support.',
                  gradientColors: const [Color(0xFF90E0EF), Color(0xFF48CAE4)],
                ),
              ],
            ),
            _FeatureSection(
              title: 'Stay Organized',
              textColor: textDarkColor,
              features: [
                _FeatureCard(
                  icon: Icons.category,
                  title: 'Message Categories',
                  description: 'Organize messages by life areas: Career, Personal Growth, Relationships, and more.',
                  gradientColors: const [Color(0xFF0096C7), Color(0xFF0077B6)],
                ),
                _FeatureCard(
                  icon: Icons.notifications_active,
                  title: 'Smart Notifications',
                  description: 'Customize notification preferences and get gentle reminders about upcoming deliveries.',
                  gradientColors: const [Color(0xFF023E8A), Color(0xFF0077B6)],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _FeatureSection extends StatelessWidget {
  const _FeatureSection({
    required this.title,
    required this.features,
    required this.textColor,
  });

  final String title;
  final List<Widget> features;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
          child: Text(
            title,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: textColor,
              letterSpacing: 0.5,
            ),
          ),
        ),
        ...features,
        const SizedBox(height: 16),
      ],
    );
  }
}

class _FeatureCard extends StatelessWidget {
  const _FeatureCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.gradientColors,
  });

  final IconData icon;
  final String title;
  final String description;
  final List<Color> gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: gradientColors,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            child: InkWell(
              onTap: () {}, // For future interaction
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            icon,
                            size: 24,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Text(
                            title,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white.withOpacity(0.9),
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}