//
// Created by 1 More Code on 29/05/24.
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/providers/product_state.dart';

import 'components/product_card.dart';

class CategoryScreen extends StatelessWidget {
  final dynamic category;
  const CategoryScreen({super.key, this.category});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(builder: (context, productState, child) => Scaffold(
      appBar: AppBar(title: Text(category['name']),),
      body: ListView(
        children: [
          ...List.generate(
              productState.categoriesProducts.length,
                  (index) => ProductCard(
                product: productState.categoriesProducts[index],
              ))
        ],
      ),
    ),);
  }
}
