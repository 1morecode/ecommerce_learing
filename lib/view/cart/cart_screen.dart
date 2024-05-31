//
// Created by 1 More Code on 29/05/24.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/providers/product_state.dart';
import 'package:state_mgt/view/cart/components/cart_product_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, productState, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Cart"),
          backgroundColor: Colors.blue,
        ),
        body: productState.cartData != null
            ? ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Cart Products",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ),
                  ...List.generate(productState.cartData['products'].length,
                      (index) {
                    return CartProductCard(
                      product: productState.cartData['products'][index],
                    );
                  }),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    child: Text(
                      "Price Details",
                      style: TextStyle(
                          color: Colors.grey, fontWeight: FontWeight.w600),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            const Expanded(child: Text("Total Price")),
                            Text("\$${productState.cartData['total'].floor()}")
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text("Discount")),
                            Text(
                                "\$${(productState.cartData['total'] - productState.cartData['discountedTotal']).floor()}")
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(child: Text("Quantity")),
                            Text("${productState.cartData['totalQuantity']}")
                          ],
                        ),
                        Row(
                          children: [
                            const Expanded(
                                child: Text(
                              "Total",
                              style: TextStyle(
                                  fontWeight: FontWeight.w600, fontSize: 18),
                            )),
                            Text(
                                "\$${productState.cartData['discountedTotal'].floor()}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600, fontSize: 18))
                          ],
                        )
                      ],
                    ),
                  )
                ],
              )
            : Container(),
        bottomNavigationBar: productState.cartData != null ?Container(
          decoration: BoxDecoration(
              color: Colors.white,
            border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3)))
          ),
          height: 80,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            child: Row(
              children: [
                Expanded(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Total", style: TextStyle(color: Colors.blue),),
                    Text(
                        "\$${productState.cartData['discountedTotal'].floor()}",
                        style: const TextStyle(
                            fontWeight: FontWeight.w600, fontSize: 18))
                  ],
                )),
                CupertinoButton(
                  onPressed: () {},
                  color: Colors.green,
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  child: const Text("Checkout"),
                )
              ],
            ),
          ),
        ) : Container(
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.withOpacity(0.3)))
          ),
          height: 80,
        ),
      ),
    );
  }
}
