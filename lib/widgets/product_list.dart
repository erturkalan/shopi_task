import 'package:flutter/material.dart';
import 'package:shopi_task/tile/product_tile.dart';

class ProductList extends StatelessWidget {
  const ProductList({
    Key key,
    @required ScrollController scrollController,
    @required this.products,
    @required this.toggleNumber,
  })  : scrollController = scrollController,
        super(key: key);

  final ScrollController scrollController;
  final List products;
  final int toggleNumber;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
      child: GridView.builder(
          controller: scrollController,
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: toggleNumber,
              childAspectRatio: toggleNumber == 2 ? 0.46 : 0.70,
              mainAxisSpacing: 16,
              crossAxisSpacing: 20),
          itemBuilder: (context, index) {
            return ProductTile(product: products[index]);
          }),
    ));
  }
}
