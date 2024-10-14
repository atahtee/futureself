import 'package:flutter/material.dart';
import 'package:futureme/presentation/pages/main_screen.dart';
import 'package:futureme/services/user_deletion_service.dart';

class AccountPage extends StatefulWidget {
  final String firstName;
  final String email;

  const AccountPage({super.key, required this.email, required this.firstName});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  final UserDeletionService _deletionService = UserDeletionService();
  final Color primaryColor = const Color(0xFFF3E9E3);
  final Color accentColor = const Color(0xFF8B7B6E);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        backgroundColor: primaryColor,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black87),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              primaryColor,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              _buildProfileCard(),
              const SizedBox(height: 24),
              _buildSectionTitle('Account Actions'),
              _buildActionButton(
                icon: Icons.mail_outline,
                label: 'Send a message to Future Self',
                onPressed: () {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => MainScreen()));
                },
              ),
              _buildActionButton(
                icon: Icons.delete_outline,
                label: 'Delete My Data',
                onPressed: () => _deleteUserData(context),
              ),
              _buildActionButton(
                icon: Icons.person_off_outlined,
                label: 'Delete My Account',
                onPressed: () => _deleteAccount(context),
                isDestructive: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfileCard() {
    return Card(
      elevation: 8,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 60,
              backgroundColor: accentColor.withOpacity(0.2),
              child: Text(
                widget.firstName[0].toUpperCase(),
                style: TextStyle(fontSize: 48, color: accentColor),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.firstName,
              style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: accentColor),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
    bool isDestructive = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: isDestructive ? Colors.red : accentColor,
          backgroundColor: isDestructive ? Colors.red[50] : Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
            side: BorderSide(
              color: isDestructive ? Colors.red : accentColor.withOpacity(0.5),
              width: 1,
            ),
          ),
          elevation: 2,
          shadowColor: Colors.black.withOpacity(0.1),
        ),
        child: Row(
          children: [
            Icon(icon, size: 28),
            const SizedBox(width: 16),
            Text(label, style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }

  Future<void> _deleteUserData(BuildContext context) async {
    await _deletionService.deleteUserData(context);
  }

  Future<void> _deleteAccount(BuildContext context) async {
    await _deletionService.deleteAccount(context);
  }
}