import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class UpdateProductScreen extends StatefulWidget {
  final String productId; // Pass the product ID when navigating to this screen
  final VoidCallback onUpdate; // Callback to refresh product list

  const UpdateProductScreen({super.key, required this.productId, required this.onUpdate});

  @override
  State<UpdateProductScreen> createState() => _UpdateProductScreenState();
}

class _UpdateProductScreenState extends State<UpdateProductScreen> {
  final TextEditingController _productNameTEController = TextEditingController();
  final TextEditingController _productPriceTEController = TextEditingController();
  final TextEditingController _productQuantityTEController = TextEditingController();
  final TextEditingController _productCodeTEController = TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Update Product'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: buildForm(),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _globalKey,
      child: Column(
        children: [
          TextFormField(
            controller: _productNameTEController,
            decoration: InputDecoration(
              hintText: 'Product Name',
              labelText: 'Product Name',
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter a valid value' : null,
          ),
          TextFormField(
            controller: _productPriceTEController,
            decoration: InputDecoration(
              hintText: 'Unit Price',
              labelText: 'Unit Price',
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter a valid value' : null,
          ),
          TextFormField(
            controller: _productCodeTEController,
            decoration: InputDecoration(
              hintText: 'Product Code',
              labelText: 'Product Code',
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter a valid value' : null,
          ),
          TextFormField(
            controller: _productQuantityTEController,
            decoration: InputDecoration(
              hintText: 'Quantity',
              labelText: 'Quantity',
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter a valid value' : null,
          ),
          TextFormField(
            controller: _totalPriceTEController,
            decoration: InputDecoration(
              hintText: 'Total Price',
              labelText: 'Total',
            ),
            validator: (value) => value == null || value.isEmpty ? 'Enter a valid value' : null,
          ),
          const SizedBox(height: 16),
          _inProgress
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size.fromWidth(double.maxFinite),
            ),
            onPressed: _onTapProductUpdateButton,
            child: Text('UPDATE'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _productNameTEController.dispose();
    _productPriceTEController.dispose();
    _productCodeTEController.dispose();
    _productQuantityTEController.dispose();
    _totalPriceTEController.dispose();
    super.dispose();
  }

  void _onTapProductUpdateButton() {
    if (_globalKey.currentState!.validate()) {
      updateProduct();
    }
  }

  Future<void> updateProduct() async {
    setState(() {
      _inProgress = true;
    });

    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/UpdateProduct/${widget.productId}');
    Map<String, dynamic> requestBody = {
      "ProductName": _productNameTEController.text,
      "ProductCode": _productCodeTEController.text,
      "UnitPrice": _productPriceTEController.text,
      "Qty": _productQuantityTEController.text,
      "TotalPrice": _totalPriceTEController.text,
    };

    try {
      http.Response response = await http.post(
        uri,
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        _clearTextFields();
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Product updated successfully')),
          );
          widget.onUpdate(); // Call the callback to refresh the product list
          Navigator.pop(context); // Navigate back after update
        }
      } else {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Failed to update product')),
          );
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() {
          _inProgress = false;
        });
      }
    }
  }

  void _clearTextFields() {
    _productNameTEController.clear();
    _productPriceTEController.clear();
    _productCodeTEController.clear();
    _productQuantityTEController.clear();
    _totalPriceTEController.clear();
  }
}
