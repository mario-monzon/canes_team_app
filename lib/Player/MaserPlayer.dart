import 'package:canes_app/News.dart';
import 'package:canes_app/RosterPage.dart';
import 'package:canes_app/admin/ManageMaster.dart';
import 'package:canes_app/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../Events.dart';
import '../LoginScreen.dart';
import '../sponsor_screen.dart';
import 'CarSharing.dart';

class Master extends StatefulWidget {
  String id;

  Master({this.id});
  @override
  _MasterState createState() => _MasterState();
}

class _MasterState extends State<Master> {
  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {
    var tabs = [
      NewsPage(id: widget.id),
      RosterPage(id: widget.id),
      EventsPage(),
      CarSharing(
        title: widget.id,
      ),
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
                        Icons.person_outline,
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
                        Icons.group_outlined,
                        color:
                            bottomNavIndex == 3 ? Colors.white : Colors.black54,
                      ),
                      Text(
                        'Car sharing',
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
            Expanded(
              child: GestureDetector(
                onTap: () {
                  setState(() {
                    bottomNavIndex = 4;
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
                                color: bottomNavIndex == 4
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
                              .collection('Players')
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                          color: AppColors.amberCanes,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12))),
                                      child: ClipRRect(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(12)),
                                          child: snapshot.data['Photo'] == null
                                              ? Image.network(
                                                  "https://cdn.icon-icons.com/icons2/510/PNG/512/person_icon-icons.com_50075.png",
                                                  fit: BoxFit.cover,
                                                )
                                              : Image.network(
                                                  snapshot.data['Photo'],
                                                  fit: BoxFit.cover,
                                                )),
                                    ),
                                    SizedBox(width: 8),
                                    Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          snapshot.data['First_Name'] +
                                              " " +
                                              snapshot.data['Last_Name'],
                                          style: GoogleFonts.poppins(
                                              textStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.w600)),
                                        ),
                                        RichText(
                                          text: TextSpan(
                                              text: 'Player Name : ',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              children: [
                                                TextSpan(
                                                  text: snapshot
                                                      .data['First_Name'],
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
                                              text: 'Phone No. : ',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              children: [
                                                TextSpan(
                                                  text: snapshot.data['Phone'],
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
                                              text: 'Number : ',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              children: [
                                                TextSpan(
                                                  text: snapshot.data['Number'],
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
                                              text: 'Position : ',
                                              style: GoogleFonts.poppins(
                                                  textStyle: TextStyle(
                                                      color: Colors.black87,
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.w400)),
                                              children: [
                                                TextSpan(
                                                  text:
                                                      snapshot.data['Position'],
                                                  style: GoogleFonts.poppins(
                                                      textStyle: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w400)),
                                                ),
                                              ]),
                                        ),
                                        SizedBox(height: 8),
                                      ],
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        snapshot.data['Role'] != 0
                                            ? IconButton(
                                                icon: Icon(
                                                  Icons.settings,
                                                  color: Colors.white,
                                                  size: 28,
                                                ),
                                                onPressed: () {
                                                  Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ManageMaster(
                                                              id: widget.id,
                                                              Role: snapshot
                                                                  .data['Role']
                                                                  .toString(),
                                                            )),
                                                  );
                                                })
                                            : SizedBox(),
                                        SizedBox(
                                          height: 30,
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.logout,
                                            color: Colors.white,
                                            size: 28,
                                          ),
                                          onPressed: () async {
                                            await FirebaseAuth.instance
                                                .signOut();
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Login()));
                                          },
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              );
                            } else {
                              return SizedBox();
                            }
                          }),
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
