import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Fans/MasterFan.dart';
import 'Player/MaserPlayer.dart';
import 'admin/AdminStack.dart';
import 'signup.dart';

import 'forgetpassword.dart';

import 'app_colors.dart';



class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}


class _LoginState extends State<Login> {
  @override
  initState()  {
    super.initState();
    Check();
  }

  Check()async {
    final FirebaseUser user = await FirebaseAuth.instance.currentUser();
    if(user != null){
      DocumentSnapshot snapshot = await db.collection('Players')
          .document(user.uid)
          .get();
      DocumentSnapshot snapshot2 = await db.collection('Fans')
          .document(user.uid)
          .get();

      if (snapshot.exists) {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => Master(id: user.uid)
        ));
      }else if(snapshot2.exists){
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => MasterFan(id: user.uid)
        ));
      }
    }

  }
  final MailController = TextEditingController();
  final PasswordController = TextEditingController();
  final _formKeyLog = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: AppColors.darkGrey,
            body: Container(
              height: MediaQuery.of(context).size.height,

              padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              child: Form(
                key: _formKeyLog,
                child : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                  Hero(
                  tag: 'hero',
                    child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 70.0,
                      child:
                      Image.asset('assets/logocanes2.png',fit: BoxFit.cover),

                  ),

                ),
                    SizedBox(
                      height: 20,
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
                      height: 16,
                    ),
                    Container(

                      child:TextFormField(
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
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        if (_formKeyLog.currentState.validate()) {
                          _formKeyLog.currentState.save();
                          VerifyUser(context, MailController.text.trim(),PasswordController.text.trim());
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
                            'Login',
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
                      height: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .push(MaterialPageRoute(builder: (_) => ForgotPassword()));
                      },
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "Forgot Password?",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                              textStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal)),
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
                        text: 'Don\'t have an account? ',
                        style: GoogleFonts.poppins(
                            textStyle: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                                fontWeight: FontWeight.normal)),
                        children: [
                          TextSpan(
                            text: 'Sign up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () => Navigator.of(context).push(
                                  MaterialPageRoute(builder: (context) => SignUp())),
                            style: GoogleFonts.poppins(
                                textStyle: TextStyle(
                                    color: Colors.white, fontWeight: FontWeight.w600)),
                          )
                        ]))
                  ],
                ),
              ),
            )
        ));


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
  Future<void> VerifyUser(BuildContext context, String mail,String mdp)async{


    try {
      final FirebaseUser user = (
          await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: mail,
            password: mdp,)).user;

      if (user != null) {


        DocumentSnapshot snapshot2 = await db.collection('Players').document(user.uid).get();
        DocumentSnapshot snapshot3 = await db.collection('Fans').document(user.uid).get();

        if(snapshot2.exists) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => Master(id : user.uid)),
          );
        }else if(snapshot3.exists) {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => MasterFan(id : user.uid)),
          );
        }

      }
    } catch(e){
      print("erreuur");
    }
  }
}
