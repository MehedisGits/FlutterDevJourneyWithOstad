import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  // List to track products
  final List<Product> products = [
    Product(
      imageUrl:
      "https://static-01.daraz.com.bd/p/38a8e822da9fe774e7381188a8db832a.jpg",
      size: "XL",
      price: 55,
      quantity: 1.obs,
    ),
    Product(
      imageUrl:
      "https://images.othoba.com/images/thumbs/0638072_fine-tex-premium-quality-white-color-drop-shoulder-t-shirt-for-men.webp",
      size: "L",
      price: 44,
      quantity: 1.obs,
    ),
    Product(
      imageUrl:
      "https://stonefieldbd.com/public/uploads/products/photos/h407CJECqkKUSDmr8EnZLTbW8DsCHtE684zL2FUw.jpeg",
      size: "M",
      price: 33,
      quantity: 1.obs,
    ),
  ];

  // Total amount calculation
  RxDouble totalAmount = 0.0.obs;

  @override
  void initState() {
    super.initState();
    // Update total amount on the initial load
    calculateTotalAmount();
  }

  void calculateTotalAmount() {
    totalAmount.value = 0.0;
    for (var product in products) {
      totalAmount.value += product.price * product.quantity.value;
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'My Cart',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Cards
            Expanded(
              child: ListView.builder(
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return productCard(screenWidth, products[index]);
                },
              ),
            ),
            // Total Amount Display
            Row(
              children: [
                Text("Total amount:"),
                Spacer(),
                Obx(() => Text("\$${totalAmount.value.toString()}")),
              ],
            ),
            SizedBox(height: 6),
            SizedBox(
              width: double.infinity,
              height: screenWidth * 0.1,
              child: ElevatedButton(
                onPressed: () {
                  // Show Snackbar using ScaffoldMessenger
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("You've been checked out successfully"),
                      backgroundColor: Colors.green,  // Background color
                      duration: Duration(seconds: 2),  // Duration for the snack bar
                      behavior: SnackBarBehavior.floating,  // Snack bar behavior
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),  // Rounded corners
                      ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red, foregroundColor: Colors.white),
                child: Text('CHECK OUT'),
              ),
            )
          ],
        ),
      ),
    );
  }

  Card productCard(double screenWidth, Product product) {
    return Card(
      color: Colors.white,
      elevation: 1,
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          // Product Image
          Image.network(
            product.imageUrl,
            width: screenWidth * 0.2,
          ),
          // Content Section
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Row with Title and More Options
                  Row(
                    children: [
                      const Text(
                        'Pullover',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          // Action for more options
                        },
                        icon: const Icon(Icons.more_vert),
                      ),
                    ],
                  ),
                  // Row with Color and Size
                  Row(
                    children: [
                      const Text("Color: "),
                      const Text("Black",
                          style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500)),
                      const SizedBox(width: 5),
                      const Text("Size: "),
                      Text(
                        product.size,
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Quantity Selector with Price
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Decrease Button
                      ElevatedButton(
                        onPressed: () {
                          if (product.quantity.value > 1) {
                            product.quantity.value--;
                          }
                          calculateTotalAmount(); // Update total amount
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          elevation: 2,
                        ),
                        child: const Icon(
                          Icons.remove,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 8),
                      // Quantity Text
                      Obx(() => Text(
                        product.quantity.toString(),
                        style: const TextStyle(
                            fontSize: 22, fontWeight: FontWeight.w500),
                      )),
                      const SizedBox(width: 8),
                      // Increase Button
                      ElevatedButton(
                        onPressed: () {
                          product.quantity.value++;
                          calculateTotalAmount(); // Update total amount
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(12),
                          elevation: 2,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.black,
                          size: 20,
                        ),
                      ),
                      const Spacer(),
                      // Dynamic Price Display
                      Obx(() => Text(
                        "\$${(product.quantity.value * product.price).toString()}",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// Product model
class Product {
  final String imageUrl;
  final String size;
  final int price;
  final RxInt quantity;

  Product({
    required this.imageUrl,
    required this.size,
    required this.price,
    required this.quantity,
  });
}
