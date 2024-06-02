import 'package:flutter/material.dart';
import 'package:emart/data_service/product_service.dart';
import '../../consts/consts.dart';

class WishlistScreen extends StatefulWidget {
  final Set<int> wishlist;

  const WishlistScreen({Key? key, required this.wishlist}) : super(key: key);

  @override
  _WishlistScreenState createState() => _WishlistScreenState();
}

class _WishlistScreenState extends State<WishlistScreen> {
  ProductService productService = ProductService();
  List<Product>? wishlistProducts;

  @override
  void initState() {
    super.initState();
    fetchWishlistProducts();
  }

  Future<void> fetchWishlistProducts() async {
    try {
      final allProducts = await productService.getProduct();
      wishlistProducts = allProducts.products
          .where((product) => widget.wishlist.contains(product.id))
          .toList();
    } catch (e) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Wishlist'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            if (wishlistProducts != null)
              Column(
                children: wishlistProducts!.map((product) {
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    ),
                    title: Text(product.name),
                    subtitle: Text('₹${product.price}'),
                  );
                }).toList(),
              )
            else
              CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
