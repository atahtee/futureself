import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futureme/presentation/widgets/on_theway.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveredLettersTab extends StatelessWidget {
  const DeliveredLettersTab({super.key});

  Future<QuerySnapshot> _getDeliveredLetters() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      return FirebaseFirestore.instance
          .collection('letters')
          .where('userId', isEqualTo: user.uid)
          .where('deliveryDate', isLessThanOrEqualTo: Timestamp.now())
          .orderBy('deliveryDate', descending: true)
          .get();
    }
    throw FirebaseAuthException(
        message: 'No user logged in', code: 'USER_NOT_FOUND');
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Letters from Past You",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: const Color(0xFFE57373),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<QuerySnapshot>(
              future: _getDeliveredLetters(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text('Error: ${snapshot.error}'),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text('No delivered letters yet.'),
                  );
                }
                final letters = snapshot.data!.docs;

                return ListView.builder(
                    itemCount: letters.length,
                    itemBuilder: (context, index) {
                      final letter = letters[index];
                      final deliveryDate =
                          (letter['deliveryDate'] as Timestamp).toDate();
                      final letterContent = letter['letterContent'];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 15),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.05),
                                blurRadius: 5,
                                offset: const Offset(0, 3),
                              )
                            ]),
                        child: ListTile(
                          leading: Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                color: const Color(0xFFE57373).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10)),
                            child: const Icon(
                              Icons.mail,
                              color: Color(0xFFE57373),
                            ),
                          ),
                          title: Text(
                            "Letter from ${deliveryDate.year}",
                            style: GoogleFonts.poppins(
                                color: Colors.black87,
                                fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            "Delivered on ${deliveryDate.toString().split(' ')[0]}",
                            style: GoogleFonts.poppins(color: Colors.black54),
                          ),
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            color: Color(0xFFE5737),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LetterDetailsPage(
                                        deliveryDate: deliveryDate,
                                        letterContent: letterContent)));
                          },
                        ),
                      );
                    });
              },
            ),
          ),
          _buildOnTheWayButton(context)
        ],
      ),
    );
  }

  Widget _buildOnTheWayButton(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OnTheWayLettersPage()),
        );
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
        decoration: BoxDecoration(
          color: const Color(0xFFE57373),
          borderRadius: BorderRadius.circular(30),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFFE57373).withOpacity(0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.local_shipping, color: Colors.white),
            const SizedBox(width: 10),
            Text(
              "On the way",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
              // child: Text(
              //   "5",
              //   style: GoogleFonts.poppins(
              //     color: const Color(0xFFE57373),
              //     fontWeight: FontWeight.bold,
              //     fontSize: 14,
              //   ),
              // ),
            ),
          ],
        ),
      ),
    );
  }
}
