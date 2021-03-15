import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';


class RosterPage extends StatefulWidget {
  String id;

  RosterPage({ this.id});
  @override
  _RosterPageState createState() => _RosterPageState();
}

class _RosterPageState extends State<RosterPage> {
  var icon = ['cake', 'report', 'warning'];
  var color = [Colors.green, Colors.red, Colors.deepOrange[300]];
  var title = [
    'Bill Mathews birthday is in 5 days on xx/yy/mm.',
    'John Koshy’s physician’s Report is expiring in less than 30 days.',
    'Brett Goldsmith do not have all the resident documentation on file!'
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            '''Our Players ''',
            style: GoogleFonts.poppins(
                textStyle: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w600)),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 8),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Players').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return Column(children: snapshot.data.documents.map<Widget>((doc) => BuildItem(doc)).toList());
                    } else {
                      return SizedBox();
                    }
                  },
                ),
              )
            ],
          )
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
BuildItem(DocumentSnapshot doc){


    return GestureDetector(
      onTap: ()=> print(doc.data['userID']),
      child : Column(
        children: [
          Container(
            padding:
            EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                color: AppColors.amberCanes.withOpacity(0.1),
                borderRadius:
                BorderRadius.all(Radius.circular(12))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 110,
                  height: 90,
                  decoration: BoxDecoration(
                      color: AppColors.amberCanes,
                      borderRadius:
                      BorderRadius.all(Radius.circular(12))),
                  child: ClipRRect(
                      borderRadius:
                      BorderRadius.all(Radius.circular(12)),
                      child: Image.network(
                        doc.data['Photo'] ,
                        fit: BoxFit.cover,
                      )),
                ),
                SizedBox(width: 8),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 8),
                    Text(
                      doc.data['First_Name'] + " "+ doc.data['Last_Name'],
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: AppColors.amberCanes,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                    ),
                    RichText(
                      text: TextSpan(
                          text: 'Number : ',
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          children: [
                            TextSpan(
                              text: doc.data['Number'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color:AppColors.amberCanes,
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
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400)),
                          children: [
                            TextSpan(
                              text: doc.data['Position'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColors.amberCanes,
                                      fontWeight:
                                      FontWeight.w400)),
                            ),
                          ]),
                    ),


                  ],
                )
              ],
            ),
          ),
          SizedBox(height: 8)
        ],
      ),
    );

}