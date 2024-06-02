import 'package:emart/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:emart/consts/lists.dart';
import 'package:emart/data_service/product_service.dart';
import '../../consts/consts.dart';
//import 'package:emart/views/home_screen/cart_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProductService productService = ProductService();
  List<Product>? products;

  @override
  void initState() {
    super.initState();
    fetchProducts();
  }

  ListofProduct? _listOfProduct;

  Future<void> fetchProducts() async {
    try {
      _listOfProduct = await productService.getProduct();
      products = _listOfProduct?.products;
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      color: lighpurple,
      width: context.screenWidth,
      height: context.screenHeight,
      child: SafeArea(
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              height: 60,
              color: lighpurple,
              child: const Text(
                'E-Shop',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            10.heightBox,
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersList.length,
                      itemBuilder: (context, index) {
                        return Image.asset(slidersList[index], fit: BoxFit.fill)
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(const EdgeInsets.symmetric(horizontal: 8))
                            .make();
                      },
                    ),
                    FutureBuilder<ListofProduct>(
                      future: productService.getProduct(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          products = snapshot.data!.products;
                          return 20.heightBox;
                        }
                        return CircularProgressIndicator();
                      },
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: featuredcategories.text
                          .color(Colors.black)
                          .size(20)
                          .fontWeight(FontWeight.bold)
                          .fontFamily(bold)
                          .make(),
                    ),
                    ...?products?.map((product) {
                      return Container(
                        padding: const EdgeInsets.all(12),
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          color: whiteColor,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Stack(
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.network(
                                product.image,
                                width: 120,
                                height: 120,
                                fit: BoxFit.cover,
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: const Alignment(1, -1),
                                  child: Text(
                                    product.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "sans_bold",
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                                Align(
                                  alignment: const Alignment(0.8, -3),
                                  child: Text(
                                    "₹" "${product.price}",
                                    style: const TextStyle(
                                      fontFamily: "sans_bold",
                                      fontSize: 18,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                                _AddToCart(
                                  product: product,
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AddToCart extends StatefulWidget {
  final Product product; // Pass the product as a parameter

  const _AddToCart({
    required this.product, // Receive the product as a parameter
    Key? key,
  }) : super(key: key);

  @override
  State<_AddToCart> createState() => _AddToCartState();
}

class _AddToCartState extends State<_AddToCart> {
  bool isAdded = false;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: const Alignment(1, -1),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          vertical: 8.0,
          horizontal: 12.0,
        ),
        child: OutlinedButton(
          onPressed: () {
            setState(() {
              isAdded = true; // Set the state to 'isAdded'
              final _cart = CartModel();
              _cart.add(widget.product);

              // Add the product to the cart
            });
          },
          style: OutlinedButton.styleFrom(
            backgroundColor: purple,
            padding: const EdgeInsets.all(12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: isAdded
              ? const Icon(
                  Icons.done,
                  color: Colors.white,
                )
              : const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                      size: 18,
                    ),
                    SizedBox(width: 8),
                    Text(
                      "Add To Cart",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
