import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String title;
  final String image;
  final double price;
  final int quantity;
  const CartItem({
    required this.title,
    required this.image,
    required this.price,
    required this.quantity,
  });
  CartItem copyWith({
    String? title,
    String? image,
    double? price,
    int? quantity,
  }) {
    return CartItem(
      title: title ?? this.title,
      image: image ?? this.image,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
    );
  }
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() {
    return [];
  }

  void addToCart({
    required String title,
    required String image,
    required double price,
  }) {
    final index = state.indexWhere((item) => item.title == title);
    if (index == -1) {
      state = [
        ...state,
        CartItem(title: title, image: image, price: price, quantity: 1),
      ];
    } else {
      final updated = [...state];
      updated[index] = updated[index].copyWith(
        quantity: updated[index].quantity + 1,
      );
      state = updated;
    }
  }

  void removeFromCart(String title) {
    final index = state.indexWhere((item) => item.title == title);
    if (index == -1) return;

    final item = state[index];
    if (item.quantity > 1) {
      final updated = [...state];
      updated[index] = item.copyWith(quantity: item.quantity - 1);
      state = updated;
    } else {
      state = state.where((item) => item.title != title).toList();
    }
  }

  void clearCart() {
    state = [];
  }

  double get totalPrice {
    return state.fold(0, (sum, item) => sum + item.price * item.quantity);
  }

  double get totalItems {
    return state.fold(0, (sum, item) => sum + item.quantity);
  }
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(
  CartNotifier.new,
);
