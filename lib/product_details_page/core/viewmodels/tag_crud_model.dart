// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import '../models/tag_model.dart';
import '../../core/services/tag_api.dart';
import '../../locator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class TagCRUDModel extends ChangeNotifier {
  final TagAPI _api = locator<TagAPI>();

  late List<Tag> tags;

  Future<List<Tag>> fetchTags() async {
    var result = await _api.getDataCollection();
    tags = result.docs
    .map((doc) => Tag.fromJson(doc.data as Map<String, dynamic>, doc.id))
    .toList();
    return tags;
  }

  Stream<QuerySnapshot<Object?>> fetchTagsAsStream() {
    return _api.streamDataCollection();
  }

  Future removeTag(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future updateTag(Tag data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }

  Future addTag(Tag data) async {
    var result = await _api.addDocument(data.toJson());
    return;
  }
}
