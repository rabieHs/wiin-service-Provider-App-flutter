import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Future<List<File>> pickImages() async {
  List<File> images = [];
  try {
    var files = await ImagePicker.platform.pickMultiImage();
    if (files != null && files.isNotEmpty) {
      for (int i = 0; i < files.length; i++) {
        images.add(File(files[i].path));
      }
    }
  } catch (e) {
    debugPrint('error${e.toString()}');
  }
  return images;
}
