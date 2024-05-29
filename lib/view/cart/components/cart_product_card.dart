//
// Created by 1 More Code on 29/05/24.
//

import 'package:flutter/material.dart';

class CartProductCard extends StatelessWidget {
  final dynamic product;
  const CartProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0.5,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(product['thumbnail'])),
                  border: Border.all(
                      color: Colors.grey.withOpacity(0.3), width: 1),
                  borderRadius: BorderRadius.circular(6)),
            ),
            const SizedBox(
              width: 10,
            ),
            Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product['title'],
                      style: const TextStyle(
                          fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    Row(
                      children: [
                        Text(
                          "\$${product['price'].toString()}",
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const Spacer(),
                        Text(
                          "Discount: ${product['discountPercentage'].toString()}%",
                          style: const TextStyle(
                              color: Colors.green,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),

                    Text("Quantity: ${product['quantity'].toString()}")
                  ],
                ))
          ],
        ),
      ),
    );
  }
}
