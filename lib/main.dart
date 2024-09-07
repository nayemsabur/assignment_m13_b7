import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ShoppingCart(),
    );
  }
}

class ShoppingCart extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<ShoppingCart> {
  List<Product> products = [
    Product(
        name: 'Pullover',
        color: 'Black',
        size: 'L',
        price: 51,
        image: 'Assets/sblack.jpeg',
        quantity: 0),
    Product(
        name: 'T-Shirt',
        color: 'Gray',
        size: 'L',
        price: 30,
        image: 'Assets/gray.jpeg',
        quantity: 0),
    Product(
        name: 'Sport Dress',
        color: 'Black',
        size: 'M',
        price: 43,
        image: 'Assets/sblack.jpeg',
        quantity: 0),
  ];

  void _increaseQuantity(Product product) {
    setState(() {
      product.quantity++;
    });
  }

  void _decreaseQuantity(Product product) {
    if (product.quantity > 1) {
      setState(() {
        product.quantity--;
      });
    }
  }

  double get totalPrice {
    return products.fold(
        0, (sum, product) => sum + product.price * product.quantity);
  }

  void _checkout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Congratulations! Your order has been placed.'),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Bag'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ...products.map((product) {
                  return Card(
                    child: ListTile(
                      leading: Image.asset(product.image),
                      title: Text(product.name),
                      subtitle:
                      Text('Color: ${product.color} | Size: ${product.size}'),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.remove),
                            onPressed: () => _decreaseQuantity(product),
                          ),
                          Text(product.quantity.toString()),
                          IconButton(
                            icon: Icon(Icons.add),
                            onPressed: () => _increaseQuantity(product),
                          ),
                          Text(
                              '\$${(product.price * product.quantity).toStringAsFixed(2)}'),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('Total: \$${totalPrice.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        child: ElevatedButton(
          onPressed: () {
            _checkout(context);
          },
          child: Text('CHECK OUT'),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            textStyle: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}

class Product {
  final String name;
  final String color;
  final String size;
  final double price;
  final String image;
  int quantity;

  Product(
      {required this.name,
        required this.color,
        required this.size,
        required this.price,
        required this.image,
        required this.quantity});
}
