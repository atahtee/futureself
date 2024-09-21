import 'package:flutter/material.dart';

class PromptsPage extends StatelessWidget {
  PromptsPage({Key? key}) : super(key: key);

  final List<String> prompts = [
    "What advice would you give to yourself 5 years from now?",
    "Describe your ideal day 10 years in the future.",
    "What goal do you hope to achieve by next year?",
    "Write about a skill you want to master in the coming years.",
    "Imagine your life in 20 years. What has changed?",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Prompts for Future You'),
        backgroundColor: Color(0xFFE57373),
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFFE57373), Colors.white],
          ),
        ),
        child: ListView.builder(
          padding: EdgeInsets.all(16),
          itemCount: prompts.length,
          itemBuilder: (context, index) {
            return Card(
              elevation: 4,
              margin: EdgeInsets.only(bottom: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: ListTile(
                contentPadding: EdgeInsets.all(16),
                title: Text(
                  prompts[index],
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
                ),

              ),
            );
          },
        ),
      ),
     
    );
  }
}