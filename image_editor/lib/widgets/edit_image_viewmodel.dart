import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_editor/models/text_info.dart';
import 'package:image_editor/screens/edit_image_screen.dart';
import 'package:image_editor/widgets/default_buttons.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';

import '../utils/utils.dart';

abstract class EditImageViewModel extends State<EditImageScreen> {
  List<TextInfo> texts = [];
  int currentIndex = 0;
  adNewText(BuildContext context) {
    setState(() {
      texts.add(TextInfo(
        text: textEditingController.text,
        left: 0,
        top: 0,
        color: Colors.black,
        fontWeight: FontWeight.normal,
        fontstyle: FontStyle.normal,
        fontSize: 20,
        textAlign: TextAlign.left,
      ));
      Navigator.of(context).pop();
    });
  }

  setCurrentIndex(BuildContext context, index) {
    setState(() {
      currentIndex = index;
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Select For Styling",
      style: TextStyle(fontSize: 16),
    )));
  }

  changeTextColor(Color color) {
    setState(() {
      texts[currentIndex].color = color;
    });
  }

  increaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize += 2;
    });
  }

  decreaseFontSize() {
    setState(() {
      texts[currentIndex].fontSize -= 2;
    });
  }

  alignLeft() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.left;
    });
  }

  alignCenter() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.center;
    });
  }

  alignRight() {
    setState(() {
      texts[currentIndex].textAlign = TextAlign.right;
    });
  }

  boldText() {
    setState(() {
      if (texts[currentIndex].fontWeight == FontWeight.bold) {
        texts[currentIndex].fontWeight = FontWeight.normal;
      } else {
        texts[currentIndex].fontWeight = FontWeight.bold;
      }
    });
  }

  italicText() {
    setState(() {
      if (texts[currentIndex].fontstyle == FontStyle.italic) {
        texts[currentIndex].fontstyle = FontStyle.normal;
      } else {
        texts[currentIndex].fontstyle = FontStyle.italic;
      }
    });
  }

  addLinesToText() {
    setState(() {
      if (texts[currentIndex].text.contains('\n')) {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll('\n', ' ');
      } else {
        texts[currentIndex].text =
            texts[currentIndex].text.replaceAll(' ', '\n');
      }
    });
  }

  removeText(BuildContext context) {
    setState(() {
      texts.removeAt(currentIndex);
    });
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
      "Deleted Successfully",
      style: TextStyle(fontSize: 16),
    )));
  }

  saveToGallery(BuildContext context) {
    if (texts.isNotEmpty) {
      screenshotController.capture().then((Uint8List? image) {
        saveImage(image!);
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Image save to gallery!')));
      }).catchError((error) => print(error));
    }
  }

  saveImage(Uint8List bytes) async {
    final time = DateTime.now()
        .toIso8601String()
        .replaceAll('.', '-')
        .replaceAll(':', '-');
    final name = "screenshot_$time";
    await requestPermission(Permission.storage);
    await ImageGallerySaver.saveImage(bytes, name: name);
  }

  TextEditingController textEditingController = TextEditingController();
  TextEditingController creatorText = TextEditingController();
  ScreenshotController screenshotController = ScreenshotController();
  addNewDialog(context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Add New Text"),
        content: TextField(
          controller: textEditingController,
          maxLines: 5,
          decoration: const InputDecoration(
              suffixIcon: Icon(Icons.edit),
              filled: true,
              hintText: 'Your Text Here...'),
        ),
        actions: [
          DefaultButton(
              color: Colors.white,
              textColor: Colors.black,
              onPress: () => Navigator.of(context).pop(),
              child: const Text("Back")),
          DefaultButton(
              color: Colors.red,
              textColor: Colors.white,
              onPress: () => adNewText(context),
              child: const Text("Add New Text"))
        ],
      ),
    );
  }
}
