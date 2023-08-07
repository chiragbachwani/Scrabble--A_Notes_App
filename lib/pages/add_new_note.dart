import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mindjot/const/colors.dart';
import 'package:mindjot/const/firebase_const.dart';
import 'package:mindjot/controller/notes_controller.dart';
import 'package:mindjot/models/note.dart';
import 'package:uuid/uuid.dart';
import 'package:velocity_x/velocity_x.dart';

class AddNewNotePage extends StatefulWidget {
  final bool isUpdate;
  final Note? note;
  const AddNewNotePage({super.key, required this.isUpdate, this.note});

  @override
  State<AddNewNotePage> createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewNotePage> {
  var controller = Get.find<NoteController>();
  TextEditingController titlecontroller = TextEditingController();

  TextEditingController contentcontroller = TextEditingController();
  FocusNode noteFocus = FocusNode();
  void addNewNote() {
    Note newNote = Note(
      nid: const Uuid().v1(),
      userid: currentuser!.uid,
      title: titlecontroller.text,
      content: contentcontroller.text,
      dateadded: DateTime.now(),
    );
    controller.addNote(newNote);
    Get.back();
  }

  void updateNote() {
    widget.note!.title = titlecontroller.text;
    widget.note!.content = contentcontroller.text;
    widget.note!.dateadded = DateTime.now();
    controller.updateNote(widget.note!);
    Get.back();
  }

  @override
  void initState() {
    super.initState();
    if (widget.isUpdate) {
      titlecontroller.text = widget.note!.title!;
      contentcontroller.text = widget.note!.content!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: blue.withOpacity(0.9),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.check,
              color: Colors.white,
            ),
            onPressed: () {
              if (widget.isUpdate) {
                //update
                updateNote();
              } else {
                addNewNote();
              }
            },
          )
        ],
        leading: IconButton(
          icon: const Icon(
            Icons.close,
            color: Colors.white,
          ),
          onPressed: () {
            Get.back();
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          height: context.screenHeight,
          width: context.screenWidth,
          color: Colors.yellow[50],
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
            child: Column(
              children: [
                TextField(
                  controller: titlecontroller,
                  onSubmitted: (val) {
                    if (val != "") {
                      noteFocus.requestFocus();
                    }
                  },
                  autofocus: (widget.isUpdate == true) ? false : true,
                  style: const TextStyle(
                      fontSize: 22, fontWeight: FontWeight.w600),
                  decoration: const InputDecoration(
                      hintText: "Title",
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none),
                ),
                Expanded(
                  child: TextField(
                    controller: contentcontroller,
                    focusNode: noteFocus,
                    maxLines: null,
                    style: const TextStyle(fontSize: 18),
                    decoration: const InputDecoration(
                        hintText: "Note",
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
