//
// Created by 1 More Code on 21/05/24.
//

import 'package:flutter/cupertino.dart';

class HomeProvider with ChangeNotifier {
  // HomeProvider(_);
  bool isFutureLoading = false;

  int counter = 0;

  void incrementCounter() {
    counter++;
    notifyListeners();
  }

  // Async Await

  void handleLoader() async {
    isFutureLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    isFutureLoading = false;
    notifyListeners();
  }

}
