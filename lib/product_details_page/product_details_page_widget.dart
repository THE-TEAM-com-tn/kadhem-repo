import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';
import 'package:team_elearny/product_details_page/core/models/training_model.dart';
import 'package:team_elearny/product_details_page/core/viewmodels/training_crud_model.dart';
import '../components/web_nav_widget.dart';
import '../flutter_utils/ff_theme.dart';
import '../flutter_utils/ff_util.dart';
import 'package:flutter/material.dart';
import 'product_details_page_model.dart';
export 'product_details_page_model.dart';
import 'package:team_elearny/product_details_page/ui/widgets/image_card_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import '../flutter_utils/ff_widgets.dart';

class ProductDetailsPageWidget extends StatefulWidget {
  const ProductDetailsPageWidget({Key? key}) : super(key: key);

  @override
  _ProductDetailsPageWidgetState createState() =>
      _ProductDetailsPageWidgetState();
}

class _ProductDetailsPageWidgetState extends State<ProductDetailsPageWidget>
    with TickerProviderStateMixin {
  late ProductDetailsPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => ProductDetailsPageModel());

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
    final trainingProvider = Provider.of<TrainingCRUDModel>(context);

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: FFTheme.of(context).primaryBackground,
      appBar: responsiveVisibility(
        context: context,
        desktop: false,
      )
          ? AppBar(
              backgroundColor: FFTheme.of(context).primaryBackground,
              automaticallyImplyLeading: false,
              title: Text(
                FFLocalizations.of(context).getText(
                  '0xkir2p8' /* My Team */,
                ),
                style: FFTheme.of(context).title1,
              ),
              actions: [],
              centerTitle: false,
              elevation: 0,
            )
          : null,
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(_unfocusNode),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              wrapWithModel(
                model: _model.webNavModel,
                updateCallback: () => setState(() {}),
                child: WebNavWidget(
                  selectedPage: 2,
                ),
              ),
              Expanded(
                child: Align(
                  alignment: AlignmentDirectional(0, -1),
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    constraints: BoxConstraints(
                      maxWidth: 1170,
                    ),
                    decoration: BoxDecoration(
                      color: FFTheme.of(context).primaryBackground,
                    ),
                    alignment: AlignmentDirectional(0, 0),
                    child: Align(
                      alignment: AlignmentDirectional(0, -1),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Align(
                            alignment: AlignmentDirectional(0, -1),
                            child: Padding(
                              padding:
                                  EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                              child: SingleChildScrollView(
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (responsiveVisibility(
                                      context: context,
                                      phone: false,
                                      tablet: false,
                                    ))
                                      Container(
                                        width: 200,
                                        height: 32,
                                        decoration: BoxDecoration(
                                          color: FFTheme.of(context)
                                              .primaryBackground,
                                        ),
                                      ),
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        if (responsiveVisibility(
                                          context: context,
                                          phone: false,
                                          tablet: false,
                                          tabletLandscape: false,
                                        ))
                                          Text(
                                            FFLocalizations.of(context).getText(
                                              'xboikvmh' /* Available Trainings */,
                                            ),
                                            style: FFTheme.of(context).title2,
                                          ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: StreamBuilder(
                                stream:
                                    trainingProvider.fetchTrainingsAsStream(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (snapshot.hasData) {
                                    trainings = snapshot.data!.docs
                                        .map((doc) => Training.fromJson(
                                            doc.data() as Map<String, dynamic>,
                                            doc.id))
                                        .toList();
                                    return GridView.count(
                                      crossAxisCount:
                                          3, // number of items per row
                                      children: List.generate(trainings.length,
                                          (index) {
                                        return ImageCardWidget(
                                            imgProv: NetworkImage(
                                                trainings[index].image),
                                            tgs: trainings[index]
                                                .tags!
                                                .map((tag) {
                                              return _tag(tag, () {
                                                print("Am here");
                                              });
                                            }).toList(),
                                            ttl: trainings[index].title,
                                            desc: trainings[index].description);
                                      }),
                                    );
                                  } else {
                                    return const Text('fetching');
                                  }
                                }),
                          ),
                          Padding(
                            padding:
                                EdgeInsetsDirectional.fromSTEB(0, 20, 10, 0),
                            child: Column(
                              children: [
                                FFButtonWidget(
                                  onPressed: () async {
                                    context.pushNamed('ListTrainings');
                                  },
                                  text: FFLocalizations.of(context).getText(
                                    'ss6c31v1' /* Trainings Management */,
                                  ),
                                  options: FFButtonOptions(
                                    width: 180,
                                    height: 40,
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    iconPadding: EdgeInsetsDirectional.fromSTEB(
                                        0, 0, 0, 0),
                                    color: FFTheme.of(context).primaryColor,
                                    textStyle: FFTheme.of(context)
                                        .subtitle2
                                        .override(
                                          fontFamily: FFTheme.of(context)
                                              .subtitle2Family,
                                          color: Colors.white,
                                          useGoogleFonts: GoogleFonts.asMap()
                                              .containsKey(FFTheme.of(context)
                                                  .subtitle2Family),
                                        ),
                                    borderSide: BorderSide(
                                      color: Colors.transparent,
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _tag(String label, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
