import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'app_colors.dart';


class NewsPage extends StatefulWidget {
  String id;

  NewsPage({ this.id});
  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(
            '''What's New ? ''',
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
                  stream: Firestore.instance.collection('News').snapshots(),
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
    onTap: (){
      Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => DetailsNew(title: doc,)),
      );
    },
    child:  Card(
      child: Column(children: <Widget>[

        Container(
          margin: const EdgeInsets.all( 10.0),
          child: Image.network(doc.data['N_Image'], width: 500, height: 150,),
        ),
        Column(
          children: [
            SizedBox(width: 30,),
            Text(
              doc.data['N_Tilte'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.amberCanes,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(height: 3,),
            Container(
              color: AppColors.amberCanes,
              width: 30,
              height: 2,
            ),
            SizedBox(height: 3,),
            Text(
              doc.data['N_Created'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        SizedBox(height: 10,),

      ]),


    ),
  );


}



class DetailsNew extends StatefulWidget {
  DetailsNew({Key key, this.title}) : super(key: key);
  final DocumentSnapshot title;
  static String tag = 'detailsNew-page';

  @override
  _DetailsNewState createState() => new _DetailsNewState();
}

class _DetailsNewState extends State<DetailsNew>  {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {





    return   Scaffold(
        backgroundColor: AppColors.darkGrey,
        body: SingleChildScrollView(
        child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child:   Column(

                children: [

                  SizedBox(height: 50,),

                  Container(

                    color: AppColors.amberCanes,
                    margin: const EdgeInsets.all( 10.0),
                    child: Image.network(widget.title.data['N_Image'], width: 500, height: 250,),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    widget.title.data['N_Tilte'],
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: AppColors.amberCanes,
                            fontSize: 25,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(width: 10,),
                      Text(
                        widget.title.data['N_Created'],
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: AppColors.lightGrey,
                                fontSize: 16,
                                fontWeight: FontWeight.w400)),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    width: MediaQuery.of(context).size.width,

                    margin: const EdgeInsets.all( 10.0),
                    child: Text(
                        widget.title.data['N_Details'],style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w200)),
                    ),
                    )


                ],

            ),


        )
        )
    );
  }

}