//
// Created by 1 More Code on 21/05/24.
//

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/old/future_builder_screen.dart';
import 'package:state_mgt/old/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        appBar: AppBar(title: const Text("Home Screen"),),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                homeProvider.counter.toString(),
                style: const TextStyle(fontSize: 32),
              ),

              CupertinoButton(child: const Text("Go to Future Builder"), onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => const FutureBuilderScreen(),));
              })
            ],
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
