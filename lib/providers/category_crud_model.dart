// ignore_for_file: unused_local_variable

import 'dart:async';
import 'package:flutter/material.dart';
import '../../locator.dart';
import '../models/category_model.dart';
import '../services/category_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CategoryCRUDModel extends ChangeNotifier {
  final CategoryAPI _api = locator<CategoryAPI>();

  late List<TrainingCategory> categories;

  Future<List<TrainingCategory>> fetchcategories() async {
    var result = await _api.getDataCollection();
    categories = result.docs
        .map((doc) => TrainingCategory.fromJson(doc.data as Map<String, dynamic>, doc.id))
        .toList();
    return categories;
  }

  Stream<QuerySnapshot<Object?>> fetchCategoriesAsStream() {
    return _api.streamDataCollection();
  }

  Future removeCategory(String id) async {
    await _api.removeDocument(id);
    return;
  }

  Future addCategory(TrainingCategory data) async {
    var result = await _api.addDocument(data.toJson());
    return;
  }

  Future updateCategory(TrainingCategory data, String id) async {
    await _api.updateDocument(data.toJson(), id);
    return;
  }


}
