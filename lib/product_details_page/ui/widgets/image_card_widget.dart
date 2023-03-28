import 'package:flutter/material.dart';
import 'package:team_elearny/product_details_page/ui/widgets/image-card-widget/image_card.dart';

class ImageCardWidget extends StatelessWidget {

  final ImageProvider imgProv;
  final List<Widget> tgs;
  final String ttl;
  final String desc;

  const ImageCardWidget(
    {
      Key? key,
      required this.imgProv,
      required this.tgs,
      required this.ttl,required this.desc
    }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FillImageCard(
      width: 300,
      heightImage: 140,
      imageProvider: imgProv,
      tags: tgs,
      title: _title(),
      description: _content(),
      footer: Column(
        children: [
          ButtonBar(
            alignment: MainAxisAlignment.end,
            children: [
              ElevatedButton(
                child: Text("Open/Edit"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {},
              ),
              ElevatedButton(
                child: Text("Delete"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 0,
                ),
                onPressed: () {},
              ),
            ],
          )
        ],
      )
    );
  }

  Widget _title({Color? color}) {
    return Text(
      ttl,
      style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: color),
    );
  }

  Widget _content({Color? color}) {
    return Text(
      desc,
      style: TextStyle(color: color),
    );
  }
}
