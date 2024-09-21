import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/models/product.dart';
import 'package:flutter_devjourney_ostad/screens/update_product_screen.dart';
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
        style: TextStyle(color: Colors.lightBlue, fontSize: 20),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Unit Price: \$${product.unitPrice}', style: TextStyle(color: Colors.black, fontSize: 18)),
          SizedBox(height: 2),
          Text('Code: ${product.productCode}', style: TextStyle(color: Colors.black)),
          SizedBox(height: 2),
          Text('Quantity: ${product.quantity}', style: TextStyle(color: Colors.black)),
          SizedBox(height: 4),
          Divider(color: Colors.black26),
          Row(
            children: [
              Text('Total: \$${product.totalPrice}', style: TextStyle(color: Colors.black, fontSize: 16)),
              Spacer(),
              OverflowBar(
                children: [
                  TextButton.icon(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) {
                        return UpdateProductScreen(productId: product.id, onUpdate: () { ();  },);
                      }));
                    },
                    label: Text('Edit'),
                    icon: Icon(Icons.edit),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      _deleteProduct(product.id, context);
                    },
                    label: Text('Delete'),
                    icon: Icon(Icons.delete, color: Colors.red),
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

      print('Status Code: ${response.statusCode}'); // Log status code
      print('Response Body: ${response.body}'); // Log response body

      if (response.statusCode == 200 || response.statusCode == 204) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product deleted successfully')),
        );
        onDelete(id);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to delete product')),
        );
      }
    } catch (e) {
      print('Error occurred: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

}
