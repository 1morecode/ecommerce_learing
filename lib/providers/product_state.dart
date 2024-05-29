//
// Created by 1 More Code on 27/05/24.
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_mgt/config/api.dart';

class ProductState extends ChangeNotifier {

  int currentSliderIndex = 0;
  List<dynamic> products = [];
  List<dynamic> categoriesProducts = [];
  List<dynamic> categories = [];
  dynamic cartData;

  onIndexChange(int index) {
    currentSliderIndex = index;
    notifyListeners();
  }

  Future<bool> fetchProducts() async {
    try{
      var request = http.Request('GET', Uri.parse(API.getAllProducts(skip: products.length, limit: 50)));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(await response.stream.bytesToString());
        products.addAll(data['products']);
        notifyListeners();
        print(data['products']);
      }
      else {
        print(response.reasonPhrase);
      }
    }catch(e) {
      print(e);
    }
    return true;
  }

  Future<bool> fetchProductsByCategory({required String category}) async {
    try{
      categoriesProducts.clear();
      notifyListeners();
      var request = http.Request('GET', Uri.parse(API.productsByCategory(skip: categoriesProducts.length, limit: 50, category: category)));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(await response.stream.bytesToString());
        categoriesProducts.addAll(data['products']);
        notifyListeners();
        print(data);
      }
      else {
        print(response.reasonPhrase);
      }
    }catch(e) {
      print(e);
    }
    return true;
  }

  Future<bool> fetchCategory() async {
    try{
      var request = http.Request('GET', Uri.parse(API.getAllCategories));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(await response.stream.bytesToString());
        categories = data;
      }
      else {
        print(response.reasonPhrase);
      }
    }catch(e) {
      print(e);
    }
    return true;
  }

  Future<bool> fetchCart() async {
    try{
      var request = http.Request('GET', Uri.parse(API.cartById(id: "1")));

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        dynamic data = jsonDecode(await response.stream.bytesToString());
        cartData = data;
        notifyListeners();
      }
      else {
        print(response.reasonPhrase);
      }
    }catch(e) {
      print(e);
    }
    return true;
  }


}