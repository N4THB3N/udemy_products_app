import 'package:flutter/material.dart';
import 'package:products_app/models/models.dart';
import 'package:products_app/screens/screens.dart';
import 'package:products_app/services/services.dart';
import 'package:products_app/widgets/widgets.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsService = Provider.of<ProductsService>(context);

    if (productsService.isLoading) return const LoadingScreen();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
      ),
      body: ListView.builder(
          itemCount: productsService.products.length,
          itemBuilder: (BuildContext context, int index) => GestureDetector(
                onTap: () {
                  productsService.selectedProduct =
                      productsService.products[index].copy();
                  Navigator.pushNamed(context, 'product');
                },
                child: ProductCard(product: productsService.products[index]),
              )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          productsService.selectedProduct =
              new Product(available: true, name: '', price: 0);
          Navigator.pushNamed(context, 'product');
        },
      ),
    );
  }
}
