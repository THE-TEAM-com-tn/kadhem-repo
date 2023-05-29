import 'package:flutter/material.dart';
import 'package:octo_image/octo_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:theteam_gyp/admin-interface/trainings/components/training_edit_pop.dart';
import 'package:theteam_gyp/admin-interface/trainings/trainings_controller.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/constans/mycolors.dart';

class AdminTrainingCard extends StatelessWidget {
  final TrainingModel training;

  AdminTrainingCard({Key? key, required this.training}) : super(key: key);

  TrainingsController controller = TrainingsController();

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
        child: Container(
            decoration: BoxDecoration(
              color: MyColors.secondaryBackground,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 3,
                  color: Color(0x411D2429),
                  offset: Offset(0, 1),
                )
              ],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(5, 1, 1, 1),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
                        child: OctoImage(
                          placeholderBuilder: OctoPlaceholder.blurHash(
                            'LKN^h]x^^lxHxGWVX5Rj~qMx9Fba',
                          ),
                          image: NetworkImage(training.image),
                          width: MediaQuery.of(context).size.width < 600
                              ? 80
                              : 339,
                          height: MediaQuery.of(context).size.width < 600
                              ? 80
                              : 378,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding:
                            const EdgeInsetsDirectional.fromSTEB(8, 8, 4, 0),
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${training.title}',
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Roboto',
                                color: Colors.black87,
                              ),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              softWrap: true,
                            ),
                            const SizedBox(height: 5),
                            Padding(
                              padding: const EdgeInsetsDirectional.fromSTEB(
                                  0, 4, 8, 0),
                              child: AutoSizeText(
                                'Author: ${training.author}' ??
                                    'Training Author',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[700],
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 20.0,
                              alignment: WrapAlignment.start,
                              children: [
                                ChoiceChip(
                                  label: Text(
                                    '${training.price.toStringAsFixed(2)} TND' ??
                                        '??? TND',
                                    //'Option 1',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  avatar:
                                      null /* const Icon(Icons.access_alarms_outlined , size: 15)*/,
                                  selectedColor: MyColors.mygreenMoney,
                                  labelStyle: const TextStyle(
                                    color: MyColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: MyColors.accent4,
                                  selected: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Wrap(
                              spacing: 20.0,
                              alignment: WrapAlignment.start,
                              children: [
                                ChoiceChip(
                                  label: Text(
                                    training.duration ?? '1 hour',
                                    //'Option 1',
                                    style: const TextStyle(color: Colors.black),
                                  ),
                                  avatar: const Icon(
                                      Icons.access_alarms_outlined,
                                      size: 15),
                                  selectedColor: MyColors.mypurple,
                                  labelStyle: const TextStyle(
                                    color: MyColors.primaryText,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  backgroundColor: MyColors.accent4,
                                  selected: true,
                                ),
                              ],
                            ),
                            const SizedBox(height: 15),
                          ],
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.trash,
                                color: MyColors.error,
                                size: 15,
                              ),
                              onPressed: () async {
                                final confirmed = await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Delete'),
                                      content: const Text(
                                          'Are you sure you want to delete this training?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            controller.deleteDocumentById(
                                                "trainings", training.id!);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('YES'),
                                        ),
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.of(context).pop(),
                                          child: const Text('NO'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.pen,
                                color: MyColors.success,
                                size: 15,
                              ),
                              onPressed: () async {
                                await showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return TrainingEditPop(
                                        training: training,
                                      );
                                    });
                              },
                            ),
                            IconButton(
                              icon: const FaIcon(
                                FontAwesomeIcons.solidEye,
                                color: MyColors.primary,
                                size: 15,
                              ),
                              onPressed: () async {},
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            )));
  }
}
