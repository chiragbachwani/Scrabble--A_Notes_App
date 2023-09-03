import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.bold.size(18).color(Vx.gray800).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to exit?".text.size(16).color(Vx.gray800).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                color: Colors.blue,
                onPress: () {
                  SystemNavigator.pop();
                },
                textColor: Colors.white,
                title: "Yes"),
            customButton(
                color: Colors.blue,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                title: "No"),
          ],
        ),
      ],
    ).box.color(Vx.gray100).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}

Widget customButton({onPress, color, textColor, String? title, shape}) {
  return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: shape,
        backgroundColor: color,
        padding: const EdgeInsets.all(12),
      ),
      onPressed: onPress,
      child: title!.text.color(textColor).bold.make());
}

Widget deleteDialog(context,controller, currentNote) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        "Confirm".text.bold.size(18).color(Vx.gray800).make(),
        const Divider(),
        10.heightBox,
        "Are you sure you want to delete this Note?".text.size(16).color(Vx.gray800).make(),
        10.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            customButton(
                color: Colors.blue,
                onPress: () {
                  controller.deleteNote(currentNote);
                                                                            Get.back();
                },
                textColor: Colors.white,
                title: "Yes"),
            customButton(
                color: Colors.blue,
                onPress: () {
                  Navigator.pop(context);
                },
                textColor: Colors.white,
                title: "No"),
          ],
        ),
      ],
    ).box.color(Vx.gray100).padding(const EdgeInsets.all(12)).roundedSM.make(),
  );
}



