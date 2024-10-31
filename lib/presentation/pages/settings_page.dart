import 'package:flutter/material.dart';
import 'package:futureme/auth/auth_service.dart';
import 'package:futureme/notifications/firebase_api.dart';
import 'package:futureme/presentation/pages/account_page.dart';
import 'package:futureme/presentation/pages/faq_page.dart';
import 'package:futureme/presentation/pages/how_it_works.dart';
import 'package:futureme/presentation/pages/privacy_policy.dart';
import 'package:futureme/presentation/pages/prompts_page.dart';
import 'package:futureme/presentation/pages/terms.dart';
import 'package:futureme/presentation/pages/whats_coming.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rating_dialog/rating_dialog.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  final FirebaseApi _firebaseApi = FirebaseApi();
  bool _hapticsEnabled = true;
  Future<void> sendEmail() async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'atatisam14@gmail.com',
      queryParameters: {'subject': 'FutureSelf Application!'},
    );

    try {
      bool canLaunch = await canLaunchUrl(emailUri);
      if (canLaunch) {
        await launchUrl(emailUri);
      } else {
        print('Cannot launch email app. No email app installed?');
      }
    } catch (e) {
      print('Error launching email app: $e');
      throw 'Could not launch email app';
    }
  }

  @override
  void initState() {
    super.initState();
    _loadNotificationSetting();
  }

  Future<void> _loadNotificationSetting() async {
    final enabled = await _firebaseApi.areNotificationsEnabled();
    setState(() {
      _notificationsEnabled = enabled;
    });
  }

  void _shareApp() {
    final String appName = "Future Me";
    final String appDescription = "Send messages to your future self!";
    // final String appStoreLink = "https://apps.apple.com/your-app-store-link";
    // final String playStoreLink = "https://play.google.com/store/your-play-store-link";
    final String futureSite = 'https://futureself-three.vercel.app/';

    String shareText = "Check out $appName - $appDescription\n\n";
    // shareText += "Download for iOS: $appStoreLink\n";
    // shareText += "Download for Android: $playStoreLink";
    shareText += "Link for the site: $futureSite";

    Share.share(shareText, subject: "Share $appName with your friends!");
  }

  Future<void> sendFeedbackEmail(double rating, String comment) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: 'atatisam14@gmail.com',
      query: encodeQueryParameters(<String, String>{
        'subject': 'App Feedback',
        'body': 'Rating: $rating\nComment: $comment',
      }),
    );

    try {
      if (await canLaunchUrl(emailLaunchUri)) {
        await launchUrl(emailLaunchUri);
      } else {
        throw 'Could not launch $emailLaunchUri';
      }
    } catch (e) {
      print('Error launching email client: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  String? encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }

  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) => Theme(
        data: ThemeData.light().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFFE57373),
            secondary: Color(0xFFE57373),
          ),
        ),
        child: RatingDialog(
          initialRating: 1.0,
          title: Text(
            'Enjoying Future Me?',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
          ),
          message: Text(
            'Tap a star to rate. Your feedback helps us improve!',
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(fontSize: 15),
          ),
          submitButtonText: 'SUBMIT',
          commentHint: 'Tell us your thoughts...',
          starSize: 30,
          submitButtonTextStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            fontSize: 17,
          ),
          onCancelled: () => print('Cancelled'),
          onSubmitted: (response) async {
            print('Rating: ${response.rating}, Comment: ${response.comment}');
            await sendFeedbackEmail(response.rating, response.comment);
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                  content: Text(
                      'Thank you for your feedback! An email has been prepared for you to send.')),
            );
          },
        ),
      ),
    );
  }

  void getAccountDetails(BuildContext context) {
    final auth = AuthService();
    final user = auth.getCurrentUser();

    if (user != null) {
      final String firstName = user.displayName ?? 'N/A';
      final String email = user.email ?? 'N/A';

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => AccountPage(
                    firstName: firstName,
                    email: email,
                  )));
    } else {
      print('No username and email available');
    }
  }

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
                    _buildSwitchSettingItem(Icons.notifications,
                        "Notifications", _notificationsEnabled, (value) {
                      setState(() {
                        _notificationsEnabled = value;
                      });
                    }),
                    _buildActionItem(Icons.alarm_add_outlined, "What's coming",
                        () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WhatsComing()));
                    }),
                    _buildActionItem(Icons.palette, "Writing Prompts", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => PromptsPage()));
                    }),
                    _buildActionItem(Icons.work, "How it works", () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => HowItWorks()));
                    }),
                    // _buildSettingItem(Icons.language, "Language", false),
                    // _buildSwitchSettingItem(
                    //     Icons.vibration, "Haptics", _hapticsEnabled, (value) {
                    //   setState(() {
                    //     _hapticsEnabled = value;
                    //   });
                    // }),
                    // _buildSettingItem(
                    //     Icons.calendar_today, "Week Start On", false),
                  ],
                ),
                const SizedBox(height: 24),
                // _buildSection(
                //   "More",
                //   [
                //     _buildActionItem(Icons.feedback, "Send Feedback", () {
                //       sendEmail();
                //     }),
                //     _buildActionItem(Icons.star, "Rate the Application", () {
                //       _showRatingDialog(context);
                //     }),
                //     _buildActionItem(
                //         Icons.share, "Share with Friends", _shareApp),
                //   ],
                // ),
                const SizedBox(
                  height: 24,
                ),
                _buildSection("Reviews", [
                  _buildReviewItem(
                    Icons.info_outline,
                    "FAQ",
                    () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => FaqPage()));
                    },
                  ),
                  _buildReviewItem(Icons.article, "Terms of Service", () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => Terms()));
                  }),
                  _buildReviewItem(Icons.gavel, "Privacy Policy", () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PrivacyPolicy()));
                  }),
                ]),
                const SizedBox(
                  height: 24,
                ),
                _buildSection(
                  "Auth",
                  [
                    _buildActionItem(Icons.account_circle_sharp, "Account",
                        () => getAccountDetails(context)),
                    _buildActionItem(Icons.logout, "Logout", logout),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSection(
    String title,
    List<Widget> children,
  ) {
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

  Widget _buildSwitchSettingItem(IconData icon, String title, bool currentValue,
      Function(bool) onchanged) {
    return ListTile(
      leading: Icon(
        icon,
        color: const Color(0xFFE57373),
      ),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: Switch(
        value: currentValue,
        onChanged: (value) async {
          await _firebaseApi.toggleNotifications(value);
          setState(() {
            _notificationsEnabled = value;
          });
          onchanged(value);
        },
        activeColor: const Color(0xFFE57373),
      ),
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

  Widget _buildReviewItem(IconData icon, String title, VoidCallback onTap,
      [String? trailing]) {
    return ListTile(
      leading: Icon(icon, color: const Color(0xFFE57373)),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: trailing != null
          ? Text(
              trailing,
              style: GoogleFonts.poppins(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.grey[600],
              ),
            )
          : null,
      onTap: onTap,
    );
  }
}
