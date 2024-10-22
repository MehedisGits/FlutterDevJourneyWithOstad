import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product.dart';

class ProductService {
  final String baseUrl = 'http://164.68.107.70:6060/api/v1';

  // Fetch product list from the server
  Future<List<Product>> getProductList() async {
    Uri uri = Uri.parse('$baseUrl/ReadProduct');
    try {
      final response = await http.get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        List<Product> products = [];
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
          products.add(product);
        }
        return products;
      } else {
        throw Exception('Failed to load products');
      }
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }
}
