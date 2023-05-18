import 'package:flutter/material.dart';
import 'package:theteam_gyp/core/models/training_model.dart';
import 'package:theteam_gyp/user-interface/components/training_details_view.dart';
import 'package:theteam_gyp/user-interface/constans/app_constants.dart';

class ProductCard extends StatelessWidget {
  const ProductCard(
      {Key? key,
      this.imageAlignment = Alignment.bottomCenter,
      this.onTap,
      required this.data,
      required this.isLogged})
      : super(key: key);

  final Alignment imageAlignment;
  final Function(String)? onTap;
  final TrainingModel data;
  final bool isLogged;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(maxWidth: 300),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: GestureDetector(
          onTap: () {
            showDialog(
                context: context,
                builder: (context) {
                  return TrainingDetailsView(
                    isLogged: isLogged,
                    training: data,
                  );
                });
          },
          child: SizedBox(
            width: 150,
            child: Column(children: [
              Stack(
                alignment: AlignmentDirectional.bottomStart,
                children: [
                  SizedBox(
                      height: 200,
                      width: MediaQuery.of(context).size.width,
                      child: Image.network(data.image,
                          alignment: imageAlignment, fit: BoxFit.cover)),
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Text(" ON SALE SOON% ",
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.white, backgroundColor: Colors.red)),
                  )
                ],
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(data.categories.join(" - "),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodySmall),
                        Text(data.title,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            softWrap: false,
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                    Row(
                      children: [
                        Text('${data.price} DT',
                            maxLines: 1,
                            overflow: TextOverflow.clip,
                            softWrap: false,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.red)),
                        Row(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(' DT',
                                  maxLines: 1,
                                  overflow: TextOverflow.clip,
                                  softWrap: false,
                                  style: Theme.of(context).textTheme.bodySmall),
                            ),
                            // IconButton(onPressed: onPressed, icon: icon)
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
