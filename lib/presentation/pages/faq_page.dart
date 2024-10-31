import 'package:flutter/material.dart';

class FaqPage extends StatelessWidget {
  const FaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFFF5F5DC),
        title: Text("FAQ"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Color(0xFFF5F5DC),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            faqItem(
              question: 'What is the purpose of this app?',
              answer:
                  'This app allows you to write messages to your future self. It acts as a time capsule, storing your letters and delivering them to you on a date you choose.',
            ),
            faqItem(
              question: 'How does the future delivery work?',
              answer:
                  'When you write a letter and select a future date, the app securely stores your message and will deliver it back to you on the specified date.',
            ),
            faqItem(
              question: 'Is my data secure?',
              answer:
                  'Yes, your data is stored securely on our servers, and we use industry-standard encryption to ensure your privacy.',
            ),
            faqItem(
              question: 'What happens if I forget my account details?',
              answer:
                  'If you forget your account details, please use the password recovery options provided in the app to regain access.',
            ),
            faqItem(
              question: 'Is this app free to use?',
              answer:
                  'Yes, the app is absolutely free.',
            ),
            faqItem(
              question: 'Who can I contact for support?',
              answer:
                  'For any questions or support, feel free to reach out to us at craftzcat34@gmail.com.',
            ),
          ],
        ),
      ),
    );
  }

  Widget faqItem({required String question, required String answer}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            question,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.brown[800],
            ),
          ),
          SizedBox(height: 8),
          Text(
            answer,
            style: TextStyle(color: Colors.brown[700]),
          ),
        ],
      ),
    );
  }
}
