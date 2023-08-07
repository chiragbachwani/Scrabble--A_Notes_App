import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mindjot/pages/homepage.dart';
import 'package:mindjot/services/google_signin.dart';
import 'package:velocity_x/velocity_x.dart';

import '../custom/exitdialog.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        showDialog(
            barrierDismissible: false,
            context: context,
            builder: (context) => exitDialog(context));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue.withOpacity(0.9),
          title: Text(
            "Scrabble",
            style: GoogleFonts.deliciousHandrawn(
                fontSize: 30, color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "SignIn",
                style: GoogleFonts.deliciousHandrawn(
                    fontSize: 40, color: Colors.blue),
              ),
              30.heightBox,
              Image.asset(
                "assets/google.png",
                width: 50,
              ).onTap(() async {
                signInWithGoogle(context, () {
                  Get.offAll(() => HomePage());
                });
              }),
              40.heightBox,
            ],
          ),
        ),
      ),
    );
  }
}
