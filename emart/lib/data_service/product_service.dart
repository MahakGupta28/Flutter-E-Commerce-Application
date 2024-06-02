import 'dart:convert';
import 'package:emart/consts/consts.dart';
import 'package:http/http.dart' as http;

void main() async {
  int productIdToFetch = 1; // Change this to the desired product ID
  ProductService productService = ProductService();

  try {
    ListofProduct listofProduct = await productService.getProduct();
    Product? product = listofProduct.getById(productIdToFetch);

    if (product != null) {
      print("Product ID: ${product.id}");
      print("Product Name: ${product.name}");
      // Print other product details here
    } else {
      print("Product with ID $productIdToFetch not found.");
    }
  } catch (e) {
    print("Error: $e");
  }
}

class ProductService {
  static final productserviceModel = ProductService._internal();
  ProductService._internal();
  factory ProductService() => productserviceModel;

  Future<ListofProduct> getProduct() async {
    var response =
        await http.get(Uri.parse("http://10.0.2.2:8000/eshop/productlist"));

    if (response.statusCode == 200) {
      return ListofProduct.fromList(jsonDecode(response.body));
    } else {
      throw Exception('Failed to load products');
    }
  }
}

class ListofProduct {
  final List<Product> products;

  ListofProduct({required this.products});

  Product getById(int ids) {
    return products.firstWhere((element) => element.id == ids, orElse: () {
      if (ids == 1) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Sandal',
          price: 1000,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 2) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Earing',
          price: 800,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 3) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Saree',
          price: 3400,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 4) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'White Shoes',
          price: 4800,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 5) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Black Shirt',
          price: 1000,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 6) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Pink Saree',
          price: 4800,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 6) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'Pink Saree',
          price: 4800,
          description: '',
          image: '',
          category: 0,
        );
      }
      if (ids == 7) {
        return Product(
          id: -1, // Use a negative or invalid value to indicate not found

          name: 'lehanga',
          price: 4800,
          description: '',
          image: '',
          category: 0,
        );
      }

      return Product(
          id: -1,
          name: 'Product not found',
          price: 0,
          description: '',
          image: '',
          category: 0);
    });
  }

  Product getByPosition(int pos) => products[pos];

  factory ListofProduct.fromList(List<dynamic> list) {
    List<Product> _products = [];
    for (var element in list) {
      _products.add(Product.fromJson(element));
    }
    return ListofProduct(products: _products);
  }
}

class Product {
  final int id;
  final String name;
  final int price; // Change to int
  final String description;
  final String image;
  final int category;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.description,
    required this.image,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> map) {
    return Product(
      id: map['id'],
      name: map['name'],
      price: map['Price'], // Update to 'price'
      description: map['description'],
      image: map['image'],
      category: map['category'],
    );
  }
}
