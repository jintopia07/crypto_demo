// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, body_might_complete_normally_nullable, prefer_typing_uninitialized_variables

import 'package:crypto_demo/widget/item_coin.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../Model/coin_model.dart';
import 'package:http/http.dart' as http;

import '../widget/item.dart';

class Home extends StatefulWidget {
  final List<CoinModel>? mockData;

  const Home({super.key, this.mockData = const []});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: sizeHeight,
        width: sizeWidth,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color.fromRGBO(233, 247, 251, 1.0),
              Color.fromRGBO(233, 247, 251, 0.0),
            ],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: sizeWidth * 0.05, vertical: sizeHeight * 0.03),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: sizeWidth * 0.02,
                        vertical: sizeHeight * 0.005),
                    decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(5)),
                    child: Text(
                      'Main portfolio',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                  Text(
                    'Top 10 coins',
                    style: TextStyle(fontSize: 16),
                  ),
                  Text(
                    'Exprimental',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.07),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '\$ 7,999.09',
                    style: TextStyle(fontSize: 28),
                  ),
                  Container(
                    padding: EdgeInsets.all(sizeWidth * 0.02),
                    height: sizeHeight * 0.05,
                    width: sizeWidth * 0.1,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.5)),
                    child: Image.asset(
                      'assets/icons/5.1.png',
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.07),
              child: Row(
                children: [
                  Text(
                    '+162% all time',
                    style: TextStyle(fontSize: 14),
                  )
                ],
              ),
            ),
            SizedBox(height: sizeHeight * 0.02),
            Expanded(
              child: Container(
                height: sizeHeight * 0.7,
                width: sizeWidth,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                child: Column(
                  children: [
                    SizedBox(height: sizeHeight * 0.03),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.07),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Assets',
                            style: TextStyle(fontSize: 16),
                          ),
                          Icon(Icons.add)
                        ],
                      ),
                    ),
                    Container(
                      height: sizeHeight * 0.36,
                      child: isRefreshing == true
                          ? Center(
                              child: CircularProgressIndicator(
                                color: Color(0xffFBC700),
                              ),
                            )
                          : coinMarket == null || coinMarket!.isEmpty
                              ? Padding(
                                  padding: EdgeInsets.all(sizeHeight * 0.06),
                                  child: Center(
                                    child: Text(
                                      'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                      style: TextStyle(fontSize: 18),
                                    ),
                                  ),
                                )
                              : ListView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return Item(
                                      item: coinMarket![index],
                                    );
                                  },
                                ),
                    ),
                    SizedBox(height: sizeHeight * 0.02),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: sizeWidth * 0.05),
                      child: Row(
                        children: [
                          Text(
                            'Recommend to Buy',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: sizeHeight * 0.02),
                    Expanded(
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: sizeWidth * 0.02),
                        child: isRefreshing == true
                            ? Center(
                                child: CircularProgressIndicator(
                                  color: Color(0xffFBC700),
                                ),
                              )
                            : coinMarket == null || coinMarket!.length == 0
                                ? Padding(
                                    padding: EdgeInsets.all(sizeHeight * 0.06),
                                    child: Center(
                                      child: Text(
                                        'Attention this Api is free, so you cannot send multiple requests per second, please wait and try again later.',
                                        style: TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount: coinMarket!.length,
                                    itemBuilder: (context, index) {
                                      return ItemCoin(
                                        item: coinMarket![index],
                                      );
                                    },
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url =
        'https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type": "application/json",
      "Accept": "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if (response.statusCode == 200) {
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    } else {
      print(response.statusCode);
    }

    // 🔹 ถ้า widget มี mockData ให้ใช้แทน API call
    await Future.delayed(Duration(seconds: 1)); // Simulate network delay
    if (widget.mockData != null) {
      setState(() {
        coinMarket = widget.mockData;
        isRefreshing = false;
      });
    } else {
      setState(() {
        isRefreshing = false;
      });
    }
  }
}
