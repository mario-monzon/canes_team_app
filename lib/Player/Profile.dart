import 'package:canes_app/RosterPage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../News.dart';
import '../app_colors.dart';


class Profile extends StatefulWidget {
  String id;

  Profile({ this.id});
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          SizedBox(height: 20),
          NewsPage(),
        ],
      ),


    );
  }
}

class AddButton extends StatelessWidget {
  final String text;
  final Function onPressed;

  AddButton(this.text, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          decoration: BoxDecoration(
              color: AppColors.amberCanes,
              borderRadius: BorderRadius.all(Radius.circular(10))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                text,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    )),
              ),
              Icon(Icons.add, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}
