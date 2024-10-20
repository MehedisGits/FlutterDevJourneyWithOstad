import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/models/product.dart';
import 'package:http/http.dart' as http;

class ProductItem extends StatelessWidget {
  const ProductItem({
    super.key,
    required this.product,
    required this.onDelete,
    required this.onUpdate,
  });

  final Product product;
  final Function(String id) onDelete;
  final Function onUpdate;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      title: Text(
        product.productName,
        style: const TextStyle(color: Colors.lightBlue, fontSize: 20),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Unit Price: \$${product.unitPrice}',
            style: const TextStyle(color: Colors.black, fontSize: 18),
          ),
          const SizedBox(height: 2),
          Text('Code: ${product.productCode}', style: const TextStyle(color: Colors.black)),
          const SizedBox(height: 2),
          Text('Quantity: ${product.quantity}', style: const TextStyle(color: Colors.black)),
          const SizedBox(height: 4),
          const Divider(color: Colors.black26),
          Row(
            children: [
              Text(
                'Total: \$${product.totalPrice}',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const Spacer(),
              OverflowBar(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UpdateProductScreen(
                            productId: product.id,
                            onUpdate: () {
                              onUpdate(); // Call onUpdate to refresh the list after the product is updated
                              Navigator.pop(context); // Navigate back to the product list
                            },
                          ),
                        ),
                      );
                    },
                    label: const Text('Edit'),
                    icon: const Icon(Icons.edit),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _deleteProduct(product.id, context);
                    },
                    label: const Text('Delete'),
                    icon: const Icon(Icons.delete, color: Colors.red),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _deleteProduct(String id, BuildContext context) async {
    final Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/DeleteProduct/$id');

    try {
      final http.Response response = await http.delete(uri);

      if (kDebugMode) {
        print('Status Code: ${response.statusCode}');
        print('Response Body: ${response.body}');
      }

      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
        onDelete(id); // Notify the parent widget to remove the product from the list
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete product')),
        );
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error occurred: $e');
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }
}
