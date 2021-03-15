
import 'package:canes_app/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_fonts/google_fonts.dart';

class Users extends StatefulWidget {

  String Role;
  String id;
  Users({  this.Role, this.id});
  static String tag = 'Users-page';
  @override
  _UsersState createState() => new _UsersState();

}

class _UsersState extends State<Users> with SingleTickerProviderStateMixin {
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
                        text: 'Executives',

                      ),

                      Tab(

                        text: 'Players',


                      ),

                      Tab(

                        text: 'Admins',


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
                  UsersPage(title: "2", Role: widget.Role, id : widget.id),
                  UsersPage(title: "0", Role: widget.Role, id : widget.id),
                  UsersPage(title: "1", Role: widget.Role, id : widget.id),
                  //UsersPage(title: "Fans",)



                ]


            ),



          ),
        ],
      )


    );






  }


}

class UsersPage extends StatefulWidget {
  UsersPage({Key key, this.title, this.Role, this.id}) : super(key: key);
  final String title;
  final String Role;
  final String id;
  static String tag = 'UsersPage-page';

  @override
  _UsersPageState createState() => new _UsersPageState();
}

class _UsersPageState extends State<UsersPage>  {
  final db = Firestore.instance;

  int hey  = 0;
  Card buildItem(DocumentSnapshot doc) {

   if( doc.data['Role'].toString() == widget.title && doc.data['userID'] != widget.id) {
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
               widget.Role == "1"?
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 //Center Row contents horizontally,
                 crossAxisAlignment: CrossAxisAlignment.center,
                 //Center Row contents vertically,
                 children: [
                   FlatButton.icon(

                     onPressed: () => DeleteUser(doc.data['userID']),
                     icon: Icon(Icons.delete_forever, color: Colors.white),
                     label: Text(
                       "Delete User", style: TextStyle(color: Colors.white),),
                     color: AppColors.amberCanes,
                   ),
                   SizedBox(width: 3,),
                   FlatButton.icon(

                     onPressed: () => ChangeUser(doc),
                     icon: Icon(Icons.update, color: Colors.white),
                     label: Text(
                       "Change Role", style: TextStyle(color: Colors.white),),
                     color: AppColors.amberCanes,
                   ),
                 ],
               ):

               SizedBox(),

               SizedBox(height: 5,),
             ]),


       ),
     );
   }
  else{
    return Card();
   }

  }

  void ChangeUser(DocumentSnapshot doc) async {




    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context){

        return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius:
                BorderRadius.circular(20.0)),
            child : SingleChildScrollView(//this right here
              child: Container(

                child: Padding(
                  padding: const EdgeInsets.all(10.0),

                  child:  new MyDialogContent(title: widget.title,id: doc.data['userID'], first: doc.data['First_Name'],last : doc.data['Last_Name'], email: doc.data['email'],),

                ),
              ),
            )
        );




      },
    );


  }
  void DeleteUser(String id) async {
    Widget okButton = FlatButton(
      child: Text("YES " , style: TextStyle(color: AppColors.darkGrey),),
      onPressed: () async {

   await db.collection("CarSharing").where('user', isEqualTo: id).getDocuments().then((snapshot) {
     for (DocumentSnapshot ds in snapshot.documents){
       ds.reference.delete();
       print("done");
     }});


        await db.collection("Players").document(id).delete()
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
            stream: db.collection("Players").snapshots(),
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

class MyDialogContent extends StatefulWidget {
  MyDialogContent({Key key, this.title, this.id, this.first, this.email, this.last}) : super(key: key);
  final String title;
  final String id, first, last , email;
  @override
  _MyDialogContentState createState() => new _MyDialogContentState();
}

class _MyDialogContentState extends State<MyDialogContent> {


  int group ;
  @override
  void initState() {
    super.initState();
    group = null;
  }



  final db = Firestore.instance;
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Column(
            children: <Widget>[
              RadioListTile(
                title: const Text('Executive'),
                value: 2,
                groupValue: group,
                onChanged: ( value) {
                  setState(() {
                    group = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Player'),
                value: 0,
                groupValue: group,
                onChanged: ( value) {
                  setState(() {
                    print(value);
                    group = value;
                  });
                },
              ),
              RadioListTile(
                title: const Text('Admin'),
                value: 1,
                groupValue: group,
                onChanged: ( value) {
                  setState(() {
                    group = value;
                  });
                },
              ),

      FlatButton(
        child: Text("Update" , style: TextStyle(color: AppColors.darkGrey),),
        onPressed: () async {

          if(!(group.toString() == widget.title)){

    await db.collection("Players").document(widget.id).updateData({

    'Role': group ,

    });


    print("done");
    Navigator.of(context).pop();

          }else{
            Navigator.of(context).pop();
          }



        },

      ),

            ],
          ),



      ),




    );
  }
}