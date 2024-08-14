import 'package:flutter/material.dart';
import 'package:futureme/presentation/widgets/delivered_letter.dart';
import 'package:futureme/presentation/widgets/new_letter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            color: Color(0xFFF3E9E3),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    "Dear FutureSelf",
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFFE57373), // Soft terracotta
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: TabBar(
                    indicator: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      color: const Color(0xFFE57373),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFFE57373).withOpacity(0.3),
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    tabs: [
                      Tab(text: "New Letter"),
                      Tab(text: "Delivered"),
                    ],
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelColor: Color(0xFFE57373), 
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: 30),
                Expanded(
                  child: TabBarView(
                    children: [
                      NewLetterTab(),
                      DeliveredLettersTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}