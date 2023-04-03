import '../../../../components/user_crud_bottom_sheet_widget.dart';
import '../../../../components/web_nav_widget.dart';
import '../../../../flutter_utils/ff_icon_button.dart';
import '../../../../flutter_utils/ff_theme.dart';
import '../../../../flutter_utils/ff_util.dart';
import '../../../../flutter_utils/ff_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import './training_page_model.dart';

class ListTrainings extends StatefulWidget {
  const ListTrainings({Key? key}) : super(key: key);

  @override
  _ListTrainings createState() => _ListTrainings();
}

class _ListTrainings extends State<ListTrainings> {
  late TrainingPageModel _model;

  final scaffoldKey = GlobalKey<ScaffoldState>();
  final _unfocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _model = createModel(context, () => TrainingPageModel());

    _model.trainingTitleController ??= TextEditingController();
    _model.trainingDescriptionController ??= TextEditingController();
    _model.trainingAuthorController ??= TextEditingController();
    _model.trainingDurationController ??= TextEditingController();
    _model.trainingPriceController ??= TextEditingController();
    _model.trainingTrailerVidController ??= TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() {}));
  }

  @override
  void dispose() {
    _model.dispose();

    _unfocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                  '023' /* Trainings Management */,
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
                      child: Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
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
                                    color:
                                        FFTheme.of(context).primaryBackground,
                                  ),
                                ),
                              if (responsiveVisibility(
                                context: context,
                                phone: false,
                                tablet: false,
                                tabletLandscape: false,
                              ))
                                Text(
                                  FFLocalizations.of(context).getText(
                                    '023' /* Trainings Management */,
                                  ),
                                  style: FFTheme.of(context).title2,
                                ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 44, 0),
                                child: Text(
                                  FFLocalizations.of(context).getText(
                                    '024' /* Welcome to your company dashbo... */,
                                  ),
                                  style: FFTheme.of(context).bodyText2,
                                ),
                              ),
                              Align(
                                alignment: AlignmentDirectional(0, 0),
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      4, 16, 4, 16),
                                  child: Container(
                                    width: double.infinity,
                                    constraints: BoxConstraints(
                                      maxWidth: 1170,
                                    ),
                                    decoration: BoxDecoration(
                                      color: FFTheme.of(context)
                                          .secondaryBackground,
                                      boxShadow: [
                                        BoxShadow(
                                          blurRadius: 3,
                                          color: Color(0x33000000),
                                          offset: Offset(0, 1),
                                        )
                                      ],
                                      borderRadius: BorderRadius.circular(8),
                                      border: Border.all(
                                        color: FFTheme.of(context).lineColor,
                                      ),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          16, 16, 16, 16),
                                      child: Column(
                                        mainAxisSize: MainAxisSize.max,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.max,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                child: Column(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 0, 12, 0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '025' /* Trainings */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .title3,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsetsDirectional
                                                              .fromSTEB(
                                                                  0, 4, 12, 0),
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '026' /* Below are ... */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                              ))
                                                Padding(
                                                  padding: EdgeInsetsDirectional
                                                      .fromSTEB(0, 0, 16, 0),
                                                  child: Container(
                                                    width: 270,
                                                    child: TextFormField(
                                                      controller: _model
                                                          .trainingSearchController,
                                                      textCapitalization:
                                                          TextCapitalization
                                                              .sentences,
                                                      obscureText: false,
                                                      decoration:
                                                          InputDecoration(
                                                        isDense: true,
                                                        hintText:
                                                            FFLocalizations.of(
                                                                    context)
                                                                .getText(
                                                          '027' /* Search trainings... */,
                                                        ),
                                                        hintStyle:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                        enabledBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: FFTheme.of(
                                                                    context)
                                                                .primaryBackground,
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        errorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        focusedErrorBorder:
                                                            OutlineInputBorder(
                                                          borderSide:
                                                              BorderSide(
                                                            color: Color(
                                                                0x00000000),
                                                            width: 2,
                                                          ),
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(8),
                                                        ),
                                                        prefixIcon: Icon(
                                                          Icons.search_rounded,
                                                          color: FFTheme.of(
                                                                  context)
                                                              .secondaryText,
                                                          size: 20,
                                                        ),
                                                      ),
                                                      style: FFTheme.of(context)
                                                          .bodyText1,
                                                      // validator: _model
                                                      //     .textControllerValidator
                                                      //     .asValidator(context),
                                                    ),
                                                  ),
                                                ),
                                              if (responsiveVisibility(
                                                context: context,
                                                phone: false,
                                                tablet: false,
                                              ))
                                                FFButtonWidget(
                                                  onPressed: () {
                                                    print('Button pressed ...');
                                                  },
                                                  text: FFLocalizations.of(
                                                          context)
                                                      .getText(
                                                    '028' /* Create Training */,
                                                  ),
                                                  icon: Icon(
                                                    Icons.add_rounded,
                                                    size: 15,
                                                  ),
                                                  options: FFButtonOptions(
                                                    height: 40,
                                                    padding:
                                                        EdgeInsetsDirectional
                                                            .fromSTEB(
                                                                16, 0, 16, 0),
                                                    color: FFTheme.of(context)
                                                        .primaryColor,
                                                    textStyle:
                                                        FFTheme.of(context)
                                                            .subtitle2
                                                            .override(
                                                              fontFamily: FFTheme
                                                                      .of(context)
                                                                  .subtitle2Family,
                                                              color:
                                                                  Colors.white,
                                                              useGoogleFonts: GoogleFonts
                                                                      .asMap()
                                                                  .containsKey(
                                                                      FFTheme.of(
                                                                              context)
                                                                          .subtitle2Family),
                                                            ),
                                                    elevation: 3,
                                                    borderSide: BorderSide(
                                                      color: Colors.transparent,
                                                      width: 1,
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                ),
                                            ],
                                          ),
                                          Padding(
                                            padding:
                                                EdgeInsetsDirectional.fromSTEB(
                                                    0, 16, 0, 0),
                                            child: Container(
                                              width: double.infinity,
                                              height: 40,
                                              decoration: BoxDecoration(
                                                color: FFTheme.of(context)
                                                    .primaryBackground,
                                                borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(0),
                                                  bottomRight:
                                                      Radius.circular(0),
                                                  topLeft: Radius.circular(8),
                                                  topRight: Radius.circular(8),
                                                ),
                                              ),
                                              child: Padding(
                                                padding: EdgeInsetsDirectional
                                                    .fromSTEB(16, 0, 16, 0),
                                                child: Row(
                                                  mainAxisSize:
                                                      MainAxisSize.max,
                                                  children: [
                                                    /** Column 1 */
                                                    Expanded(
                                                      flex: 1,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'fofz8j2o' /* ID */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),

                                                    /** Column 2 */
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '029' /* Title */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),

                                                    /** Column 3 */
                                                    Expanded(
                                                      flex: 4,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '030' /* Author */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),

                                                    /** Column 4 */
                                                    Expanded(
                                                      flex: 3,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '31' /* Categories */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),

                                                    /** Column 8 */
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          '035' /* Date */,
                                                        ),
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),

                                                    /** Column 9 */
                                                    Expanded(
                                                      flex: 2,
                                                      child: Text(
                                                        FFLocalizations.of(
                                                                context)
                                                            .getText(
                                                          'w6sgvkjj' /* Actions */,
                                                        ),
                                                        textAlign:
                                                            TextAlign.end,
                                                        style:
                                                            FFTheme.of(context)
                                                                .bodyText2,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                          /**List view */
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
}
