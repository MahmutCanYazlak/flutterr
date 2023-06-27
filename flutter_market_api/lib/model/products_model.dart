// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final products = productsFromMap(jsonString);

import 'dart:convert';

import 'package:meta/meta.dart';

List<Products> productsFromMap(String str) => List<Products>.from(json.decode(str).map((x) => Products.fromMap(x)));

String productsToMap(List<Products> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class Products {
    final int id;
    final String title;
    final double price;
    final String description;
    final Category category;
    final String image;
    final Rating rating;

    Products({
        required this.id,
        required this.title,
        required this.price,
        required this.description,
        required this.category,
        required this.image,
        required this.rating,
    });

    factory Products.fromMap(Map<String, dynamic> json) => Products(
        id: json["id"],
        title: json["title"],
        price: json["price"]?.toDouble(),
        description: json["description"],
        category: categoryValues.map[json["category"]]!,
        image: json["image"],
        rating: Rating.fromMap(json["rating"]),
    );

    Map<String, dynamic> toMap() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "category": categoryValues.reverse[category],
        "image": image,
        "rating": rating.toMap(),
    };
}

enum Category { MEN_S_CLOTHING, JEWELERY, ELECTRONICS, WOMEN_S_CLOTHING }

final categoryValues = EnumValues({
    "electronics": Category.ELECTRONICS,
    "jewelery": Category.JEWELERY,
    "men's clothing": Category.MEN_S_CLOTHING,
    "women's clothing": Category.WOMEN_S_CLOTHING
});

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

  @override
  String toString() => 'Rating(rate: $rate, count: $count)';
}

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
        reverseMap = map.map((k, v) => MapEntry(v, k));
        return reverseMap;
    }
}
