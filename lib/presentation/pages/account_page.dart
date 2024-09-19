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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.black87,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.blue[50]!,
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
                label: 'Send Message to Future Self',
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
      elevation: 4,
      shadowColor: Colors.black.withOpacity(0.1),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue[100],
              child: Text(
                widget.firstName[0].toUpperCase(),
                style: TextStyle(fontSize: 40, color: Colors.blue[800]),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              widget.firstName,
              style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87),
            ),
            const SizedBox(height: 8),
            Text(
              widget.email,
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54),
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
          foregroundColor: isDestructive ? Colors.red : Colors.blue[700],
          backgroundColor: isDestructive ? Colors.red[50] : Colors.blue[50],
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        ),
        child: Row(
          children: [
            Icon(icon, size: 24),
            const SizedBox(width: 12),
            Text(label, style: const TextStyle(fontSize: 16)),
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
