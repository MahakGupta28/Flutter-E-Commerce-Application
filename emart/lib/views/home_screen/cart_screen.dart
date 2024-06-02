import 'package:emart/consts/colors.dart';
import 'package:emart/views/home_screen/home_screen.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Summary'),
        backgroundColor: purple,
      ),
      body: Container(
        color: lighpurple,
        child: const Center(
          child: Text(
            'Shipping not available :(    ',
            style: TextStyle(fontSize: 24),
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: HomeScreen(),
  ));
}
