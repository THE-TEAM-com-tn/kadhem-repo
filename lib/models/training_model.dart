import 'package:cloud_firestore/cloud_firestore.dart';

class Training {
  String? id;
  String title;
  String description;
  List<String> category;
  String author;
  String duration;
  double price;
  String trailerVid;
  String image;
  List<String>? tags;
  Timestamp? creationDate;

  Training(
      {this.id,
      required this.title,
      required this.description,
      required this.category,
      required this.author,
      required this.duration,
      required this.price,
      required this.trailerVid,
      required this.image,
      this.tags,
      this.creationDate});

  factory Training.fromJson(Map<String, dynamic> map, String id) {
    return Training(
        id: id,
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        category: List<String>.from(map['category'] ?? ''),
        author: map['author'] ?? '',
        duration: map['duration'] ?? '',
        price: map['price'] ?? '',
        trailerVid: map['trailerVid'] ?? '',
        image: map['image'] ?? '',
        tags: List<String>.from(map['tags'] ?? ''),
        creationDate: map['creationDate'] ?? '');
  }

  toJson() {
    return {
      "title": title,
      "description": description,
      "category": category,
      "author": author,
      "duration": duration,
      "price": price,
      "trailerVid": trailerVid,
      "image": image,
      "tags": tags,
      "creationDate": creationDate
    };
  }
}
