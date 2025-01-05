import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:futureme/presentation/widgets/delivered_letter.dart';
import 'package:futureme/presentation/widgets/new_letter.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  User? _user;

  @override
  void initState() {
    super.initState();
    _auth.authStateChanges().listen((event) {
      setState(() {
        _user = event;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            color: Color(0xFFF3E9E3),
          ),
          child: SafeArea(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                    _user != null ? 'Welcome ${_user?.email ?? 'No email'}' : ('Dear futureself'),
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFFE57373),
                      letterSpacing: 1.2,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 20),
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
                          color: const Color(0xFFE57373).withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    tabs: const [
                      Tab(text: "New Letter"),
                      Tab(text: "Delivered"),
                    ],
                    labelStyle: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
                    ),
                    unselectedLabelColor: const Color(0xFFE57373),
                    labelColor: Colors.white,
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelPadding: EdgeInsets.zero,
                  ),
                ),
                const SizedBox(height: 30),
                const Expanded(
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

 Widget _userInfo() {
  if (_user != null) {
    return Text(
      'Welcome, ${_user?.email ?? 'No email'}',
      style: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: const Color(0xFFE57373),
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  } else {
    return const Text('Dear Futureself',
      style: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w600,
        color: Color(0xFFE57373),
        letterSpacing: 1.2,
      ),
      textAlign: TextAlign.center,
    );
  }
}

}
