//
// Created by 1 More Code on 27/05/24.
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/providers/product_state.dart';
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
    provider.fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, productState, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Products"),
          backgroundColor: Colors.blue,
        ),
        body: ListView.builder(
          itemBuilder: (context, index) => ProductCard(
            product: productState.products[index],
          ),
          itemCount: productState.products.length,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: (){
            productState.fetchProducts();
          },
          child: Icon(Icons.refresh),
        ),
      ),
    );
  }
}
