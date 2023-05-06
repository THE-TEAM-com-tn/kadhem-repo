// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/tag_model.dart';
import '../services/tag_api.dart';

class TagCRUDModel extends ChangeNotifier {
  final TagAPI _api = locator<TagAPI>();

  late List<Tag> tags;
  List<Tag> allTags = [] ;
  bool loadingTags = true ; 

  Future<List<Tag>> fetchTags() async {
    var result = await _api.getDataCollection();
    tags = result.docs
        .map((doc) => Tag.fromJson(doc.data as Map<String, dynamic>, doc.id))
        .toList();
    notifyListeners();
    return tags;
  }

  Stream<QuerySnapshot<Object?>> fetchTagsAsStream() {
    return _api.streamDataCollection();
  }

  Future removeTag(String id) async {
    await _api.removeDocument(id);
    notifyListeners();
    return;
  }

  Future updateTag(Tag data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    loadingTags = true ; 
    notifyListeners();
    return;
  }

  Future addTag(Tag data) async {
    var result = await _api.addDocument(data.toJson());
    notifyListeners();
    return;
  }
    getAllCTags() async {
    allTags = await _api.getAllTags();
    loadingTags = false ; 
    notifyListeners();
  }
}
