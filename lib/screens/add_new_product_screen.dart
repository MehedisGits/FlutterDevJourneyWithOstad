import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AddNewProductScreen extends StatefulWidget {
  const AddNewProductScreen({super.key});

  @override
  State<AddNewProductScreen> createState() => _AddNewProductScreenState();
}

class _AddNewProductScreenState extends State<AddNewProductScreen> {
  final TextEditingController _productIDTEController = TextEditingController();
  final TextEditingController _productNameTEController =
      TextEditingController();
  final TextEditingController _productPriceTEController =
      TextEditingController();
  final TextEditingController _productQuantityTEController =
      TextEditingController();
  final TextEditingController _productCodeTEController =
      TextEditingController();
  final TextEditingController _totalPriceTEController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _inProgress = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Product'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: buildForm(),
        ),
      ),
    );
  }

  Widget buildForm() {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildTextFormField(_productIDTEController, 'Product ID'),
          _buildTextFormField(_productNameTEController, 'Product Name'),
          _buildTextFormField(_productPriceTEController, 'Unit Price'),
          _buildTextFormField(_productCodeTEController, 'Product Code'),
          _buildTextFormField(_productQuantityTEController, 'Quantity'),
          _buildTextFormField(_totalPriceTEController, 'Total Price'),
          const SizedBox(height: 16),
          _inProgress
              ? const Center(child: CircularProgressIndicator())
              : ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    fixedSize: const Size.fromWidth(double.maxFinite),
                  ),
                  onPressed: _onTapProductAddButton,
                  child: const Text('Add Product'),
                ),
        ],
      ),
    );
  }

  Widget _buildTextFormField(TextEditingController controller, String label) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: label,
        labelText: label,
      ),
      validator: (String? value) {
        if (value == null || value.isEmpty) {
          return "Enter a valid value";
        }
        return null;
      },
    );
  }

  void _clearTextFields() {
    _productIDTEController.clear();
    _productNameTEController.clear();
    _productPriceTEController.clear();
    _productCodeTEController.clear();
    _productQuantityTEController.clear();
    _totalPriceTEController.clear();
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

  void _onTapProductAddButton() {
    if (_formKey.currentState!.validate()) {
      addNewProduct();
    }
  }

  Future<void> addNewProduct() async {
    setState(() {
      _inProgress = true;
    });

    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/CreateProduct');
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
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product added successfully')),
        );

        Navigator.pop(context, true); // Pop and return true to indicate success
      } else {
        throw Exception('Failed to add product');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    } finally {
      setState(() {
        _inProgress = false;
      });
    }
  }
}
