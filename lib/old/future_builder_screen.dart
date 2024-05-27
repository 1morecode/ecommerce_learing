//
// Created by 1 More Code on 22/05/24.
//

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:state_mgt/old/provider/home_provider.dart';

class FutureBuilderScreen extends StatelessWidget {
  const FutureBuilderScreen({super.key});

  static final List<dynamic> stateList = [
    {
      "label": "Andaman & Nicobar",
      "value": "Andaman and Nicobar Islands",
      "count": 60
    },
    {"label": "Andhra Pradesh", "value": "Andhra Pradesh", "count": 319},
    {"label": "Arunachal Pradesh", "value": "Arunachal Pradesh", "count": 147},
    {"label": "Assam", "value": "Assam", "count": 1117},
    {"label": "Bihar", "value": "Bihar", "count": 234},
    {"label": "Chandigarh", "value": "Chandigarh", "count": 314},
    {"label": "Chhattisgarh", "value": "Chhattisgarh", "count": 400},
    {
      "label": "Dadra Nagar & Daman Diu",
      "value": "Dadra and Nagar Haveli and Daman and Diu",
      "count": 58
    },
    {"label": "Daman and Diu", "value": "Daman and Diu", "count": 172},
    {"label": "Delhi", "value": "Delhi", "count": 143},
    {"label": "Goa", "value": "Goa", "count": 141},
    {"label": "Gujarat", "value": "Gujarat", "count": 290},
    {"label": "Haryana", "value": "Haryana", "count": 187},
    {"label": "Himachal Pradesh", "value": "Himachal Pradesh", "count": 230},
    {"label": "Jammu & Kashmir", "value": "Jammu and Kashmir", "count": 506},
    {"label": "Jharkhand", "value": "Jharkhand", "count": 164},
    {"label": "Karnataka", "value": "Karnataka", "count": 328},
    {"label": "Kerala", "value": "Kerala", "count": 495},
    {"label": "Ladakh", "value": "Ladakh", "count": 63},
    {"label": "Lakshadweep", "value": "Lakshadweep", "count": 3},
    {"label": "Madhya Pradesh", "value": "Madhya Pradesh", "count": 275},
    {"label": "Maharashtra", "value": "Maharashtra", "count": 322},
    {"label": "Manipur", "value": "Manipur", "count": 222},
    {"label": "Meghalaya", "value": "Meghalaya", "count": 102},
    {"label": "Mizoram", "value": "Mizoram", "count": 115},
    {"label": "Nagaland", "value": "Nagaland", "count": 219},
    {"label": "Odisha", "value": "Odisha", "count": 335},
    {"label": "Pondicherry", "value": "Pondicherry", "count": 107},
    {"label": "Punjab", "value": "Punjab", "count": 291},
    {"label": "Rajasthan", "value": "Rajasthan", "count": 470},
    {"label": "Sikkim", "value": "Sikkim", "count": 129},
    {"label": "Tamil Nadu", "value": "Tamil Nadu", "count": 305},
    {"label": "Telangana", "value": "Telangana", "count": 289},
    {"label": "Tripura", "value": "Tripura", "count": 131},
    {"label": "Uttar Pradesh", "value": "Uttar Pradesh", "count": 355},
    {"label": "Uttarakhand", "value": "Uttarakhand", "count": 272},
    {"label": "West Bengal", "value": "West Bengal", "count": 755}
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeProvider, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Future Builder"),
        ),
        body: Padding(
          padding: const EdgeInsets.only(bottom: 100),
          child: FutureBuilder(
            future: futureFunction(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data != null && snapshot.data!.isNotEmpty) {
                  return SelectableText(snapshot.data!.toString());
                }
                return const Center(
                  child: Text("Data Not Found"),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.refresh),
          onPressed: () {
            homeProvider.handleLoader();
          },
        ),
      ),
    );
  }

  Future<dynamic> futureFunction() async {
    try {
      // String apiEndPoint =
      //     'https://cbook-tawny.vercel.app/api/state?q=the&page=1&limit=100000';
      String jsonData = await rootBundle.loadString('assets/states-data.json');
      // Get Request
      // var response = await http.get(Uri.parse(apiEndPoint));

      // Post Request
      // var response = await http.post(Uri.parse(apiEndPoint), body: jsonEncode({
      //   "name": "Amit"
      // }));

      List<dynamic> ll = jsonDecode(jsonData);

      List<Map<String, dynamic>> stateWiseData = [];

      for (var state in stateList) {
        List<dynamic> acts =
            ll.where((element) => element['state'] == state['value']).toList();

        // Act Number
        List<dynamic> actsNumbers =
        acts.map((dd) => dd['details']['act_number']).toList();

        Map<String, int> actsNumbersCount = {};

        // Count occurrences of each state
        for (String actNum in actsNumbers) {
          actsNumbersCount[actNum] = (actsNumbersCount[actNum] ?? 0) + 1;
        }

        List<dynamic> actNumList = [];

        actsNumbersCount.forEach((key, value) {
          if(key.isNotEmpty){
            actNumList.add({
              "label": key,
              "count": value
            });
          }
        });

        print(actNumList);

        // Department
        List<dynamic> departments = acts
            .map((dd) => dd['details'].containsKey('department')
                ? dd['details']['department']
                : "")
            .toList();

        Map<String, dynamic> departmentsCount = {};

        // Count occurrences of each state
        for (String depart in departments) {
          departmentsCount[depart] = (departmentsCount[depart] ?? 0) + 1;
        }

        List<dynamic> departList = [];

        departmentsCount.forEach((key, value) {
          if(key.isNotEmpty){
            departList.add({
              "label": key,
              "count": value
            });
          }

        });

        print(departList);

        // ministry
        List<dynamic> ministry = acts
            .map((dd) => dd['details'].containsKey('ministry')
            ? dd['details']['ministry']
            : "")
            .toList();

        Map<String, dynamic> ministryCount = {};

        // Count occurrences of each state
        for (String mini in ministry) {
          ministryCount[mini] = (ministryCount[mini] ?? 0) + 1;
        }

        List<dynamic> ministryList = [];

        ministryCount.forEach((key, value) {
          if(key.isNotEmpty){
            ministryList.add({
              "label": key,
              "count": value
            });
          }
        });

        print(ministryList);

        // act_year
        List<dynamic> act_year = acts
            .map((dd) => dd['details'].containsKey('act_year')
            ? dd['details']['act_year']
            : "")
            .toList();

        Map<String, dynamic> act_yearCount = {};

        // Count occurrences of each state
        for (String actY in act_year) {
          act_yearCount[actY] = (act_yearCount[actY] ?? 0) + 1;
        }

        List<dynamic> act_yearList = [];

        act_yearCount.forEach((key, value) {
          if(key.isNotEmpty){
            act_yearList.add({
              "label": key,
              "count": value
            });
          }
        });

        print(act_yearList);
        stateWiseData.add({
          "state": state['value'],
          "ministry": ministryList,
          "department": departList,
          "actYear": act_yearList,
          "actNumber": actNumList
        });
        print(stateWiseData);
      }

      // List<dynamic> ll = data['acts'];

      // List<dynamic> states = ll.map((dd) => dd['state']).toList();
      //
      // Map<String, int> stateCount = {};
      //
      // // Count occurrences of each state
      // for (String state in states) {
      //   stateCount[state] = (stateCount[state] ?? 0) + 1;
      // }

      // print(stateWiseData);
      return jsonEncode(stateWiseData);
    } catch (e) {
      print(e);
      return [];
    }
  }
}
