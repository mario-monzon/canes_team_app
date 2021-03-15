import 'package:canes_app/News.dart';
import 'package:canes_app/RosterPage.dart';
import 'package:canes_app/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Events.dart';
import '../LoginScreen.dart';
import '../sponsor_screen.dart';

class MasterFan extends StatefulWidget {
  String id;

  MasterFan({this.id});
  @override
  _MasterFanState createState() => _MasterFanState();
}

class _MasterFanState extends State<MasterFan> {
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    var tabs = [
      NewsPage(),
      RosterPage(),
      EventsPage(),
      SponsorsPage(
        id: widget.id,
      )
    ];
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.darkGrey,
      bottomNavigationBar: Container(
        height: 56,
        decoration: BoxDecoration(
            color: AppColors.amberCanes,
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Row(
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bottomNavIndex = 0;
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.home_outlined,
                        color:
                            bottomNavIndex == 0 ? Colors.white : Colors.black54,
                      ),
                      Text(
                        'Home',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: bottomNavIndex == 0
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bottomNavIndex = 1;
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.favorite_border,
                        color:
                            bottomNavIndex == 1 ? Colors.white : Colors.black54,
                      ),
                      Text(
                        'Roster',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: bottomNavIndex == 1
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bottomNavIndex = 2;
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        color:
                            bottomNavIndex == 2 ? Colors.white : Colors.black54,
                      ),
                      Text(
                        'Events',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: bottomNavIndex == 2
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bottomNavIndex = 3;
                  });
                },
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.assignment_ind_outlined,
                        color:
                            bottomNavIndex == 4 ? Colors.white : Colors.black54,
                      ),
                      Text(
                        'Sponsors',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: bottomNavIndex == 3
                                    ? Colors.white
                                    : Colors.black54,
                                fontSize: 12,
                                fontWeight: FontWeight.w500)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 10),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.amberCanes.withOpacity(0.1),
                      borderRadius: BorderRadius.all(Radius.circular(12))),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StreamBuilder(
                          stream: Firestore.instance
                              .collection('Fans')
                              .document(widget.id)
                              .snapshots(),
                          builder:
                              (BuildContext context, AsyncSnapshot snapshot) {
                            if (snapshot.hasData) {
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 8),
                                decoration: BoxDecoration(
                                    color: AppColors.amberCanes,
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(12))),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      height: 5,
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text:
                                              '              First Name :    ',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          children: [
                                            TextSpan(
                                              text: snapshot.data['First_Name'],
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ]),
                                    ),
                                    RichText(
                                      text: TextSpan(
                                          text: '              Last Name :    ',
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.black87,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w400)),
                                          children: [
                                            TextSpan(
                                              text: snapshot.data['Last_Name'],
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                            ),
                                          ]),
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        SizedBox(width: 8),
                                        Container(
                                          width: 1,
                                          height: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.pushReplacement(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                          },
                                          child: Center(
                                            child: Text(
                                              'Log out',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600)),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Container(
                                          width: 1,
                                          height: 16,
                                          color: Colors.white,
                                        ),
                                        SizedBox(width: 8),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [],
                          )
                        ],
                      ),
                    ],
                  ),
                ),
                tabs[bottomNavIndex],
              ],
            ),
          )),
    ));
  }
}
