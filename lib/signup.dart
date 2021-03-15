import 'package:canes_app/Fans/MasterFan.dart';
import 'package:canes_app/app_colors.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'AddDetailsPlayer.dart';
import 'LoginScreen.dart';


class SignUp extends StatefulWidget {
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _formKeySign = GlobalKey<FormState>();
  final MailController = TextEditingController();
  final FirstNameController = TextEditingController();
  final LastNameController = TextEditingController();
  final PasswordController = TextEditingController();
  String SelectedType;
  List<String> UserType = [
     "Player" ,"Fan"
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: Container(
              height: MediaQuery.of(context).size.height,
              color: AppColors.darkGrey,
              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Form(
                key: _formKeySign,
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Create an Account',
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.w700)),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(

                      child: TextFormField(
                        validator: _MdpValidator,
                        controller: FirstNameController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white70)),
                          hintText: "First Name",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(

                      child: TextFormField(
                        validator: _MdpValidator,
                        controller: LastNameController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.person_outline,
                            color: Colors.white,
                          ),
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white70)),
                          hintText: "Last Name",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Container(

                      child: TextFormField(
                        validator: _MailValidator,
                        controller: MailController,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: Colors.white,
                          ),
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white70)),
                          hintText: "Email",
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                     TextFormField(
                        validator: _MdpValidator,
                        controller: PasswordController,
                        obscureText: true,
                        cursorColor: Colors.white,
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(color: Colors.white)),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(14),
                          border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.white,
                          ),
                          hintStyle: GoogleFonts.poppins(
                              textStyle: TextStyle(color: Colors.white70)),
                          hintText: "Password",
                        ),
                      ),
                    SizedBox(
                      height: 10,
                    ),

                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(14),
                        border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)),
                            borderSide: BorderSide(color: AppColors.amberCanes)),
                        hintStyle:
                        GoogleFonts.poppins(textStyle: TextStyle(color: Colors.white)),
                        hintText: "User Type",
                        prefixIcon: Icon(
                          Icons.person_outline,
                          color: Colors.white,
                        ),
                      ),

                      value: SelectedType,
                      onChanged: (String Value) {
                        setState(() {
                          SelectedType = Value;
                        });
                      },
                      items: UserType.map((String user) {
                        return  DropdownMenuItem<String>(
                          value: user,
                          child:
                          Text(
                            user,
                            style:  TextStyle(color: AppColors.amberCanes),
                          ),

                        );
                      }).toList(),
                    ),

                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKeySign.currentState.validate()) {
                          _formKeySign.currentState.save();
                          VerifyUser(context, MailController.text.trim(), PasswordController.text.trim(), SelectedType);
                        }


                      },
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        decoration: BoxDecoration(
                            color: AppColors.amberCanes,
                            borderRadius: BorderRadius.all(Radius.circular(12))),
                        child: Center(
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600)),
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      height: 32,
                    ),
                    Container(height: 1, width: double.infinity, color: Colors.white30),
                    SizedBox(
                      height: 16,
                    ),
                    Text.rich(TextSpan(
                        text: 'Already have an account? ',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        children: [
                          TextSpan(
                            text: 'Login',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => Login())),
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600)),
                          )
                        ]))
                  ],
                ),
              ),
            )));
  }
  String _MailValidator(String value) {
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    if (!regex.hasMatch(value))
      return 'Please insert a valid mail adress';
    else
      return null;
  }

  String _MdpValidator(String value) {

    if (value.length == 0)
      return 'This field is required';
    else
      return null;
  }
  final db = Firestore.instance;
  Future<void> VerifyUser(BuildContext context, String mail, String mdp, String type)async{


    try {
      final FirebaseUser user = (
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: mail,
            password: mdp,)).user;

      if (user != null) {

     if (type == "Player"){
    await db.collection('Players').document(user.uid).setData({
    'First_Name': FirstNameController.text.trim(),
    'Last_Name': LastNameController.text.trim(),
    'email': MailController.text.trim(),
    'userID': user.uid,
      'Role': 0,
    });
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) => AddDetailsPlayer(id : user.uid)),
    );
    }else if (type == "Fan"){
    await db.collection('Fans').document(user.uid).setData({
    'First_Name': FirstNameController.text.trim(),
    'Last_Name': LastNameController.text.trim(),
    'email': MailController.text.trim(),
    'userID': user.uid,

    });
    Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => MasterFan(id : user.uid)),
    );
    }



        print("done");
      }
    } catch(e){
      print(e);
      print("failed");

    }
  }
}