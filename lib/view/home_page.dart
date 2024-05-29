//
// Created by 1 More Code on 27/05/24.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/providers/product_state.dart';
import 'package:state_mgt/view/cart/cart_screen.dart';
import 'package:state_mgt/view/category_page.dart';
import 'package:state_mgt/view/components/product_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var provider = Provider.of<ProductState>(context, listen: false);
    provider.fetchCategory();
    provider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, productState, child) => Scaffold(
        appBar: AppBar(
          title: const Text(
            "Products",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.blue,
          actions: [
            IconButton(
                onPressed: () {
                  productState.fetchCart();
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CartScreen(),
                      ));
                },
                icon: const Icon(
                  CupertinoIcons.cart,
                  color: Colors.white,
                ))
          ],
        ),
        body: ListView(
          children: [
            SizedBox(
              height: 60,
              child: Row(
                children: [
                  Expanded(
                      child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: CupertinoButton(
                        onPressed: () {
                          productState.fetchProductsByCategory(category: productState.categories[index]['slug']);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CategoryScreen(
                                  category: productState.categories[index],
                                ),
                              ));
                        },
                        padding: const EdgeInsets.all(0),
                        child: Chip(
                          label: Text(productState.categories[index]['name']),
                          padding: const EdgeInsets.all(0),
                        ),
                      ),
                    ),
                    itemCount: productState.categories.length,
                  ))
                ],
              ),
            ),
            ...List.generate(
                productState.products.length,
                (index) => ProductCard(
                      product: productState.products[index],
                    ))
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            productState.fetchProducts();
          },
          child: const Icon(Icons.refresh),
        ),
      ),
    );
  }
}
