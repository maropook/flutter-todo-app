import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class AddBookModel extends ChangeNotifier {
  String? title;
  String? author;
  File? imageFile;

  final picker = ImagePicker();
  Future addBook() async {
    if (title == null || title == "") {
      throw '本のタイトルが空です';
    }
    if (author == null || author == "") {
      throw '著者が入力されていません';
    }

    await FirebaseFirestore.instance.collection('books').add({
      'title': title,
      'author': author,
    });
  }

  Future pickImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imageFile = File(pickedFile.path);
    }
  }
}
