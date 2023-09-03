import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:mindjot/const/colors.dart';
import 'package:mindjot/controller/notes_controller.dart';
import 'package:mindjot/models/note.dart';
import 'package:mindjot/pages/add_new_note.dart';
import 'package:mindjot/pages/login_page.dart';
import 'package:mindjot/pages/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import '../const/firebase_const.dart';
import '../custom/exitdialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();

class _HomePageState extends State<HomePage> {
  var controller = Get.put(NoteController());
  String searchQuery = "";

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
        floatingActionButton: FloatingActionButton(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
          backgroundColor: blue.withOpacity(0.9),
          onPressed: () {
            Get.to(
                () => const AddNewNotePage(
                      isUpdate: false,
                    ),
                transition: Transition.downToUp);
          },
          child: const Icon(
            Icons.edit,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          backgroundColor: blue.withOpacity(0.9),
          title: Text(
            "Scrabble",
            style: GoogleFonts.deliciousHandrawn(
                color: Colors.white, fontSize: 32),
          ),
          centerTitle: true,
          actions: [
            TextButton(
                onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  _googleSignIn.signOut();
                  auth.authStateChanges().listen((User? user) {
                    if (user == null && mounted) {
                      Get.offAll(() => const LoginPage());
                    } else {
                      Get.offAll(() => const HomePage());
                    }
                  });
                },
                child: Text(
                  "Log Out",
                  style: GoogleFonts.deliciousHandrawn(
                      color: Colors.white, fontSize: 20),
                ))
          ],
        ),
        body: Obx(
          () => controller.isLoading.value == false
              ? Obx(
                  () => SafeArea(
                      child: controller.notes.value.length > 0
                          ? Obx(
                              () => ListView(
                                children: [
                                  5.heightBox,
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: TextFormField(
                                      onChanged: (val) {
                                        setState(() {
                                          searchQuery = val;
                                        });
                                      },
                                      // controller: controller.searchController,
                                      cursorColor: Colors.blue.withOpacity(0.9),
                                      decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 1.0,
                                                  horizontal: 20.0),
                                          border: OutlineInputBorder(
                                            borderSide: BorderSide.none,
                                            borderRadius:
                                                BorderRadius.circular(25),
                                          ),
                                          prefixIcon: Icon(Icons.search),
                                          filled: true,
                                          fillColor: Vx.gray200,
                                          hintText: "Search",
                                          hintStyle: const TextStyle(
                                              color: Vx.gray500)),
                                    ),
                                  ),
                                  (controller
                                              .getFilteredNoted(searchQuery)
                                              .length >
                                          0)
                                      ? GridView.builder(
                                          physics:
                                              const NeverScrollableScrollPhysics(),
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2),
                                          itemCount: controller
                                              .getFilteredNoted(searchQuery)
                                              .length,
                                          itemBuilder: (context, index) {
                                            Note currentNote =
                                                controller.getFilteredNoted(
                                                    searchQuery)[index];
                                            return GestureDetector(
                                              onTap: () {
                                                //update
                                                Get.to(() => AddNewNotePage(
                                                      isUpdate: true,
                                                      note: currentNote,
                                                    ));
                                              },
                                              onLongPress: () {
                                                //delete
                                                showDialog(
                                                    barrierDismissible: false,
                                                    context: context,
                                                    builder: (context) =>
                                                        deleteDialog(
                                                            context,
                                                            controller,
                                                            currentNote));
                                              },
                                              child: Container(
                                                padding:
                                                    const EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    color: Colors.yellow[50],
                                                    border: Border.all(
                                                        color: Colors.yellow),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12)),
                                                margin: const EdgeInsets.all(5),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      currentNote.title!,
                                                      maxLines: 1,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .deliciousHandrawn(
                                                              fontSize: 25),
                                                    ),
                                                    Divider(
                                                      thickness: 0.8,
                                                      color: Colors.blue
                                                          .withOpacity(0.5),
                                                    ),
                                                    Text(
                                                      currentNote.content!,
                                                      maxLines: 5,
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: GoogleFonts
                                                          .deliciousHandrawn(
                                                              fontSize: 16,
                                                              color:
                                                                  Vx.gray500),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            );
                                          })
                                      : Padding(
                                          padding: EdgeInsets.all(20),
                                          child: Text(
                                            "No Notes Found!",
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                ],
                              ),
                            )
                          : Center(
                              child: Text(
                              "No Notes to show ...",
                              style:
                                  GoogleFonts.deliciousHandrawn(fontSize: 20),
                            ))),
                )
              : Center(
                  child: Image.asset(
                    'assets/loading.gif',
                    width: 60,
                  ),
                ),
        ),
      ),
    );
  }
}
