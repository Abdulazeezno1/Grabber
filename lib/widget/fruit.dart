import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grabber/provider/cart.dart';
import 'package:grabber/widget/fruits.dart';

class Fruit extends ConsumerStatefulWidget {
  const Fruit({super.key});

  @override
  ConsumerState<Fruit> createState() => _FruitState();
}

class _FruitState extends ConsumerState<Fruit> {
  @override
  Widget build(BuildContext context) {
    final cartItems = ref.watch(cartProvider);
    final cartNotifer = ref.read(cartProvider.notifier);
    return ListView.separated(
      separatorBuilder: (context, index) {
        return SizedBox(width: 20);
      },
      itemCount: fruits.length,
      scrollDirection: Axis.horizontal,
      physics: AlwaysScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return SizedBox(
          width: 147,
          child: Stack(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 160,
                    height: 147,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFFF6F6F6),
                    ),
                    child: Image.asset(fruits[index].image),
                  ),
                  Text(
                    fruits[index].title,
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "4.8 (287)",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "\$${fruits[index].price.toString()}  ",
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Positioned(
                left: 105,
                top: 105,
                child: Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    onPressed: () {
                      ref
                          .read(cartProvider.notifier)
                          .addToCart(
                            title: fruits[index].title,
                            image: fruits[index].image,
                            price: fruits[index].price.toDouble(),
                          );
                      ScaffoldMessenger.of(context).clearSnackBars();
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Color(0xFF0CA201),
                          action: SnackBarAction(
                            label: "View Basket",
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Column(
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
                                              title: Text(item.title),
                                              subtitle: Text(
                                                '\$${item.price} * ${item.quantity}',
                                              ),
                                              trailing: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  IconButton(
                                                    onPressed: () {
                                                      cartNotifer
                                                          .removeFromCart(
                                                            item.title,
                                                          );
                                                    },
                                                    icon: Icon(
                                                      Icons
                                                          .remove_circle_outline,
                                                    ),
                                                  ),
                                                  Text(
                                                    item.quantity.toString(),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      cartNotifer.addToCart(
                                                        title: item.title,
                                                        image: item.image,
                                                        price: item.price,
                                                      );
                                                    },
                                                    icon: Icon(
                                                      Icons.add_circle_outline,
                                                    ),
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
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          ),
                          content: Text("Item Added"),
                        ),
                      );
                    },
                    icon: Icon(Icons.add),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
