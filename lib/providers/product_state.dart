//
// Created by 1 More Code on 27/05/24.
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:state_mgt/config/api.dart';

class ProductState extends ChangeNotifier {

  List<dynamic> products = [];

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


}