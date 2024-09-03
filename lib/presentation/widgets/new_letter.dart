import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:time_picker_spinner_pop_up/time_picker_spinner_pop_up.dart';

class NewLetterTab extends StatelessWidget {
  const NewLetterTab({super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime initialDate = DateTime.now().add(Duration(days: 30));

    return Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Write a letter to Future You",
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFFE57373),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: Offset(0, 5),
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    TextField(
                      maxLines: 8,
                      decoration: InputDecoration(
                        hintText: "Dear Future Me...",
                        hintStyle: GoogleFonts.poppins(color: Colors.grey[400]),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Color(0xFFF3E9E3).withOpacity(0.5),
                      ),
                      style: GoogleFonts.poppins(color: Colors.black87),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding: EdgeInsets.all(15),
                      decoration: BoxDecoration(
                        color: Color(0xFFF3E9E3).withOpacity(0.5),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                            color: Color(0xFFE57373).withOpacity(0.5)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Select Delivery Date',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFFE57373),
                            ),
                          ),
                          SizedBox(height: 10),
                          Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  color: Color(0xFFE57373)),
                              SizedBox(width: 10),
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border:
                                        Border.all(color: Color(0xFFE57373)),
                                  ),
                                  child: TimePickerSpinnerPopUp(
                                    mode: CupertinoDatePickerMode.date,
                                    initTime: initialDate,
                                    minTime: initialDate,
                                    maxTime: DateTime.now().add(Duration(days: 365 * 10)),
                                    barrierColor: Colors.black12,
                                    minuteInterval: 1,
                                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                    cancelText: 'Cancel',
                                    confirmText: 'Confirm',
                                    pressType: PressType.singlePress,
                                    timeFormat: 'dd MMM yyyy',
                                    onChange: (dateTime) {},
                                    textStyle: GoogleFonts.poppins(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      child: Text(
                        "Send to Future",
                        style: GoogleFonts.poppins(fontSize: 18),
                      ),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Color(0xFFE57373),
                        padding:
                            EdgeInsets.symmetric(vertical: 15, horizontal: 40),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        elevation: 5,
                      ),
                      onPressed: () {},
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
