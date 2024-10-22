import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../models/product.dart';
import '../widgets/product_Item.dart';
import 'add_new_product_screen.dart';

class ProductListScreen extends StatefulWidget {
  final ThemeMode themeMode;
  final VoidCallback onToggleTheme;

  const ProductListScreen({super.key, required this.themeMode, required this.onToggleTheme});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  List<Product> productList = [];
  bool _isLoading = true; // Indicator to show loading state
  bool _isError = false; // To track if an error occurs

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  Future<void> getProductList() async {
    Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
    Response response = await get(uri);

    if (kDebugMode) {
      print(response.statusCode);
      print(response.body); // Log the API response body
    }

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      if (jsonResponse.containsKey('data')) {
        productList.clear(); // Clear the list before adding new items
        for (var item in jsonResponse['data']) {
          Product product = Product(
            id: item['_id'] ?? '',
            productName: item['ProductName'] ?? 'Unknown Product',
            productCode: item['ProductCode'] ?? 'N/A',
            productImage: item['Img'] ?? '',
            unitPrice: item['UnitPrice'] ?? 0,
            quantity: item['Qty'] ?? 0,
            totalPrice: item['TotalPrice'] ?? '0',
            createdAt: item['CreatedDate'] ?? '',
          );
          productList.add(product);
        }
        setState(() {
          _isLoading = false;
          _isError = false; // No error since the data is loaded successfully
        });
      } else {
        handleError("No 'data' field found in the API response.");
      }
    } else {
      handleError("Failed to load products: ${response.statusCode}");
    }
  }

  void handleError(String message) {
    setState(() {
      _isLoading = false;
      _isError = true; // Error if status code is not 200
    });
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
    if (kDebugMode) {
      print(message);
    }
  }

  void onUpdate() {
    getProductList(); // Call to refresh the list directly
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AddNewProductScreen(),
            ),
          ).then((_) => getProductList()); // Refresh the list after adding a new product
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator()) // Show loader while loading
          : _isError
          ? const Center(child: Text('Failed to load data')) // Show error message
          : ListView.builder(
        itemCount: productList.length,
        itemBuilder: (context, index) {
          Product product = productList[index];
          return ProductItem(product: product, onUpdate: onUpdate);
        },
      ),
    );
  }

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
      title: const Text('Product List'),
      actions: [
        IconButton(
          onPressed: widget.onToggleTheme,
          icon: Icon(Theme.of(context).brightness == Brightness.light ? Icons.dark_mode_outlined : Icons.light_mode),
        ),
        IconButton(
          onPressed: getProductList,
          icon: const Icon(Icons.refresh),
        ),
      ],
    );
  }
}
