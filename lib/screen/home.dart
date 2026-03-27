import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grabber/provider/cart.dart';
import 'package:grabber/screen/cart_screen.dart';
import 'package:grabber/widget/catergory.dart';
import 'package:grabber/widget/fruit.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    final totalCount = cartItems.fold(0, (sum, item) => sum + item.quantity);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Badge(
            label: Text(totalCount.toString()),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return CartScreen();
                    },
                  ),
                );
              },
              icon: Icon(Icons.shopping_basket_outlined),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.max,
          spacing: 12,
          children: [
            SizedBox(
              height: 222,
              width: double.infinity,
              child: CarouselView.weighted(
                // itemExtent: 430,
                flexWeights: const <int>[1, 5, 1],
                children: [
                  Container(
                    height: 222,
                    width: 430,
                    decoration: BoxDecoration(color: Color(0xFFD7FFD4)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 40, left: 20),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            spacing: 12,
                            children: [
                              Text(
                                "Up to 30% offer",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Text(
                                "Enjoy our big offer",
                                style: GoogleFonts.inter(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13,
                                  color: Color(0xFF0CA201),
                                ),
                              ),
                              FilledButton(
                                onPressed: () {},
                                style: FilledButton.styleFrom(
                                  backgroundColor: Color(0xFF0CA201),
                                  side: BorderSide.none,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    "Shop Now",
                                    style: GoogleFonts.inter(
                                      fontSize: 13,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Positioned(
                          left: 150,
                          child: Image.asset(
                            "assets/images/basket.png",
                            height: 200,
                            width: 300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Image.asset(
                    "assets/images/Slider 2.png",
                    // height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                  Image.asset(
                    "assets/images/Slider 3.png",
                    // height: 200,
                    width: 300,
                    fit: BoxFit.cover,
                  ),
                ],
              ),
            ),

            SizedBox(height: 100, child: Catergory()),

            Padding(
              padding: const EdgeInsets.only(right: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Fruits",
                    style: GoogleFonts.inter(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "See all",
                    style: GoogleFonts.inter(
                      color: Color(0xFF0CA201),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 245, child: Fruit()),
          ],
        ),
      ),
    );
  }
}
