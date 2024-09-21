import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_devjourney_ostad/models/product.dart';
import 'package:flutter_devjourney_ostad/screens/add_new_product_screen.dart';
import 'package:http/http.dart';
import '../widgets/product_Item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Product> productList = [];
  bool _isLoading = true; // Loading state

  @override
  void initState() {
    super.initState();
    getProductList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Product List',
          style: TextStyle(color: Colors.white),
        ),
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
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const AddNewProductScreen();
          })).then((_) => getProductList()); // Refresh product list after adding
        },
        child: const Icon(Icons.add),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator()) // Loader while fetching
          : productList.isEmpty
          ? Center(child: Text("No products available")) // Handle empty list
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
      _isLoading = true; // Show loading indicator
    });

    try {
      Uri uri = Uri.parse('http://164.68.107.70:6060/api/v1/ReadProduct');
      Response response = await get(uri);

      // Log the raw response body for debugging
      print('Raw Response Body: ${response.body}');
      print('Status Code: ${response.statusCode}');

      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        print('Decoded JSON: $jsonResponse'); // Log decoded response

        if (jsonResponse.containsKey('data') && jsonResponse['data'] is List) {
          productList.clear(); // Clear the existing list before adding new data
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
        } else {
          print('Invalid or empty data structure in JSON response');
        }
      } else {
        print('Non-200 Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error occurred: $e');
    } finally {
      setState(() {
        _isLoading = false; // Update loading state
      });
    }
  }
}
