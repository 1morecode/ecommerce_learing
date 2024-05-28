//
// Created by 1 More Code on 27/05/24.
//

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/providers/product_state.dart';

class ProductDetail extends StatelessWidget {
  final dynamic product;

  const ProductDetail({super.key, this.product});

  static final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    return Consumer<ProductState>(
      builder: (context, value, child) => Scaffold(
        appBar: AppBar(
          title: Text(product['title']),
          titleSpacing: 0,
          elevation: 1,
        ),
        body: ListView(
          children: [
            // Slider Images
            CarouselSlider(
                carouselController: _controller,
                items: List.generate(product['images'].length,
                    (index) => Image.network(product['images'][index])),
                options: CarouselOptions(
                  aspectRatio: 5 / 3,
                  viewportFraction: 0.8,
                  initialPage: value.currentSliderIndex,
                  enableInfiniteScroll: true,
                  reverse: false,
                  autoPlay: product['images'].length >= 2,
                  autoPlayInterval: const Duration(seconds: 3),
                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  enlargeCenterPage: true,
                  enlargeFactor: 0.3,
                  onPageChanged: (index, reason) {
                    value.onIndexChange(index);
                  },
                  scrollDirection: Axis.horizontal,
                )),
            // Indicator
            if(product['images'].length >= 2)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                product['images'].length,
                (index) => GestureDetector(
                    onTap: () {
                      value.onIndexChange(index);
                      _controller.jumpToPage(index);
                    },
                    child: Container(
                      width: 8.0,
                      height: 8.0,
                      margin: const EdgeInsets.symmetric(
                          vertical: 8.0, horizontal: 4.0),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.black.withOpacity(
                            value.currentSliderIndex == index ? 0.6 : 0.2),
                      ),
                    )),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['brand'] ?? "",
                    style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: Colors.blue),
                  ),
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
                  Text(product['category'].toString().toUpperCase()),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Description",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(product['description']),
                  Row(
                    children: List.generate(
                        product['tags'].length,
                        (index) => Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Chip(
                                label: Text(product['tags'][index]),
                                padding: const EdgeInsets.all(0),
                              ),
                            )),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text(
                    "Review and Ratings",
                    style: TextStyle(
                        color: Colors.grey,
                        fontSize: 18,
                        fontWeight: FontWeight.w500),
                  ),
                  ...List.generate(
                    product['reviews'].length,
                    (index) => ListTile(
                      horizontalTitleGap: 10,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 0),
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey.withOpacity(0.2),
                        radius: 25,
                        child: Text(
                            product['reviews'][index]['rating'].toString()),
                      ),
                      title: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            product['reviews'][index]['reviewerName'],
                            style: const TextStyle(
                                color: Colors.blue, fontSize: 14),
                          ),
                          Text(product['reviews'][index]['comment']),
                          Text(
                            product['reviews'][index]['date'],
                            style: const TextStyle(
                                fontSize: 14, color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: Row(
          children: [
            Expanded(
                child: SizedBox(
              height: 70,
              child: CupertinoButton(
                padding: const EdgeInsets.all(0),
                color: Colors.blueGrey,
                onPressed: () {},
                borderRadius: BorderRadius.circular(0),
                child: const Text("Add to Favorite"),
              ),
            )),
            Expanded(
                child: SizedBox(
              height: 70,
              child: CupertinoButton(
                padding: const EdgeInsets.all(0),
                color: Colors.blue,
                onPressed: () {},
                borderRadius: BorderRadius.circular(0),
                child: const Text("Add to Cart"),
              ),
            ))
          ],
        ),
      ),
    );
  }
}
