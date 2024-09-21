import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/models/product.dart';
import 'package:flutter_devjourney_ostad/screens/add_new_product_screen.dart';
import 'package:http/http.dart' as http;
import '../widgets/product_Item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productList = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              getProductList(); // Reload product list when pressed
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddNewProductScreen()),
          );

          // If the result is true, it means a product was added, so refresh the list
          if (result == true) {
            getProductList(); // Refresh product list
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Product list refreshed')),
            );
          }
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : productList.isEmpty
          ? const Center(child: Text("No products available"))
          : ListView.separated(
        itemBuilder: (context, index) {
          return ProductItem(
            product: productList[index],
            onDelete: (String id) {
              setState(() {
                productList.removeWhere((product) => product.id == id);
              });
            },
            onUpdate: () {
              getProductList(); // Refresh the product list after updating
            },
          );
        },
        separatorBuilder: (context, index) {
          return const SizedBox(height: 4);
        },
        itemCount: productList.length,
      ),
    );
  }

  Future<void> getProductList() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
      http.Response response = await http.get(uri);

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          productList.clear();
          for (var item in jsonResponse['data']) {
            Product product = Product(
              id: item['_id'] ?? '',
              productName: item['ProductName'] ?? '',
              productCode: item['ProductCode'] ?? '',
              productImage: item['Img'] ?? '',
              unitPrice: item['UnitPrice'] ?? '',
              quantity: item['Qty'],
              totalPrice: item['TotalPrice'] ?? '',
              createdAt: item['CreatedDate'] ?? '',
            );
            productList.add(product);
          }
        }
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
