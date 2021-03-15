import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';


class EventsPage extends StatefulWidget {
  String id;

  EventsPage({ this.id});
  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            '''Our Events ''',
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
                  stream: Firestore.instance.collection('Events').snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {

                      return Column(children: snapshot.data.documents.map<Widget>((doc) => BuildItem(doc, context)).toList());
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


BuildItem(DocumentSnapshot doc, BuildContext context){


  return GestureDetector(

    child:  Card(
      child: Column(children: <Widget>[
        SizedBox(height: 10,),
        Row(
          children: [
            SizedBox(width: 30,),
            Text(
              doc.data['E_Name'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.amberCanes,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(width: 10,),
            Container(
              color: AppColors.amberCanes,
              width: 2,
              height: 15,
            ),
            SizedBox(width: 10,),
            Text(
              doc.data['E_Date']+ "  "+  doc.data['E_hour'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        SizedBox(height: 5,),
        Row(
          children: [
            SizedBox(width: 30,),
            Container(
              width: MediaQuery.of(context).size.width/1.3,
            child: Text(
              "Details :  " + doc.data['E_Desc'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),)
          ],
        ),
        SizedBox(height: 10,),

      ]),


    ),
  );


}


