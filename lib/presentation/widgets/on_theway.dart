import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnTheWayLettersPage extends StatelessWidget {
  const OnTheWayLettersPage({super.key});

  Future<QuerySnapshot> _getLetters() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('letters')
          .where('userId', isEqualTo: user.uid)
          .orderBy('deliveryDate')
          .get();
    }
    throw FirebaseAuthException(
        message: 'No user logged in', code: 'USER_NOT_FOUND');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Letters On The Way",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE57373),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: _getLetters(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(child: Text('No letters found'));
          }

          final letters = snapshot.data!.docs;

          return ListView.builder(
            itemCount: letters.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              final letter = letters[index];
              final deliveryDate = (letter['deliveryDate'] as Timestamp).toDate();
              final letterContent = letter['letterContent'];

              return GestureDetector(
                onTap: () {
                  // Navigate to details page when letter is clicked
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LetterDetailsPage(
                        deliveryDate: deliveryDate,
                        letterContent: letterContent,
                      ),
                    ),
                  );
                },
                child: Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE57373).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.local_shipping, color: Color(0xFFE57373)),
                    ),
                    title: Text(
                      "Letter from You",
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Arriving on ${deliveryDate.toString().split(' ')[0]}",
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                    trailing: const Icon(Icons.hourglass_empty, color: Color(0xFFE57373)),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class LetterDetailsPage extends StatelessWidget {
  final DateTime deliveryDate;
  final String letterContent;

  const LetterDetailsPage({
    super.key,
    required this.deliveryDate,
    required this.letterContent,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Letter Details",
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFE57373),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Arriving on: ${deliveryDate.toString().split(' ')[0]}",
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFFE57373),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Text(
                    letterContent,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.black87,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
