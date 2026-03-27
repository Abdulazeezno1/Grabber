class Fruits {
  Fruits({required this.title, required this.image, required this.price});
  final String image;
  final String title;
  final double price;
}

final fruits = [
  Fruits(title: "Banana", image: "assets/images/banana.png", price: 3.99),
  Fruits(title: "Pepper", image: "assets/images/pepper.png", price: 2.99),
  Fruits(title: "Orange", image: "assets/images/orange.png", price: 4.99),

  // Items(image: , title: "Fruits"),
];
