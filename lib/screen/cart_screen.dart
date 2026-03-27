import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grabber/provider/cart.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifer = ref.read(cartProvider.notifier);
    return Scaffold(
      appBar: AppBar(title: Text("Cart", style: GoogleFonts.inter())),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your Cart is Empty"))
          : Animate(
              effects: [SlideEffect()],
              child: Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartItems.length,
                      itemBuilder: (context, index) {
                        final item = cartItems[index];
                        return ListTile(
                          leading: Image.asset(
                            item.image,
                            width: 50,
                            height: 50,
                          ),
                          title: Text(item.title, style: GoogleFonts.inter()),
                          subtitle: Text(
                            '\$${item.price} * ${item.quantity}',
                            style: GoogleFonts.inter(),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                onPressed: () {
                                  cartNotifer.removeFromCart(item.title);
                                },
                                icon: Icon(Icons.remove_circle_outline),
                              ),
                              Text(
                                item.quantity.toString(),
                                style: GoogleFonts.inter(),
                              ),
                              IconButton(
                                onPressed: () {
                                  cartNotifer.addToCart(
                                    title: item.title,
                                    image: item.image,
                                    price: item.price,
                                  );
                                },
                                icon: Icon(Icons.add_circle_outline),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      'Total: \$${cartNotifer.totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
