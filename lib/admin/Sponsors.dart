import 'package:date_format/date_format.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:intl/intl.dart';
import 'package:canes_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';
import '../textfield.dart';
import 'dart:async';

import 'package:url_launcher/url_launcher.dart';

class Sponsors extends StatefulWidget {
  static String tag = 'Sponsors-page';
  @override
  _SponsorsState createState() => new _SponsorsState();

}

class _SponsorsState extends State<Sponsors>  {

  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {
    final DateTime now = DateTime.now();
    _launchURL(String url) async {

      if (await canLaunch(url)) {
        await launch(url);
      } else {
        throw 'Could not launch $url';
      }
    }
    void DeleteSponsor(String id) async {
      Widget okButton = FlatButton(
        child: Text("YES " , style: TextStyle(color: AppColors.darkGrey),),
        onPressed: () async {

          // FirebaseUser = await FirebaseAuth.instance.ge
          await db.collection("Sponsors").document(id).delete()
              .catchError((e) {
            print(e);
          });

          Navigator.of(context).pop();

        },

      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("  Delete"),
        content: Text("Do you really want to delete this sponsor ?"),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );


    }
    BuildItem(DocumentSnapshot doc){




      return Container(
        decoration: BoxDecoration(
            color:AppColors.amberCanes.withOpacity(0.1),
            borderRadius: BorderRadius.all(Radius.circular(12))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
                      padding:
                      EdgeInsets.symmetric(horizontal: 8, vertical: 8),
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
                                borderRadius:
                                BorderRadius.all(Radius.circular(12))),
                            child: ClipRRect(
                                borderRadius:
                                BorderRadius.all(Radius.circular(12)),
                                child: Image.network(
                                  doc.data['S_Logo'],
                                  fit: BoxFit.cover,
                                )),
                          ),
                          SizedBox(width: 8),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Row(
                                children: [
                                  Text(
                                    doc.data['S_Name'] ,
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.white,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w600)),
                                  ),
                                  SizedBox(width: MediaQuery.of(context).size.width/3.5,),
                                  IconButton(icon: Icon(Icons.delete,color: Colors.white,), onPressed: ()=>DeleteSponsor(doc.data['S_ID']))
                                ],
                              ),


                              RichText(
                                text: TextSpan(
                                    text: 'Website : ',
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: Colors.black87,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w400)),
                                    children: [
                                      TextSpan(
                                        text: doc.data['S_Web'],
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color:Colors.white,
                                                fontWeight:
                                                FontWeight.w400)),
                                      ),
                                    ]),
                              ),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      _launchURL(doc.data['S_Web']);
                                    },
                                    child: Center(
                                      child: Text(
                                        'Facebook',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
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
                                  GestureDetector(
                                    onTap: () {},
                                    child: Center(
                                      child: Text(
                                        'Instagram',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
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
                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: Center(
                                      child: Text(
                                        'Twitter',
                                        style: GoogleFonts.poppins(
                                            textStyle: TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight:
                                                FontWeight.w600)),
                                      ),
                                    ),
                                  ),



                                ],
                              )
                            ],
                          )
                        ],
                      ),
                    ),

          ],
        ),
      );

    }

    return SingleChildScrollView(
      child:  Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
                color: AppColors.amberCanes,
                borderRadius: BorderRadius.all(Radius.circular(12))),
            child:  Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text(
                'Add Sponsors',
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.w600)),
              ),
                IconButton(
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: 28,
                    ),
                    onPressed: (){
                      Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AddSponsor()),
                      );
                    }
                )
              ],
            ),

          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              SizedBox(height: 8),
              Container(
                child: StreamBuilder<QuerySnapshot>(
                  stream: Firestore.instance.collection('Sponsors').snapshots(),
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
          ),



        ],
      ),




    );






  }




}



class AddSponsor extends StatefulWidget {
  AddSponsor({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'AddSponsor-page';

  @override
  _AddSponsorState createState() => new _AddSponsorState();
}

class _AddSponsorState extends State<AddSponsor>  {
  final db = Firestore.instance;

  TextEditingController namecontroller = TextEditingController();
  TextEditingController webcontroller = TextEditingController();
  TextEditingController fbcontroller = TextEditingController();
  TextEditingController inscontroller = TextEditingController();
  TextEditingController twitcontroller = TextEditingController();


  final _formNew = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {





    return   Scaffold(
        backgroundColor: AppColors.darkGrey,
        body:  SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key:_formNew ,
              child:   Column(

                children: [


                  SizedBox(height: 100),
                  TextFormField(
                    validator: _validator,
                    controller: namecontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Title",
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: _UrlValidator,
                    controller: webcontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Website",
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: _UrlValidator,
                    controller: fbcontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Facebook",
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: _UrlValidator,
                    controller: inscontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Instagram",
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: _UrlValidator,
                    controller: twitcontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Twitter",
                    ),
                  ),
                  SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {

                      AddPhoto(context);



                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color:  _colup,
                          borderRadius: BorderRadius.all(
                              Radius.circular(12))),
                      child: Center(
                        child: Text(
                          up,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 8),

                  GestureDetector(
                    onTap: (){
                      if (_formNew.currentState.validate()) {
                        _formNew.currentState.save();
                        AddSpons(context, namecontroller.text.trim(), webcontroller.text.trim(), fbcontroller.text.trim(), inscontroller.text.trim(), twitcontroller.text.trim(), _url);


                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color:  _colupdate,
                          borderRadius: BorderRadius.all(
                              Radius.circular(12))),
                      child: Center(
                        child: Text(
                          update,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600)),
                        ),
                      ),
                    ),
                  )



                ],
              ),
            )


        )

    );
  }
  String up = "Upload Sponsor Logo";
  String update = "Add Sponsor";
  Color _colupdate = AppColors.amberCanes;
  String update2 = "Update";
  Color _colupdate2 = AppColors.amberCanes;
  Color _colup = AppColors.amberCanes;
  String _url;
  AddPhoto( BuildContext context)async{
    _url = null;

    File file = await FilePicker.getFile(type: FileType.custom,
      allowedExtensions: ['jpg'],);
    String fileName = basename(file.path);


    StorageReference _reference = FirebaseStorage.instance.ref().child(fileName);
    StorageUploadTask uploadTask = _reference.putFile(file);
    setState(() {

      up = "Uploading ...";
    });
    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
    String urlAdress = await _reference.getDownloadURL();

    setState(() {
      _url = urlAdress;


    });

    if(_url != urlAdress){
      print("try again");

    }else {

      setState(() {


        up = "Uploaded ! ";

        _colup = Colors.green;

      });



    }






  }
  Future<void> AddSpons(BuildContext context, String name, String web,String fb,String insta,String twit,String photo)async{

    if(photo == null){
      setState(() {
        up = "Please upload an Image";
        _colup = Colors.redAccent;
      });
    }else {
      try {
        var hey = await db.collection('Sponsors').add({

          'S_Name': name,
          'S_Web': web,
          'S_Insta': insta,
          'S_Twit': twit,
          'S_Logo': photo,
          'S_Fb':fb

        });

        String id = hey.documentID;
        await db.collection('Sponsors').document(id).updateData({

          'S_ID': id,

        });

        setState(() {
          _colupdate = Colors.green;
          update = "done";
        });
      } catch (e) {
        print(e);
        print("failed");
      }
    }


  }
  String _validator(String value) {

    if (value.length == 0)
      return 'This field is required';
    else
      return null;
  }
  String _UrlValidator(String value) {
    Pattern pattern =
    '^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)';
    RegExp regex = new RegExp(pattern);

    if (value.length != 0 && !regex.hasMatch(value))
      return 'Please insert a valid Url';
    else
      return null;
  }

}

