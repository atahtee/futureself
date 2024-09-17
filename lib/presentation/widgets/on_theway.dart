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
          .where('deliveryDate', isGreaterThan: Timestamp.now())
          .orderBy('deliveryDate')
          .get();
    }
    throw FirebaseAuthException(
        message: 'No user logged in', code: 'USER_NOT_FOUND');
  }

  Future<void> _deleteLetter(BuildContext context, String letterId) async {
  final confirm = await showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('Confirm Deletion'),
        content: const Text('Are you sure you want to delete this letter?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel')
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Delete')
          )
        ],
      );
    }
  );

  if (confirm == true) {
    try {
      await FirebaseFirestore.instance
          .collection('letters')
          .doc(letterId)
          .delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Letter deleted successfully'))
      );
      print('Letter deleted successfully: $letterId');  // Add this line for logging
    } catch (e) {
      print('Error deleting letter: $e');  // Add this line for logging
      String errorMessage = 'Failed to delete letter';
      if (e is FirebaseException) {
        errorMessage += ': ${e.code} - ${e.message}';
      } else {
        errorMessage += ': $e';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage))
      );
    }
  }
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
            return const Center(child: Text('No letters found yet'));
          }

          final letters = snapshot.data!.docs;

          return ListView.builder(
            itemCount: letters.length,
            padding: const EdgeInsets.all(20),
            itemBuilder: (context, index) {
              final letter = letters[index];
              final letterId = letter.id;
              final deliveryDate =
                  (letter['deliveryDate'] as Timestamp).toDate();
              final letterContent = letter['letterContent'];

              return GestureDetector(
                onTap: () {
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
                onLongPress: () => _deleteLetter(context, letterId),
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
                      child: const Icon(Icons.local_shipping,
                          color: Color(0xFFE57373)),
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
                    trailing: const Icon(Icons.hourglass_empty,
                        color: Color(0xFFE57373)),
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
