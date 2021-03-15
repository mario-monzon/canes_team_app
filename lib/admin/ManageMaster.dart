import 'package:canes_app/Player/Profile.dart';
import 'package:canes_app/admin/Events.dart';
import 'package:canes_app/admin/Sponsors.dart';
import 'package:canes_app/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Admins.dart';
import 'News.dart';
import 'Users.dart';

class ManageMaster extends StatefulWidget {
  String id;
  String Role;

  ManageMaster({ this.id, this.Role});
  @override
  _ManageMasterState createState() => _ManageMasterState();
}

class _ManageMasterState extends State<ManageMaster> {


  int bottomNavIndex = 0;
  @override
  Widget build(BuildContext context) {

    var tabs = [Users(Role: widget.Role, id : widget.id), Events(), News(), Sponsors(), Admins()];
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
                          Icon(Icons.person,
                            color: bottomNavIndex == 0
                                ?Colors.white
                                : Colors.black54,),
                          Text(
                            'Users',
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
                          Icon(Icons.star,
                            color: bottomNavIndex == 1
                                ? Colors.white
                                : Colors.black54,),
                          Text(
                            'Events',
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
                          Icon(Icons.book,
                            color: bottomNavIndex == 2
                                ? Colors.white
                                : Colors.black54,),
                          Text(
                            'News',
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
                          Icon(Icons.group_outlined,
                            color: bottomNavIndex == 3
                                ? Colors.white
                                : Colors.black54,),
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
                          Icon(Icons.assignment_ind_outlined ,
                            color: bottomNavIndex == 4
                                ? Colors.white
                                : Colors.black54,),
                          Text(
                            'Fans',
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


                    tabs[bottomNavIndex],
                  ],
                ),
              )),
        ));
  }


}
