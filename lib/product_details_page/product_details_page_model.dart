import '../components/expandable_detail_component_widget.dart';
import '../components/web_nav_widget.dart';
import '../flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';

class ProductDetailsPageModel extends FFModel {
  ///  State fields for stateful widgets in this page.

  // Model for webNav component.
  late WebNavModel webNavModel;
  // Model for expandable_detail_component component.
  late ExpandableDetailComponentModel expandableDetailComponentModel;
  // State field(s) for CountController widget.
  int? countControllerValue;

  /// Initialization and disposal methods.

  void initState(BuildContext context) {
    webNavModel = createModel(context, () => WebNavModel());
    expandableDetailComponentModel =
        createModel(context, () => ExpandableDetailComponentModel());
  }

  void dispose() {
    webNavModel.dispose();
    expandableDetailComponentModel.dispose();
  }

  /// Additional helper methods are added here.

}
