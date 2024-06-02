import 'package:emart/data_service/product_service.dart'; // Import your dependencies

class CartModel {
  static final cartModel = CartModel._internal();
  CartModel._internal();
  factory CartModel() => cartModel;
  // Product Field
  ListofProduct _listOfProduct = ListofProduct(
      products: []); // Use ListofProduct instead of ProductService

  // Collection of IDS
  final List<int> _itemIds = [];

  ListofProduct get listOfProduct => _listOfProduct;

  set listOfProduct(ListofProduct newList) {
    assert(newList != null);
    _listOfProduct = newList;
  }

  // Get items in the cart
  List<Product> get products =>
      _itemIds.map((id) => listOfProduct.getById(id)).toList();

  // Get total price
  num get totalPrice =>
      products.fold(0, (total, current) => total + current.price);

  // Add item
  void add(Product product) {
    _itemIds.add(product.id);
  }

  // Remove item
  void remove(Product product) {
    _itemIds.remove(product);
  }
}
