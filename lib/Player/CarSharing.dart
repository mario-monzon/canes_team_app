
import 'package:canes_app/app_colors.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class CarSharing extends StatefulWidget {
  CarSharing({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'CarSharing-page';
  @override
  _CarSharingState createState() => new _CarSharingState();

}

class _CarSharingState extends State<CarSharing> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
        child:  Column(
          children: [
            SizedBox(height: 20,),
            Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                decoration: BoxDecoration(
                    color: AppColors.amberCanes,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Center(
                  child: TabBar(
                      controller: _tabController,
                      indicatorColor: Colors.white,
                      labelColor:  Colors.white,
                      isScrollable: true,
                      labelPadding: EdgeInsets.only(right: 20.0, left: 20.0),
                      unselectedLabelColor: AppColors.darkGrey,
                      tabs: [
                        Tab(
                          text: 'Available Offers',

                        ),

                        Tab(

                          text: 'My Offers',


                        ),

                        Tab(

                          text: 'Add Offer',


                        ),





                      ]),
                )
            ),

            Container(
              height: MediaQuery.of(context).size.height,
              width: double.infinity,
              color: AppColors.darkGrey,


              child: TabBarView(
                  controller: _tabController,
                  children: [
                    AllOffersPage(title: widget.title,),
                    MyOffersPage(title: widget.title,),
                    AddOffer(title: widget.title,)



                  ]


              ),



            ),
          ],
        )


    );






  }


}

class AllOffersPage extends StatefulWidget {
  AllOffersPage({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'AllOffersPage-page';

  @override
  _AllOffersPageState createState() => new _AllOffersPageState();
}

class _AllOffersPageState extends State<AllOffersPage>  {
  final db = Firestore.instance;
  final DateTime now = DateTime.now();
  String booki = "Book";

   buildItem(DocumentSnapshot doc) {

     DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc.data['Date'] + " "+doc.data['Time']);

  if(int.parse(doc.data['S_Available'])-doc.data['S_Booked']>0 && now.isBefore(tempDate)) {
    return StreamBuilder(
        stream: Firestore.instance.collection('Players').document(
            doc.data['user']).snapshots(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            return Column(
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
                            child: snapshot.data['Photo'] == null ?
                            Image.network(
                              "https://cdn.icon-icons.com/icons2/510/PNG/512/person_icon-icons.com_50075.png",
                              fit: BoxFit.cover,
                            ):

                            Image.network(
                              snapshot.data['Photo'],
                              fit: BoxFit.cover,
                            )),
                      ),
                      SizedBox(width: 8),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            snapshot.data['First_Name'] ,
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: AppColors.amberCanes,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600)),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Date ',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                children: [
                                  TextSpan(
                                    text: doc.data['Date'],
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: AppColors.amberCanes,
                                            fontWeight:
                                            FontWeight.w400)),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Time : ',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                children: [
                                  TextSpan(
                                    text: doc.data['Time'],
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: AppColors.amberCanes,
                                            fontWeight:
                                            FontWeight.w400)),
                                  ),
                                ]),
                          ),
                          RichText(
                            text: TextSpan(
                                text: 'Available Seats : ',
                                style: GoogleFonts.poppins(
                                    textStyle: TextStyle(
                                        color: Colors.white,
                                        fontSize: 14,
                                        fontWeight: FontWeight.w400)),
                                children: [
                                  TextSpan(
                                    text: (int.parse(doc.data['S_Available']) -
                                        doc.data['S_Booked']).toString(),
                                    style: GoogleFonts.poppins(
                                        textStyle: TextStyle(
                                            color: AppColors.amberCanes,
                                            fontWeight:
                                            FontWeight.w400)),
                                  ),
                                ]),
                          ),


                        ],
                      ),
                      SizedBox(width: 20,),

                      doc.data['user']==widget.title?
                          SizedBox():
                      GestureDetector(
                        onTap: () {
          var userQuery =db.collection("CarSharing").document(doc.data['Offer_ID']).collection("Booking").where('ID_Player', isEqualTo: widget.title).limit(1);

          userQuery.getDocuments().then((data) async {
          if (data.documents.length == 0){
          BookOffer(
          doc.data['Offer_ID'], doc.data['S_Booked'],
          snapshot.data['First_Name']);
          }else{
            setState(() {
              booki = "Already ! ";
            });
            print("si");
          }
          });
          },

                            

                        child: Center(
                          child: Text(
                            booki,
                            maxLines: 2,
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
                  ),
                ),
                SizedBox(height: 8)
              ],
            );
          } else {
            return SizedBox();
          }
        });
  }else{
    return SizedBox();
  }





     /* Card(
      color: Colors.white,
      child: Center(

        child:

        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 5,),
              Text(
                'Player Name : ${doc.data['user'] }  ',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 3,),
              Text(
                'Available Seats : ' + (int.parse(doc.data['S_Available'])-doc.data['S_Booked']).toString(),
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center, //Center Row contents horizontally,
                crossAxisAlignment: CrossAxisAlignment.center, //Center Row contents vertically,
                children: [
                  FlatButton.icon(

                    onPressed:()=>DeleteUser(doc.data['userID']),
                    icon: Icon(Icons.delete_forever,color: Colors.white),
                    label: Text("Delete User", style: TextStyle(color: Colors.white),),
                    color: AppColors.amberCanes,
                  ),
                  SizedBox(width: 3,),
                  FlatButton.icon(

                    onPressed:()=>ChangeUser(doc),
                    icon: Icon(Icons.update,color: Colors.white),
                    label: Text("Change Role", style: TextStyle(color: Colors.white),),
                    color: AppColors.amberCanes,
                  ),
                ],
              ),

              SizedBox(height: 5,),



            ]),





      ),
    );*/


  }


  void BookOffer(String id, int b, String name) async {
    Widget okButton = FlatButton(
      child: Text("YES " , style: TextStyle(color: AppColors.darkGrey),),
      onPressed: () async {




        await db.collection("CarSharing").document(id).updateData(
            {
              'S_Booked': b+1,
            }
        );

        await db.collection("CarSharing").document(id).collection("Booking").add(
          {
            'ID_Player' : widget.title,
          }
        )
            .catchError((e) {
          print(e);
        });

        setState(() {
          booki = "Booked";
        });

        Navigator.of(context).pop();

      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("  Book a seat with " + name),
      content: Text("Do you really want to book this seat ?"),
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

  @override
  Widget build(BuildContext context) {





    return   Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[



          StreamBuilder<QuerySnapshot>(
            stream: db.collection("CarSharing").snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {

                return Column(children: snapshot.data.documents.map<Widget>((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox(height : 200);
              }
            },
          ),



        ],
      ),


    );
  }

}

class MyOffersPage extends StatefulWidget {
  MyOffersPage({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'MyOffersPage-page';

  @override
  _MyOffersPageState createState() => new _MyOffersPageState();
}

class _MyOffersPageState extends State<MyOffersPage>  {
  final db = Firestore.instance;

  final DateTime now = DateTime.now();

  buildItemy(DocumentSnapshot doc) {


      return
               Container(
                 width: MediaQuery.of(context).size.width,
                  padding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),

                  child:

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 8),
                   StreamBuilder(
                   stream: Firestore.instance.collection('Players').document(
                   doc.data['ID_Player']).snapshots(),
    builder: (BuildContext context, AsyncSnapshot snapshot) {

      if (snapshot.data == null) {
        return RichText(
          text: TextSpan(
              text: 'Name : ',
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w400)),
              children: [
                TextSpan(
                  text:

                  snapshot.data['First_Name'] + " "+snapshot.data['Last_Name'],
                  style: GoogleFonts.poppins(
                      textStyle: TextStyle(
                          color: AppColors.amberCanes,
                          fontWeight:
                          FontWeight.w400)),
                ),
              ]),
        );
      }else{
        return SizedBox();
      }
    }),



                        ],
                      )

              );



  }
  buildItem(DocumentSnapshot doc) {
    DateTime tempDate = new DateFormat("yyyy-MM-dd hh:mm:ss").parse(doc.data['Date'] + " "+doc.data['Time']);


    if(doc.data['user'] == widget.title && now.isBefore(tempDate)) {
      return StreamBuilder(
          stream: Firestore.instance.collection('Players').document(
              doc.data['user']).snapshots(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              return Container(
                  padding:
                  EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
            color: AppColors.amberCanes.withOpacity(0.1),
            borderRadius:
            BorderRadius.all(Radius.circular(12))),
            child:
                ExpansionTile(
                  title: Row(
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
                              child: snapshot.data['Photo'] == null ?
                              Image.network(
                                "https://cdn.icon-icons.com/icons2/510/PNG/512/person_icon-icons.com_50075.png",
                                fit: BoxFit.cover,
                              ):

                              Image.network(
                                snapshot.data['Photo'],
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
                              snapshot.data['First_Name'] + " " + snapshot
                                  .data['Last_Name'],
                              style: GoogleFonts.poppins(
                                  textStyle: TextStyle(
                                      color: AppColors.amberCanes,
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600)),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Date ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  children: [
                                    TextSpan(
                                      text: doc.data['Date'],
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: AppColors.amberCanes,
                                              fontWeight:
                                              FontWeight.w400)),
                                    ),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Time : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  children: [
                                    TextSpan(
                                      text: doc.data['Time'],
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: AppColors.amberCanes,
                                              fontWeight:
                                              FontWeight.w400)),
                                    ),
                                  ]),
                            ),
                            RichText(
                              text: TextSpan(
                                  text: 'Available Seats : ',
                                  style: GoogleFonts.poppins(
                                      textStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 14,
                                          fontWeight: FontWeight.w400)),
                                  children: [
                                    TextSpan(
                                      text: (int.parse(doc.data['S_Available']) -
                                          doc.data['S_Booked']).toString(),
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

                  children: [

                     Column(

                          children: <Widget>[

                            StreamBuilder<QuerySnapshot>(
                              stream: db.collection("CarSharing").document(doc.data['Offer_ID']).collection("Booking").snapshots(),
                              builder: (context, snapshot) {

                                if (snapshot.hasData) {



                                  return Column(children: snapshot.data.documents.map<Widget>((doc) => buildItemy(doc)).toList());
                                } else {
                                  return SizedBox(
                                    height: 30,
                                    child: Text(
                                      "No one Booked Yet",
                                      style: GoogleFonts.poppins(
                                          textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.w600)),
                                    ),
                                  );
                                }
                              },
                            ),



                          ],
                        ),


                  ]

                )

                );
            } else {
              return SizedBox();
            }
          });

    }else{
      return SizedBox();
    }




  }




  @override
  Widget build(BuildContext context) {





    return   Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: ListView(
        padding: EdgeInsets.all(10),
        children: <Widget>[



          StreamBuilder<QuerySnapshot>(
            stream: db.collection("CarSharing").snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {

                return Column(children: snapshot.data.documents.map<Widget>((doc) => buildItem(doc)).toList());
              } else {
                return SizedBox(height : 200);
              }
            },
          ),



        ],
      ),


    );
  }

}

class AddOffer extends StatefulWidget {
  AddOffer({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'AddOffer-page';

  @override
  _AddOfferState createState() => new _AddOfferState();
}

class _AddOfferState extends State<AddOffer>  {
  final db = Firestore.instance;

  TextEditingController Snumbercontroller = TextEditingController();
  TextEditingController Placecontroller = TextEditingController();
  TextEditingController datecontroller = TextEditingController();
  TextEditingController timecontroller = TextEditingController();



  final _formOffer = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {





    return    Container(
        color: AppColors.darkGrey,
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            child: Form(
              key:_formOffer ,
              child:   Column(

                children: [


                  SizedBox(height: 50),
                  TextFormField(
                    validator: _validator,
                    controller: Snumbercontroller,
                    keyboardType: TextInputType.number,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Number of available seats",
                    ),
                  ),
                  SizedBox(height: 8),
                  TextFormField(
                    validator: _validator,
                    controller: Placecontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),

                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Meet Place",
                    ),
                  ),
                  SizedBox(height: 8),

                  TextFormField(
                    validator: _validator,
                    controller: datecontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          _selectDate(context);
                        },
                        child: Icon(
                          Icons.calendar_today,
                          color: Colors.white,
                        ),
                      ),
                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Tap to pick a date",
                    ),
                  ),
                  SizedBox(height: 8),

                  TextFormField(
                    validator: _validator,
                    controller: timecontroller,
                    cursorColor: AppColors.amberCanes,
                    style: GoogleFonts.poppins(textStyle: TextStyle(color: AppColors.amberCanes)),
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                          borderSide: BorderSide(color: AppColors.amberCanes)),
                      suffixIcon: GestureDetector(
                        onTap: (){
                          _selectTime(context);
                        },
                        child: Icon(
                          Icons.timelapse,
                          color: Colors.white,
                        ),
                      ),
                      hintStyle:
                      GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                      hintText: "Tap to pick a time",
                    ),
                  ),
                  SizedBox(height: 15),

                  GestureDetector(
                    onTap: (){
                      if (_formOffer.currentState.validate()) {
                        _formOffer.currentState.save();
                        AddOffery(context, Snumbercontroller.text.trim() ,Placecontroller.text.trim(),datecontroller.text.trim(),_time,widget.title);

                      }
                    },
                    child: Container(
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                          color:  AppColors.amberCanes,
                          borderRadius: BorderRadius.all(
                              Radius.circular(12))),
                      child: Center(
                        child: Text(
                          msg,
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


        );


  }
  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();
  String msg = "Add Offer";

  TimeOfDay selectedTime = TimeOfDay(hour: 00, minute: 00);



  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime(2015),
        lastDate: DateTime(2101));
    if (picked != null)
      setState(() {
        selectedDate = picked;

        datecontroller.text = DateFormat("yyyy-MM-dd").format(selectedDate);

      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ':' + _minute + ':' + "00";
        timecontroller.text = _time;
        print(selectedTime);
        timecontroller.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }
  String _validator(String value) {

    if (value.length == 0)
      return 'This field is required';
    else
      return null;
  }
  Future<void> AddOffery(BuildContext context, String Snumber, String place,String date, String time, String user)async{


    try {

      var hey =  await db.collection('CarSharing').add({

        'Place': place,
        'S_Available' : Snumber,
        'S_Booked' : 0,
        'Date': date,
        'Time' : time,
        'user': user


      });

      String id = hey.documentID;
      await db.collection('CarSharing').document(id).updateData({

        'Offer_ID': id,

      });

      Snumbercontroller.clear();
      Placecontroller.clear();
      datecontroller.clear();
      timecontroller.clear();
      setState(() {
        msg ="Offer published";
      });

    } catch(e){
      print(e);
      print("failed");
    }




  }
}

