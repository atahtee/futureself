import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnTheWayLettersPage extends StatelessWidget {
  const OnTheWayLettersPage({super.key});
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
      body: ListView.builder(
        itemCount: 3,
        padding: const EdgeInsets.all(20),
        itemBuilder: (context, index) {
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
                "Letter from  You",
                style: GoogleFonts.poppins(
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                "Arriving on ${DateTime.now().add(Duration(days: 30 * (index + 1))).toString().split(' ')[0]}",
                style: GoogleFonts.poppins(color: Colors.black54),
              ),
              trailing: const Icon(Icons.hourglass_empty, color: Color(0xFFE57373)),
            ),
          );
        },
      ),
    );
  }
}
