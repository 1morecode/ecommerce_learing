//
// Created by 1 More Code on 27/05/24.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:state_mgt/view/productDetails/product_detail.dart';

class ProductCard extends StatelessWidget {
  final dynamic product;

  const ProductCard({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetail(
                product: product,
              ),
            ));
      },
      padding: EdgeInsets.zero,
      child: Card(
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: RatingBar.builder(
                      initialRating: product['rating'],
                      minRating: 1,
                      direction: Axis.horizontal,
                      allowHalfRating: true,
                      itemCount: 5,
                      itemPadding: const EdgeInsets.symmetric(horizontal: 1.0),
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      itemSize: 16,
                      onRatingUpdate: (rating) {
                        print(rating);
                      },
                    ),
                  ),
                  Text(product['category'].toString().toUpperCase())
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
