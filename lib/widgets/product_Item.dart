import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/product.dart';
import '../screens/update_product_screen.dart';

class ProductItem extends StatefulWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onUpdate,
  });

  final Product product;
  final VoidCallback onUpdate; // Callback to refresh the product list

  @override
  State<ProductItem> createState() => _ProductItemState();
}

class _ProductItemState extends State<ProductItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  flex: 50,
                  child: Text(
                    widget.product.productName,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProductScreen(
                            productId: widget.product.id,
                            onUpdate: () {
                              // Call the onUpdate callback to refresh the list
                              widget.onUpdate();
                            },
                          ),
                        ),
                      ).then((_) {
                        widget.onUpdate();
                      });
                    },
                    icon: const Icon(
                      Icons.edit,
                      color: Colors.green,
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: IconButton(
                    onPressed: () async {
                      bool? confirmDelete = await _showDeleteConfirmation(context);
                      if (confirmDelete == true) {
                        await _deleteProduct();
                      }
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text('Id: ${widget.product.id}'),
            Text('Unit Price: ${widget.product.unitPrice}'),
            Text('Product Code: ${widget.product.productCode}'),
            Text('Quantity: ${widget.product.quantity}'),
            const SizedBox(height: 8),
            const Divider(),
            const SizedBox(height: 4),
            Row(
              children: [
                const Expanded(child: Text('Total Due to Pay:', style: TextStyle(fontWeight: FontWeight.bold))),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(widget.product.totalPrice, style: const TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future<bool?> _showDeleteConfirmation(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Delete Product'),
          content: const Text('Are you sure you want to delete this product?'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Delete', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  Future<void> _deleteProduct() async {
    final String productId = widget.product.id; // Get the product ID
    print(productId);
    final Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$productId');
    print(uri);

    try {
      final response = await http.delete(uri);

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        // Successfully deleted
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
        widget.onUpdate(); // Refresh the product list
      } else {
        // Provide more specific error handling
        String message = 'Failed to delete product.';

        if (response.statusCode == 404) {
          message = 'Product not found. It may have already been deleted.';
        } else {
          message = 'Error ${response.statusCode}: ${response.body}';
        }

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(message)),
        );
      }
    } catch (e) {
      // Handle any errors during the deletion
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }


}
