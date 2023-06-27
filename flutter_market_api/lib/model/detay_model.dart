// To parse this JSON data, do
//
//     final detay = detayFromMap(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Detay detayFromMap(String str) => Detay.toJson(json.decode(str));

String detayToMap(Detay data) => json.encode(data.toMap());

class Detay {
    final int id;
    final String title;
    final double price;
    final String description;
    final String category;
    final String image;
    final Rating rating;

    Detay({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

    factory Detay.toJson(Map<String, dynamic> json) => Detay(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: json["category"],
        image: json["image"],
        rating: Rating.fromMap(json["rating"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": category,
        "image": image,
        "rating": rating.toMap(),
    };
}

class Rating {
    final double rate;
    final int count;

    Rating({
        required this.rate,
        required this.count,
    });

    factory Rating.fromMap(Map<String, dynamic> json) => Rating(
        rate: json["rate"]?.toDouble(),
        count: json["count"],
    );

    Map<String, dynamic> toMap() => {
        "rate": rate,
        "count": count,
    };
}
