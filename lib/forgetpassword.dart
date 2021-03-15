import 'package:canes_app/service/auth_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'LoginScreen.dart';
import 'app_colors.dart';

class ForgotPassword extends StatefulWidget {
  final authService = AuthService();
  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

final MailController = TextEditingController();

class _ForgotPasswordState extends State<ForgotPassword> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: AppColors.darkGrey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(horizontal: 32.0, vertical: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Hero(
              tag: 'hero',
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 70.0,
                child: Image.asset('assets/logocanes2.png', fit: BoxFit.cover),
              ),
            ),
            Text(
              'Forgot Password',
              textAlign: TextAlign.center,
              style: GoogleFonts.poppins(
                  textStyle: TextStyle(
                      color: Colors.white,
                      fontSize: 28.0,
                      fontWeight: FontWeight.w700)),
            ),
            SizedBox(height: 32.0),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  border: Border.all(color: Colors.white)),
              child: TextField(
                controller: MailController,
                cursorColor: Colors.white,
                style: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white)),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.mail_outline, color: Colors.white),
                  hintStyle: GoogleFonts.poppins(
                    textStyle: TextStyle(color: Colors.white70),
                  ),
                  hintText: "Email",
                ),
              ),
            ),
            SizedBox(
              height: 16.0,
            ),
            GestureDetector(
              onTap: () {
                ResetPassword(context, MailController.text.trim());
              },
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                    color: AppColors.amberCanes,
                    borderRadius: BorderRadius.all(Radius.circular(12))),
                child: Center(
                  child: Text(
                    'Reset Password',
                    style: GoogleFonts.poppins(
                        textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600)),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  // ignore: non_constant_identifier_names
  Future<void> ResetPassword(BuildContext context, String mail) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: mail);
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Login()));
    } catch (e) {
      print('ERROR: $e');
    }
  }
}
