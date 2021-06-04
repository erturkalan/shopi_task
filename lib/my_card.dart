import 'package:flutter/material.dart';
import 'constants.dart';

class MyCard extends StatelessWidget {
  const MyCard({
    Key key,
    @required this.picture,
    @required this.headline,
    @required this.productName,
    @required this.price,
  }) : super(key: key);

  final picture;
  final headline;
  final productName;
  final String price;

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
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
            child: Image(
              image: NetworkImage(picture),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
            child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  headline,
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
                productName,
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
                '€$price',
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
