import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../util/constants.dart';
import '../Model/product.dart';

class ProductTile extends StatelessWidget {
  ProductTile({this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 292,
      width: 159,
      padding: EdgeInsets.symmetric(vertical: 2, horizontal: 2),
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(8)),
      child: Column(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(8), topRight: Radius.circular(8)),
            child: Container(
              child: Image(
                image: NetworkImage(product.imageUrl),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  product.headline,
                  style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8a98ad)),
                )),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 2),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                product.productName,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextColour),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 2, 12, 1),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '€${product.listPrice}',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: kTextColour),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
