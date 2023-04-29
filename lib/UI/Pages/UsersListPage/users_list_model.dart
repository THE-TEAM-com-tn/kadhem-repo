import 'package:flutter/material.dart';


class UsersListModel   {


  bool isMediaUploading = false;
  // State field(s) for yourName widget.
  TextEditingController? searchController;


  String?  SearchValidator(String? value) {
  }

  /// Initialization and disposal methods.

  void initState(BuildContext context) {

  }

  void dispose() {
    searchController?.dispose();

  }


  /// Additional helper methods are added here.

}
