import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/screens/update_product_screen.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  final ThemeMode themeMode; // Holds the current theme mode (light/dark/system)
  final VoidCallback onToggleTheme; // Callback function to toggle the theme

  const ProductListScreen(
      {super.key, required this.themeMode, required this.onToggleTheme});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  // List of product names, generated as placeholders
  List<String> products = List.generate(100, (index) => 'Product $index');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'), // App bar title
        actions: [
          IconButton(
            // Button to toggle the theme (light/dark)
            onPressed: () {
              widget.onToggleTheme(); // Calls the toggle theme function
            },
            icon: Icon(Theme.of(context).brightness == Brightness.light
                ? Icons.dark_mode_outlined // Shows dark mode icon if light theme
                : Icons.light_mode), // Shows light mode icon if dark theme
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
        // Button to navigate to the "Add New Product" screen
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewProductScreen(), // Navigate to add product screen
            ),
          );
        },
        child: const Icon(Icons.add), // Icon for adding a new product
      ),
      // ListView.builder to display a scrollable list of products
      body: ListView.builder(
        itemCount: products.length, // Number of items (products) in the list
        itemBuilder: (context, index) {
          String product = products[index]; // Get product name by index
          return Card(
            elevation: 2, // Shadow effect for card
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.all(10.0), // Inner padding for card content
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start, // Align content to start
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 50,
                        child: Text(
                          product, // Displays the product name
                          style: const TextStyle(fontSize: 18, color: Colors.green),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: IconButton(
                          // Button to navigate to the update product screen
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => UpdateProductScreen(
                                  productId: 'ID_$index', // Mock product ID passed
                                  onUpdate: () {
                                    // Placeholder for update logic
                                  },
                                ),
                              ),
                            );
                          },
                          icon: const Icon(
                            Icons.edit, // Edit icon
                            color: Colors.green, // Green color for edit button
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 20,
                        child: IconButton(
                          // Button to delete the product
                          onPressed: () {
                            setState(() {
                              products.removeAt(index); // Remove product from list
                            });
                          },
                          icon: const Icon(
                            Icons.delete, // Delete icon
                            color: Colors.red, // Red color for delete button
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8), // Space between rows
                  Text('Id: ID_$index'), // Mock product ID display
                  const Text('Unit Price: \$100'), // Placeholder for product price
                  const Text('Product Code: PRD123'), // Placeholder for product code
                  const Text('Quantity: 5'), // Placeholder for quantity
                  const SizedBox(height: 8), // Space before divider
                  const Divider(), // Divider between product details and total
                  const SizedBox(height: 4), // Space after divider
                  const Row(
                    children: [
                      Expanded(child: Text('Total Due to Pay:')), // Label for total amount
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end, // Align amount to right
                          children: [
                            Text('\$500'), // Placeholder for total amount
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
