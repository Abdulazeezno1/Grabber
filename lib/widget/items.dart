// import 'package:flutter/material.dart';

class Items {
  Items({required this.title, required this.image});
  final String image;
  final String title;
}

final categories = [
  Items(title: "Fruits", image: "assets/images/fruits.png"),
  Items(title: "Milk & egg", image: "assets/images/milk.png"),
  Items(title: "Beverages", image: "assets/images/beverages.png"),
  Items(title: "Laundry", image: "assets/images/laundry.png"),
  Items(title: "Vegetable", image: "assets/images/vegetable.png"),

  // Items(image: , title: "Fruits"),
];
