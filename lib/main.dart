import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ShoppingCartScreen(),
    );
  }
}

class ShoppingCartScreen extends StatefulWidget {
  @override
  _ShoppingCartScreenState createState() => _ShoppingCartScreenState();
}

class _ShoppingCartScreenState extends State<ShoppingCartScreen> {
  int itemCount = 0;
  double unitPrice = 10.0; // Assuming unit price for each item is $10
  double totalAmount = 0.0;

  void increaseItemCount() {
    setState(() {
      itemCount++;
      totalAmount = itemCount * unitPrice;
      if (itemCount % 5 == 0) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Item Added'),
              content: Text('You have added 5 items to your bag!'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
    });
  }

  void decreaseItemCount() {
    setState(() {
      if (itemCount > 0) {
        itemCount--;
        totalAmount = itemCount * unitPrice;
      }
    });
  }

  void checkOut() {
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
        title: Text('Shopping Cart'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.0),
            ProductCard(
              name: 'Pullover',
              unitPrice: 25.0,
              onAddToCart: () {
                increaseItemCount();
              },
            ),
            ProductCard(
              name: 'T-shirt',
              unitPrice: 15.0,
              onAddToCart: () {
                increaseItemCount();
              },
            ),
            ProductCard(
              name: 'Sport Dress',
              unitPrice: 30.0,
              onAddToCart: () {
                increaseItemCount();
              },
            ),
            SizedBox(height: 20.0),
            Center(
              child: Text(
                'Total Items: $itemCount',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            Center(
              child: Text(
                'Total Amount: \$${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 20.0),
              ),
            ),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: increaseItemCount,
                ),
                SizedBox(width: 20.0),
                IconButton(
                  icon: Icon(Icons.remove),
                  onPressed: decreaseItemCount,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: checkOut,
              child: Text('CHECK OUT'),
            ),
          ],
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  final String name;
  final double unitPrice;
  final VoidCallback onAddToCart;

  const ProductCard({
    required this.name,
    required this.unitPrice,
    required this.onAddToCart,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white60, // Change background color to black
      margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 4.0,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold, color: Colors.white), // Change text color to white
            ),
            SizedBox(height: 8.0),
            Text(
              'Price: \$${unitPrice.toStringAsFixed(2)}',
              style: TextStyle(fontSize: 16.0, color: Colors.white), // Change text color to white
            ),
            SizedBox(height: 8.0),
            Center(
              child: ElevatedButton(
                onPressed: onAddToCart,
                child: Text('Add to Cart'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}