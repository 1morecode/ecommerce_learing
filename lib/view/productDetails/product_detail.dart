//
// Created by 1 More Code on 27/05/24.
//

import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  final dynamic product;
  const ProductDetail({super.key, this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(product['title']),),
    );
  }
}
