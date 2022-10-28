import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_editor/widgets/edit_image_viewmodel.dart';
import 'package:image_editor/widgets/image_text.dart';
import 'package:screenshot/screenshot.dart';

class EditImageScreen extends StatefulWidget {
  const EditImageScreen({super.key, required this.selectImage});
  final String selectImage;

  @override
  State<EditImageScreen> createState() => _EditImageScreenState();
}

class _EditImageScreenState extends EditImageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar,
      body: Screenshot(
        controller: screenshotController,
        child: SafeArea(
            child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.7,
          child: Stack(children: [
            selectImage,
            //display all the text
            for (int i = 0; i < texts.length; i++)
              Positioned(
                left: texts[i].left,
                top: texts[i].top,
                child: GestureDetector(
                  onLongPress: () {
                    setState(() {
                      currentIndex = i;
                      removeText(context);
                    });
                  },
                  onTap: () => setCurrentIndex(context, i),
                  child: Draggable(
                    feedback: ImageText(textInfo: texts[i]),
                    child: ImageText(textInfo: texts[i]),
                    onDragEnd: (drag) {
                      final renderBox = context.findRenderObject() as RenderBox;
                      Offset off = renderBox.globalToLocal(drag.offset);
                      setState(() {
                        texts[i].top = off.dy - 96;
                        texts[i].left = off.dx;
                      });
                    },
                  ),
                ),
              ),
            creatorText.text.isNotEmpty
                ? Positioned(
                    left: 0,
                    bottom: 0,
                    child: Text(
                      creatorText.text,
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black.withOpacity(0.3)),
                    ),
                  )
                : const SizedBox.shrink()
          ]),
        )),
      ),
      floatingActionButton: addNewFAB,
    );
  }

  AppBar get _appbar {
    return AppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      title: SizedBox(
          height: 50,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              IconButton(
                onPressed: () => saveToGallery(context),
                icon: const Icon(Icons.save),
                color: Colors.black,
                tooltip: 'Save Image',
              ),
              IconButton(
                onPressed: increaseFontSize,
                icon: const Icon(Icons.add),
                color: Colors.black,
                tooltip: 'Increase Font Size',
              ),
              IconButton(
                onPressed: decreaseFontSize,
                icon: const Icon(Icons.remove),
                color: Colors.black,
                tooltip: 'Decrease Font Size',
              ),
              IconButton(
                onPressed: alignLeft,
                icon: const Icon(Icons.format_align_left),
                color: Colors.black,
                tooltip: 'Align Left',
              ),
              IconButton(
                onPressed: alignCenter,
                icon: const Icon(Icons.format_align_center),
                color: Colors.black,
                tooltip: 'Align Center',
              ),
              IconButton(
                onPressed: alignRight,
                icon: const Icon(Icons.format_align_right),
                color: Colors.black,
                tooltip: 'Align Right',
              ),
              IconButton(
                onPressed: boldText,
                icon: const Icon(Icons.format_bold),
                color: Colors.black,
                tooltip: 'Bold',
              ),
              IconButton(
                onPressed: italicText,
                icon: const Icon(Icons.format_italic),
                color: Colors.black,
                tooltip: 'Italic',
              ),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.space_bar),
                color: Colors.black,
                tooltip: 'Add New Line',
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Red',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.red),
                  child: const CircleAvatar(
                    backgroundColor: Colors.red,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'White',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.white),
                  child: const CircleAvatar(
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              Tooltip(
                message: 'Black',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.black),
                  child: const CircleAvatar(
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Orange',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.orange),
                  child: const CircleAvatar(
                    backgroundColor: Colors.orange,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Yellow',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.yellow),
                  child: const CircleAvatar(
                    backgroundColor: Colors.yellow,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Pink',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.pink),
                  child: const CircleAvatar(
                    backgroundColor: Colors.pink,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Blue',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.blue),
                  child: const CircleAvatar(
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              const SizedBox(width: 5),
              Tooltip(
                message: 'Green',
                child: GestureDetector(
                  onTap: () => changeTextColor(Colors.green),
                  child: const CircleAvatar(
                    backgroundColor: Colors.green,
                  ),
                ),
              ),
              const SizedBox(width: 5),
            ],
          )),
    );
  }

  Widget get selectImage {
    return Image.file(
      File(widget.selectImage),
      fit: BoxFit.fill,
      width: MediaQuery.of(context).size.width,
    );
  }

  Widget get addNewFAB {
    return FloatingActionButton(
      onPressed: () => addNewDialog(context),
      backgroundColor: Colors.white,
      tooltip: 'Add New Text',
      child: const Icon(Icons.edit, color: Colors.black),
    );
  }
}
