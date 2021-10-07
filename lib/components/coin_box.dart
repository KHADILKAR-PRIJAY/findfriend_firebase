import 'package:flutter/material.dart';

class CoinBox extends StatelessWidget {
  final String price;
  final String coins;
  CoinBox({required this.price, required this.coins});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(4.0),
            child: Text(coins.toString()),
          ),
          CircleAvatar(
              backgroundColor: Colors.orange[300],
              radius: 13,
              child: Text(
                '\u{20B9}',
                style: TextStyle(fontSize: 15, color: Colors.black),
              )),
          Container(
            width: double.infinity,
            decoration: BoxDecoration(
                color: Color(0xFF2596BE),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                )),
            child: Center(
                child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: Text('\u{20B9} $price'),
            )),
          ),
        ],
      ),
      height: 100,
      width: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Color(0xFF6A6A6C),
      ),
    );
  }
}
