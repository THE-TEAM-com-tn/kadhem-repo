import '../components/web_nav_widget.dart';
import '../flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class HomePageModel extends FFModel {
  ///  State fields for stateful widgets in this page.

  // Model for webNav component.
  late WebNavModel webNavModel;
  // State field(s) for TextField widget.
  TextEditingController? textController;
  String? Function(BuildContext, String?)? textControllerValidator;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    webNavModel = createModel(context, () => WebNavModel());
  }

  void dispose() {
    webNavModel.dispose();
    textController?.dispose();
  }

  /// Additional helper methods are added here.

}
