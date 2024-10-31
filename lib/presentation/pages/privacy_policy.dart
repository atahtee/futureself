import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5DC),
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.brown[800]),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        elevation: 0,
      ),
      backgroundColor: Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Privacy Policy',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.brown[800],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 24),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Last updated: [17th September 2024]',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.brown[800],
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'This Privacy Policy describes how futureself ("we", "our", or "us") collects, uses, and shares your personal information when you use our mobile application (the “App”).',
                    style: TextStyle(color: Colors.brown[800]),
                  ),
                  SizedBox(height: 24),
                  sectionTitle('1. Information We Collect'),
                  sectionParagraph(
                      'When you use futureself, we collect the following types of information:'),
                  bulletList([
                    'Personal Information: Information you provide during registration, such as your name, email address, and any other information you provide to us voluntarily.',
                    'Letter Content: The content of the letters you write to your future self, which will be stored on our servers until the delivery date you specify.',
                    'Device Information: Information about the device you use to access the App, such as the device type, operating system, and unique device identifiers.',
                  ]),
                  sectionTitle('2. How We Use Your Information'),
                  sectionParagraph(
                      'We use the information we collect for the following purposes:'),
                  bulletList([
                    'To provide and maintain the App.',
                    'To personalize and improve your experience with the App.',
                    'To securely store and deliver your letters according to your instructions.',
                    'To communicate with you about updates, security alerts, and other important information.',
                  ]),
                  sectionTitle('3. How We Share Your Information'),
                  sectionParagraph(
                      'We do not sell, trade, nor rent your personal information to others. However, we may share your data in the following circumstances:'),
                  bulletList([
                    'With Service Providers: We may share your data with third-party service providers, such as Firebase, that help us operate and manage the App.',
                    'For Legal Reasons: We may disclose your information to comply with applicable laws, legal processes, or governmental requests.',
                    'With Your Consent: We may share your information with your consent for specific purposes.',
                  ]),
                  sectionTitle('4. Data Security'),
                  sectionParagraph(
                      'We take the security of your personal information seriously. We use industry-standard encryption and security measures to protect your data from unauthorized access, alteration, disclosure, or destruction. However, no method of transmission over the internet or electronic storage is completely secure, and we cannot guarantee its absolute security.'),
                  sectionTitle('5. Data Retention'),
                  sectionParagraph(
                      'We will retain your personal information and the content of your letters for as long as necessary to fulfill the purposes outlined in this Privacy Policy. Once your letter is delivered to you, we may delete the stored content after a reasonable period.'),
                  sectionTitle('6. Your Rights'),
                  sectionParagraph(
                      'You have the right to access, update, or delete your personal information at any time by contacting us at [atatisam14@gmail.com]. You may also request to delete your account, which will result in the deletion of all your data, including your letters, from our servers.'),
                  sectionTitle('7. Third-Party Links'),
                  sectionParagraph(
                      'The App may contain links to third-party websites or services, such as Firebase. We are not responsible for the privacy practices or the content of such third-party services. We recommend reviewing the privacy policies of those third-party services before providing them with your data.'),
                  sectionTitle('8. Changes to This Privacy Policy'),
                  sectionParagraph(
                      'We may update this Privacy Policy from time to time. We will notify you of any significant changes by updating the "Last updated" date at the top of this Privacy Policy. Your continued use of the App after the changes take effect signifies your acceptance of the revised policy.'),
                  sectionTitle('9. Contact Us'),
                  sectionParagraph(
                      'If you have any questions or concerns about this Privacy Policy, please contact at [craftzcat34@gmail.com].'),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionTitle(String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 24.0, bottom: 8.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.brown[800],
        ),
      ),
    );
  }

  Widget sectionParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(color: Colors.brown[800]),
      ),
    );
  }

  Widget bulletList(List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '• ',
                style: TextStyle(color: Colors.brown[800]),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(color: Colors.brown[800]),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
