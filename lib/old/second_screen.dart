//
// Created by 1 More Code on 21/05/24.
//

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/old/provider/home_provider.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Second Screen"),
        ),
        body: Center(
          child: Text(
            homeProvider.counter.toString(),
            style: const TextStyle(fontSize: 32),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: homeProvider.incrementCounter,
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
