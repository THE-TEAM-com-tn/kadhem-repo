import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_card/image_card.dart';
import 'package:team_elearny/flutter_utils/ff_theme.dart';
import 'package:team_elearny/flutter_utils/ff_util.dart';
import 'package:team_elearny/flutter_utils/ff_widgets.dart';
import 'package:team_elearny/trainings_management_section/core/models/training_model.dart';
import 'package:team_elearny/trainings_management_section/ui/views/trainings/modify_training_page.dart';

class ImageCardWidget extends StatelessWidget {
  final Training training;

  const ImageCardWidget({Key? key, required this.training}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: FillImageCard(
            width: MediaQuery.of(context).size.width * 0.3,
            height: MediaQuery.of(context).size.height * 0.5,
            heightImage: MediaQuery.of(context).size.height * 0.25,
            imageProvider: NetworkImage(training.image),
            tags: training.tags!.map((label) => _tag(context, label)).toList(),
            title: Text(
              training.title,
              style: FFTheme.of(context).title1,
            ),
            description: Text(
              "${training.category.join(" - ")}",
              style: FFTheme.of(context).title3,
            ),
            footer: Column(
              children: [
                ButtonBar(
                  alignment: MainAxisAlignment.end,
                  children: [
                    FFButtonWidget(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) =>
                                      ModifyTraining(training: training)));
                        },
                        text: FFLocalizations.of(context).getText(
                          '019' /* Open/Edit */,
                        ),
                        options: FFButtonOptions(
                          width: 130.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FFTheme.of(context).primaryBackground,
                          textStyle: FFTheme.of(context).bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: FFTheme.of(context).primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FFTheme.of(context).bodyText1Family),
                              ),
                          elevation: 1.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        )),
                    FFButtonWidget(
                        onPressed: () {},
                        text: FFLocalizations.of(context).getText(
                          '020' /* Delete */,
                        ),
                        options: FFButtonOptions(
                          width: 130.0,
                          height: 40.0,
                          padding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          iconPadding: EdgeInsetsDirectional.fromSTEB(
                              0.0, 0.0, 0.0, 0.0),
                          color: FFTheme.of(context).primaryBackground,
                          textStyle: FFTheme.of(context).bodyText1.override(
                                fontFamily: 'Lexend Deca',
                                color: FFTheme.of(context).primaryColor,
                                fontSize: 14.0,
                                fontWeight: FontWeight.normal,
                                useGoogleFonts: GoogleFonts.asMap().containsKey(
                                    FFTheme.of(context).bodyText1Family),
                              ),
                          elevation: 1.0,
                          borderSide: BorderSide(
                            color: Colors.transparent,
                            width: 1.0,
                          ),
                        )),
                  ],
                )
              ],
            )),
      ),
    );
  }

  Widget _tag(BuildContext context, String label) {
    return InkWell(
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6), color: Colors.green),
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
        child: Text(
          label,
          style: FFTheme.of(context).bodyText1,
        ),
      ),
    );
  }
}
