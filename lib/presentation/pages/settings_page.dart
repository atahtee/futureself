import 'package:flutter/material.dart';
import 'package:futureme/auth/auth_service.dart';
import 'package:google_fonts/google_fonts.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  void logout() {
    final auth = AuthService();

    auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3E9E3),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Settings",
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFFE57373),
                  ),
                ),
                const SizedBox(height: 24),
                _buildSection(
                  "App Settings",
                  [
                    _buildSettingItem(
                        Icons.notifications, "Notifications", true),
                    _buildSettingItem(Icons.palette, "Appearance", false),
                    _buildSettingItem(Icons.language, "Language", false),
                    _buildSettingItem(Icons.vibration, "Haptics", true),
                    _buildSettingItem(
                        Icons.calendar_today, "Week Start On", false),
                  ],
                ),
                const SizedBox(height: 24),
                _buildSection(
                  "More",
                  [
                    _buildActionItem(Icons.feedback, "Send Feedback", () {}),
                    _buildActionItem(Icons.star, "Rate on Play Store", () {}),
                    _buildActionItem(Icons.share, "Share with Friends", () {}),
                  ],
                ),
                const SizedBox(
                  height: 24,
                ),
                _buildSection("Reviews", [
                  _buildReviewItem(Icons.info_outline, "App version"),
                  _buildReviewItem(Icons.article, "Terms of Service"),
                  _buildReviewItem(Icons.gavel, "Privacy Policy"),
                ]),
                const SizedBox(
                  height: 24,
                ),
                _buildSection(
                    "Auth", [_buildActionItem(Icons.logout, "Logout", logout)])
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children, ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: const Color(0xFFE57373),
          ),
        ),
        const SizedBox(height: 12),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem(IconData icon, String title, bool isSwitch) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE57373)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      trailing: isSwitch
          ? Switch(
              value: true,
              onChanged: (value) {},
              activeColor: const Color(0xFFE57373),
            )
          : const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
    );
  }

  Widget _buildActionItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE57373)),
      title: Text(
        title,
        style: GoogleFonts.poppins(
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
      onTap: onTap,
    );
  }

  Widget _buildReviewItem(IconData icon, String title) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE57373)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
    );
  }
}
