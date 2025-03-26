import 'package:e_comm_app/remote/api_service.dart';
import 'package:flutter/material.dart';
import 'model/product_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductListScreen(),
    );
  }
}

class ProductListScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ProductListScreenState();
  }
}

class _ProductListScreenState extends State<ProductListScreen> {
  late Future<List<Product>> products;

  @override
  void initState() {
    super.initState();
    products = ApiService.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FakeStore Products'),
      ),
      body: FutureBuilder<List<Product>>(
          future: products,
          builder: (
            context,
            snapshot,
          ) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(child: Text('No products found'));
            }

            return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final product = snapshot.data![index];
                  return ListTile(
                    leading: Image.network(
                      product.image,
                      width: 50,
                      height: 50,
                    ),
                    title: Text(product.title),
                    subtitle: Text('\$${product.price}'),
                  );
                });
          }),
    );
  }
}
