import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FilePickerWidget extends StatefulWidget {
  const FilePickerWidget({Key? key}) : super(key: key);

  @override
  _FilePickerWidgetState createState() => _FilePickerWidgetState();
}

class _FilePickerWidgetState extends State<FilePickerWidget> {
  List<File>? files;
  pickFiles() async {
    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      this.files = result.paths.map((path) => File(path ?? "")).toList();
      if (files?.isNotEmpty ?? false) {
        setState(() {});
      }
    } else {
      // User canceled the picker
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => pickFiles(),
                  child: Container(
                    child: Text("Pick File to upload"),
                  ),
                ),
              ],
            ),
            Column(
              children: files?.map((e) {
                    var parts = e.path.split(".");
                    if (parts.length > 0) {
                      var extension=parts[parts.length - 1];
                      if(extension.toLowerCase()=="jpeg"||
                      extension.toLowerCase()=="jpg"||
                      extension.toLowerCase()=="jpng"
                      ){
                        return Image.file(
                          
                          e.absolute,width: 200,height: 200,);
                      }
                    }

                    return Text(e.path);
                  }).toList() ??
                  [],
            )
          ],
        ),
      ),
    );
  }
}
