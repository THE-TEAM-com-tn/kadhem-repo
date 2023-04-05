// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:team_elearny/flutter_utils/ff_icon_button.dart';
import 'package:team_elearny/flutter_utils/ff_theme.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/trainings_management_section/ui/views/trainings/modify_training_page.dart';
import '../../core/models/training_model.dart';

class TrainingRow extends StatelessWidget {
  final Training training;
  const TrainingRow({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return /** List of Trainings */
        Padding(
      padding: EdgeInsetsDirectional.fromSTEB(0, 0, 0, 1),
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          color: FFTheme.of(context).secondaryBackground,
          boxShadow: [
            BoxShadow(
              blurRadius: 0,
              color: FFTheme.of(context).primaryBackground,
              offset: Offset(0, 1),
            )
          ],
        ),
        child: Padding(
          padding: EdgeInsetsDirectional.fromSTEB(16, 0, 16, 0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              if (responsiveVisibility(
                context: context,
                phone: false,
                tablet: false,
              ))
                Expanded(
                  flex: 1,
                  child: Text(
                    FFLocalizations.of(context).getText(
                      '1jefet9s' /* #2424 */,
                    ),
                    style: FFTheme.of(context).bodyText1,
                  ),
                ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: EdgeInsetsDirectional.fromSTEB(0, 8, 12, 8),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: Image.network(
                            /** Training Image */
                            training.image,
                            width: 32,
                            height: 32,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(4, 0, 0, 0),
                          child: Column(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                training.author /* Training Author */,
                                style: FFTheme.of(context).bodyText1.override(
                                      fontFamily:
                                          FFTheme.of(context).bodyText1Family,
                                      fontWeight: FontWeight.bold,
                                      useGoogleFonts: GoogleFonts.asMap()
                                          .containsKey(FFTheme.of(context)
                                              .bodyText1Family),
                                    ),
                              ),
                              Padding(
                                padding:
                                    EdgeInsetsDirectional.fromSTEB(0, 4, 0, 0),
                                child: Text(
                                  'Authors Email',
                                  /** Author's email */
                                  style: FFTheme.of(context).bodyText2.override(
                                        fontFamily:
                                            FFTheme.of(context).bodyText2Family,
                                        color: FFTheme.of(context).primaryColor,
                                        useGoogleFonts: GoogleFonts.asMap()
                                            .containsKey(FFTheme.of(context)
                                                .bodyText2Family),
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                Expanded(
                  flex: 2,
                  child: Text(
                    training.creationDate.toString() /* Training's date */,
                    style: FFTheme.of(context).bodyText1,
                  ),
                ),
              Expanded(
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    if (responsiveVisibility(
                      context: context,
                      phone: false,
                      tablet: false,
                      tabletLandscape: false,
                    ))
                      Container(
                        height: 32,
                        decoration: BoxDecoration(
                          color: FFTheme.of(context).primaryBackground,
                          borderRadius: BorderRadius.circular(40),
                        ),
                        alignment: AlignmentDirectional(0, 0),
                        child: Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(12, 0, 12, 0),
                          child: Text(
                            training.category
                                .join(" - ") /* Training Category */,
                            style: FFTheme.of(context).bodyText1,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
              if (responsiveVisibility(
                context: context,
                phone: false,
              ))
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      if (responsiveVisibility(
                        context: context,
                        phone: false,
                        tablet: false,
                      ))
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(0, 0, 8, 0),
                          child: FFIconButton(
                            borderColor: Colors.transparent,
                            borderRadius: 30,
                            borderWidth: 1,
                            buttonSize: 44,
                            icon: Icon(
                              Icons.edit_outlined,
                              color: FFTheme.of(context).secondaryText,
                              size: 20,
                            ),
                            onPressed: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          ModifyTraining(training: training)));
                            },
                          ),
                        ),
                      FFIconButton(
                        borderColor: Colors.transparent,
                        borderRadius: 30,
                        borderWidth: 1,
                        buttonSize: 44,
                        icon: Icon(
                          Icons.more_vert,
                          color: FFTheme.of(context).secondaryText,
                          size: 20,
                        ),
                        onPressed: () {
                          print('IconButton pressed ...');
                        },
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );

    /** End of list */
  }
}
