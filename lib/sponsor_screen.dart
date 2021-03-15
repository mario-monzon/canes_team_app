import 'package:canes_app/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

class SponsorsPage extends StatefulWidget {
  String id;

  SponsorsPage({this.id});
  @override
  _SponsorsPageState createState() => _SponsorsPageState();
}

class _SponsorsPageState extends State<SponsorsPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: StreamBuilder(
        stream: Firestore.instance.collection('Sponsors').snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (!snapshot.hasData) {
            return Center(child: const Text('Loading events...'));
          }
          return GridView.builder(
            shrinkWrap: true,
            gridDelegate:
                SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
            itemBuilder: (BuildContext context, int index) {
              return Card(
                child: Column(children: <Widget>[
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Image.network(
                      snapshot.data.documents[index]['S_Logo'],
                      width: 100.0,
                      height: 100.0,
                    ),
                  ),
                  Text(
                    snapshot.data.documents[index]['S_Name'],
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: AppColors.amberCanes,
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600)),
                  ),
                  SizedBox(
                    height: 5.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: Icon(FontAwesomeIcons.globe),
                          iconSize: 20.0,
                          onPressed: () {
                            Utils.launchURL(
                                snapshot.data.documents[index]['S_Web']);
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.facebook),
                          iconSize: 20.0,
                          onPressed: () {
                            Utils.launchURL(
                                snapshot.data.documents[index]['S_Web']);
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.twitter),
                          iconSize: 20.0,
                          onPressed: () {
                            Utils.launchURL(
                                snapshot.data.documents[index]['S_Twit']);
                          }),
                      IconButton(
                          icon: Icon(FontAwesomeIcons.instagram),
                          iconSize: 20.0,
                          onPressed: () {
                            Utils.launchURL(
                                snapshot.data.documents[index]['S_Insta']);
                          }),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ]),
              );
            },
            itemCount: snapshot.data.documents.length,
          );
        },
      ),
    );
  }
}

BuildItem(DocumentSnapshot doc, BuildContext context) {
  return GestureDetector(
    onTap: () {
      Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => DetailsNew(
                  title: doc,
                )),
      );
    },
    child: Card(
      child: Column(children: <Widget>[
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              doc.data['E_Name'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.amberCanes,
                      fontSize: 16,
                      fontWeight: FontWeight.w600)),
            ),
            SizedBox(
              width: 10,
            ),
            Container(
              color: AppColors.amberCanes,
              width: 2,
              height: 15,
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              doc.data['E_Date'] + "  " + doc.data['E_hour'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: AppColors.lightGrey,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            ),
          ],
        ),
        SizedBox(
          height: 5,
        ),
        Row(
          children: [
            SizedBox(
              width: 30,
            ),
            Text(
              "Details :  " + doc.data['E_Desc'],
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w400)),
            )
          ],
        ),
        SizedBox(
          height: 10,
        ),
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

class _DetailsNewState extends State<DetailsNew> {
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.darkGrey,
        body: SingleChildScrollView(
            child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                color: AppColors.amberCanes,
                margin: const EdgeInsets.all(10.0),
                child: Image.network(
                  widget.title.data['N_Image'],
                  width: 500,
                  height: 250,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.title.data['N_Tilte'],
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: AppColors.amberCanes,
                        fontSize: 25,
                        fontWeight: FontWeight.w600)),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
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
              SizedBox(
                height: 10,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.all(10.0),
                child: Text(
                  widget.title.data['N_Details'],
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w200)),
                ),
              )
            ],
          ),
        )));
  }
}
