import 'package:flutter/material.dart';

class Terms extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5DC),
        title: Text(
          "Terms of futureself",
          style: TextStyle(color: Colors.brown.shade800, fontWeight: FontWeight.bold),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.brown.shade800),
      ),
      backgroundColor: Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Last updated: 17th September 2024',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.brown.shade800,
                ),
              ),
              SizedBox(height: 20),
              sectionTitle('1. Acceptance of Terms'),
              sectionParagraph(
                  'By accessing and using the futureself app (the “App”), you accept and agree to these Terms of Service (“Terms”). '
                  'If you do not agree with these Terms, you must not use the App.'),
              sectionTitle('2. Account Registration'),
              sectionParagraph(
                  'To use futureself, you will need to create an account by registering with your email address. By creating an account, '
                  'you agree to provide accurate and complete information and keep it updated. You are responsible for maintaining the confidentiality of your account credentials.'),
              sectionTitle('3. Use of the Service'),
              sectionParagraph(
                  'The App allows you to write letters to your future self and select a date when you want these letters to be delivered back to you. '
                  'By using this service, you agree to use the App only for personal, lawful purposes.'),
              bulletList([
                'The letters will be stored securely on our servers and will only be delivered back to you at the date and time you specify.',
                'The App is not responsible for any failure to deliver the letter due to unforeseen technical issues or errors.',
                'The App does not guarantee the retention of letters beyond their delivery date.',
              ]),
              sectionTitle('4. Privacy and Data Security'),
              sectionParagraph(
                  'We value your privacy. All personal information provided to us is stored securely and handled in accordance with our '
                  'Privacy Policy. By using the App, you agree to the collection and use of information in line with our privacy practices.'),
              sectionParagraph(
                  'Your data, including letters and other personal information, will be stored on Firebase servers. Please refer to Firebase’s '
                  'privacy policies for more information on how they manage your data.'),
              sectionTitle('5. User Content'),
              sectionParagraph(
                  'You retain ownership of any letters or content you write within the App. By submitting content through the App, you grant futureself '
                  'a non-exclusive, royalty-free, worldwide license to store and deliver your letters as per your instructions.'),
              sectionParagraph('You are solely responsible for the content of your letters and must not submit any content that:'),
              bulletList([
                'Is illegal, harmful, abusive, or infringing on any third-party rights.',
                'Contains sensitive information such as passwords, financial data, or confidential personal information.',
              ]),
              sectionTitle('6. Termination'),
              sectionParagraph(
                  'We reserve the right to suspend or terminate your access to the App at any time, without prior notice, if you violate these Terms '
                  'or if we believe that your actions could harm the App or other users.'),
              sectionTitle('7. Limitation of Liability'),
              sectionParagraph(
                  'To the fullest extent permitted by law, futureself shall not be held liable for any direct, indirect, incidental, consequential, '
                  'or special damages arising out of or in connection with your use of the App or your inability to use the App.'),
              sectionTitle('8. Changes to Terms'),
              sectionParagraph(
                  'We may modify these Terms at any time. We will notify you of any changes by updating the "Last updated" date at the top of these Terms. '
                  'Your continued use of the App after changes to the Terms constitutes your acceptance of the modified terms.'),
              sectionTitle('9. Governing Law'),
              sectionParagraph(
                  'These Terms will be governed by and interpreted in accordance with the laws of Your Country, without regard to its conflict of law provisions.'),
              sectionTitle('10. Contact Information'),
              sectionParagraph(
                  'If you have any questions or concerns about these Terms, please contact us at craftzcat34@gmail.com.'),
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
          color: Colors.brown.shade900,
        ),
      ),
    );
  }

  Widget sectionParagraph(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        text,
        style: TextStyle(fontSize: 16, color: Colors.brown.shade700),
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
                style: TextStyle(color: Colors.brown.shade800, fontSize: 16),
              ),
              Expanded(
                child: Text(
                  item,
                  style: TextStyle(fontSize: 16, color: Colors.brown.shade700),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
