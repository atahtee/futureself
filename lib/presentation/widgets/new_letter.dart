import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NewLetterTab extends StatefulWidget {
  const NewLetterTab({super.key});

  @override
  State<NewLetterTab> createState() => _NewLetterTabState();
}

class _NewLetterTabState extends State<NewLetterTab> {
  final TextEditingController _letterController = TextEditingController();
  DateTime _selectedDate = DateTime.now().add(const Duration(days: 30));
  String? username;

  @override
  void initState() {
    super.initState();
    _fetchUsername();
  }

  Future<void> _fetchUsername() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        username = userDoc['username'];
      });
    }
  }

  Future<void> _sendToFuture() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final letterContent = _letterController.text;

      if (letterContent.isNotEmpty) {
        await FirebaseFirestore.instance.collection('letters').add({
          'userId': user.uid,
          'letterContent': letterContent,
          'deliveryDate': _selectedDate,
          'createdAt': Timestamp.now()
        });

        _letterController.clear();

        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Letter sent to the future')));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text('Please write a letter')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            username != null
                ? "Write a letter to Future $username"
                : "Write a letter to Future You",
            style: GoogleFonts.poppins(
              fontSize: 24,
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
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      controller: _letterController,
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Dear Future Me...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: const Color(0xFFF3E9E3).withOpacity(0.5),
                      ),
                      style: GoogleFonts.poppins(color: Colors.black87),
                    ),
                    const SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF3E9E3).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: const Color(0xFFE57373).withOpacity(0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Delivery Date',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: const Color(0xFFE57373),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today,
                                  color: Color(0xFFE57373)),
                              const SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: const Color(0xFFE57373)),
                                    ),
                                    child: InkWell(
                                      onTap: () async {
                                      final DateTime?
                                          picked = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime.now()
                                                  .add(
                                                      const Duration(days: 30)),
                                              lastDate: DateTime.now().add(
                                                  const Duration(
                                                      days: 365 * 10)));
                                      if (picked != null &&
                                          picked != _selectedDate) {
                                        setState(() {
                                          _selectedDate = picked;
                                        });
                                      }
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                      child: Text(
                                        '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                        style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          color: Colors.black87
                                        ),
                                      ),
                                      )
                                    )
                                    // child: TimePickerSpinnerPopUp(
                                    //   mode: CupertinoDatePickerMode.date,
                                    //   initTime: initialDate,
                                    //   minTime: initialDate,
                                    //   maxTime: DateTime.now()
                                    //       .add(const Duration(days: 365 * 10)),
                                    //   barrierColor: Colors.black12,
                                    //   minuteInterval: 1,
                                    //   padding: const EdgeInsets.symmetric(
                                    //       horizontal: 12, vertical: 15),
                                    //   cancelText: 'Cancel',
                                    //   confirmText: 'Confirm',
                                    //   pressType: PressType.singlePress,
                                    //   timeFormat: 'dd MMM yyyy',
                                    //   onChange: (dateTime) {
                                    //     setState(() {
                                    //       _selectedDate = dateTime;
                                    //     });
                                    //   },
                                    //   textStyle: GoogleFonts.poppins(
                                    //     fontSize: 16,
                                    //     color: Colors.black87,
                                    //   ),
                                    // ),
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xFFE57373),
                        padding: const EdgeInsets.symmetric(
                            vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 0,
                      ),
                      onPressed: _sendToFuture,
                      child: Text(
                        "Send to Future",
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
