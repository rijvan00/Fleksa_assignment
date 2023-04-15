import 'package:fleksa/screens/Checkout.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class CartPage extends StatefulWidget {
  final List<Map<String, dynamic>> cartItems;

  const CartPage({Key? key, required this.cartItems}) : super(key: key);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    var totalAmount = 0;

    for (int i = 0; i < widget.cartItems.length; i++) {
      int price = widget.cartItems[i]["price"].toInt();
      int quantity = int.parse(widget.cartItems[i]['quantity']);
      totalAmount += price * quantity;
      if (widget.cartItems[i]['addon'] != '') {
        totalAmount = totalAmount + int.parse(widget.cartItems[i]['addon']);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage:
                        NetworkImage(widget.cartItems[index]["ItemImage"]),
                  ),
                  title: Text(widget.cartItems[index]["ItemName"]),
                  subtitle: Text(
                      "Rs. ${widget.cartItems[index]["price"]} X ${widget.cartItems[index]["quantity"]} + Addon =  ${widget.cartItems[index]["addon"]}"),
                  trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () {
                        deleteCartItem(index);
                      }),
                );
              },
              itemCount: widget.cartItems.length,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Total: Rs. $totalAmount",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return CheckoutScreen();
                    }));
                  },
                  child: const Text('Checkout'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void deleteCartItem(int index) {
    setState(() {
      widget.cartItems.removeAt(index);
    });
  }
}
