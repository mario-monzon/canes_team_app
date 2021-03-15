
import 'package:canes_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Admins extends StatefulWidget {
  static String tag = 'Admins-page';
  @override
  _AdminsState createState() => new _AdminsState();

}

class _AdminsState extends State<Admins> with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 1, vsync: this);

  }
  final db = Firestore.instance;

  @override
  Widget build(BuildContext context) {


    return SingleChildScrollView(
        child:  Column(
          children: [
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
                          text: 'All Fans',

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
                    AdminsPage(title: "Admins",),





                  ]


              ),



            ),
          ],
        )



    );






  }


}

class AdminsPage extends StatefulWidget {
  AdminsPage({Key key, this.title}) : super(key: key);
  final String title;
  static String tag = 'AdminsPage-page';

  @override
  _AdminsPageState createState() => new _AdminsPageState();
}

class _AdminsPageState extends State<AdminsPage>  {
  final db = Firestore.instance;

  int hey  = 0;
  Card buildItem(DocumentSnapshot doc) {

    return Card(
      color: Colors.white,
      child: Center(

        child:

        Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              SizedBox(height: 5,),
              Text(
                'Name : ${doc.data['First_Name'] }  ',
                style: TextStyle(fontSize: 15),
              ),
              SizedBox(height: 3,),
              Text(
                'Email Adress: ${doc.data['email']}',
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

                ],
              ),

              SizedBox(height: 5,),



            ]),





      ),
    );


  }


  void DeleteUser(String id) async {
    Widget okButton = FlatButton(
      child: Text("YES " , style: TextStyle(color: AppColors.darkGrey),),
      onPressed: () async {

        // FirebaseUser = await FirebaseAuth.instance.ge
        await db.collection("Fans").document(id).delete()
            .catchError((e) {
          print(e);
        });

        Navigator.of(context).pop();

      },

    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("  Delete"),
      content: Text("Do you really want to delete this user ?"),
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
            stream: db.collection("Fans").snapshots(),
            builder: (context, snapshot) {

              if (snapshot.hasData) {

                return Column(children: snapshot.data.documents.map((doc) => buildItem(doc)).toList());
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

