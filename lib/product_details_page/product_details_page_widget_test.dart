import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/firebase_options.dart';
import 'package:team_elearny/product_details_page/core/models/training_model.dart';
import 'package:team_elearny/product_details_page/core/viewmodels/training_crud_model.dart';
import 'package:team_elearny/product_details_page/core/viewmodels/category_crud_model.dart';
import 'package:team_elearny/product_details_page/core/viewmodels/tag_crud_model.dart';
import '../flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';
import 'product_details_page_model.dart';
export 'product_details_page_model.dart';

import 'ui/router/app_router_config.dart';
import 'locator.dart';

class ProductDetailsPageWidgetTest extends StatefulWidget {
  const ProductDetailsPageWidgetTest({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageWidgetStateTest createState() =>
      _ProductDetailsPageWidgetStateTest();
}

class _ProductDetailsPageWidgetStateTest
    extends State<ProductDetailsPageWidgetTest> with TickerProviderStateMixin {
  late ProductDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  void trainInit() {
    Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    setupLocator();
  }

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailsPageModel());
    trainInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  late List<Training> trainings;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => locator<TrainingCRUDModel>()),
          ChangeNotifierProvider(create: (_) => locator<CategoryCRUDModel>()),
          ChangeNotifierProvider(create: (_) => locator<TagCRUDModel>())
        ],
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser:
              NyAppRouter.returnRouter().routeInformationParser,
          routerDelegate: NyAppRouter.returnRouter().routerDelegate,
        ));
  }
}
