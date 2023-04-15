import 'package:fleksa/screens/CartPage.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

class Items extends StatefulWidget {
  const Items({
    Key? key,
  }) : super(key: key);

  @override
  _ItemsState createState() => _ItemsState();
}

class _ItemsState extends State<Items> {
  List<Map<String, dynamic>> cartItems = [];
  late final Function(List<Map<String, dynamic>>) navigateToCartPage;
  int _quantity = 1;
  var _totalPrice = 0;
  List<Map<String, dynamic>> options = [
    {'label': 'Extra Patty', 'value': '20'},
    {'label': 'Extra Cheese', 'value': '30'},
    {'label': 'Both', 'value': '50'},
  ];

  String selectedChoice = '0';

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight,
      width: screenWidth,
      child: FutureBuilder(
        future: DefaultAssetBundle.of(context).loadString('assets/data.json'),
        builder: (context, snapshot) {
          var data = json.decode(snapshot.data.toString());
          return ListView.builder(
            physics: const ClampingScrollPhysics(),
            shrinkWrap: true,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                color: Colors.grey[300],
                margin: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    CircleAvatar(
                      radius: 80,
                      backgroundImage: NetworkImage(data[index]["ItemImage"]),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data[index]["ItemName"],
                            style: const TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8.0),
                          Text(
                            data[index]["Description"],
                            style: const TextStyle(
                              fontSize: 16.0,
                            ),
                          ),
                          SizedBox(height: 16.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Rs.${data[index]['price']}",
                                style: const TextStyle(
                                  fontSize: 20.0,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    _quantity = 1;
                                    _totalPrice = data[index]['price'];
                                  });
                                  showModalBottomSheet(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return StatefulBuilder(
                                          builder: (BuildContext context,
                                              StateSetter setState) {
                                            return Container(
                                              height: 450,
                                              child: Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        EdgeInsets.all(5.0),
                                                    child: Text(
                                                      data[index]['ItemName'],
                                                      style: const TextStyle(
                                                        fontSize: 24,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Text(
                                                      data[index]
                                                          ["Description"],
                                                      style: const TextStyle(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: Column(
                                                      children: <Widget>[
                                                        for (var option
                                                            in options)
                                                          RadioListTile(
                                                            title: Text(option[
                                                                'label']),
                                                            subtitle: Text(
                                                                option[
                                                                    'value']),
                                                            value:
                                                                option['value'],
                                                            groupValue:
                                                                selectedChoice,
                                                            onChanged: (value) {
                                                              setState(() {
                                                                selectedChoice =
                                                                    value;
                                                              });
                                                            },
                                                          ),
                                                      ],
                                                    ),
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: [
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            if (_quantity > 1)
                                                              _quantity--;
                                                            _totalPrice = data[
                                                                        index]
                                                                    ['price'] *
                                                                _quantity;
                                                          });
                                                        },
                                                        icon:
                                                            Icon(Icons.remove),
                                                      ),
                                                      Text(
                                                        _quantity.toString(),
                                                        style: const TextStyle(
                                                          fontSize: 20,
                                                        ),
                                                      ),
                                                      IconButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            _quantity++;
                                                            _totalPrice = data[
                                                                        index]
                                                                    ['price'] *
                                                                _quantity;
                                                          });
                                                        },
                                                        icon: Icon(Icons.add),
                                                      ),
                                                    ],
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            5.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                        addtocart(data[index]);
                                                      },
                                                      child: const Text(
                                                          "Add to Cart"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          },
                                        );
                                      });
                                },
                                child: const Text('Add to Cart'),
                              ),
                              IconButton(
                                icon: Icon(Icons.shopping_cart),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          CartPage(cartItems: cartItems),
                                    ),
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
            itemCount: data == null ? 0 : data.length,
          );
        },
      ),
    );
  }

  void addtocart(Map<String, dynamic> item) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item["ItemName"]} added to cart'),
        duration: const Duration(seconds: 2),
        action: SnackBarAction(
          label: 'View Cart',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CartPage(cartItems: cartItems),
              ),
            );
          },
        ),
      ),
    );
    String jsonString = json.encode(item);
    jsonString = jsonString.replaceAll('}', ',"quantity":"$_quantity"}');
    jsonString = jsonString.replaceAll('}', ',"addon":"$selectedChoice"}');
    item = json.decode(jsonString);
    print(item);
    // print("The selected choice is $selectedChoice");
    cartItems.add(item);
    print('Added to cart: $item');
    print(cartItems);
  }
}
