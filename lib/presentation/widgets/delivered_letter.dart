import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeliveredLettersTab extends StatelessWidget {
  const DeliveredLettersTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Letters from Past You",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE57373), 
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 4,
              itemBuilder: (context, index) {
                return Container(
                  margin: EdgeInsets.only(bottom: 15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Color(0xFFE57373).withOpacity(0.2),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(Icons.mail, color: Color(0xFFE57373)),
                    ),
                    title: Text(
                      "Letter from ${DateTime.now().subtract(Duration(days: 365 * (index + 1))).year}",
                      style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Opened on ${DateTime.now().subtract(Duration(days: 30 * index)).toString().split(' ')[0]}",
                      style: GoogleFonts.poppins(color: Colors.black54),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios, color: Color(0xFFE57373)),
                    onTap: () {},
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}