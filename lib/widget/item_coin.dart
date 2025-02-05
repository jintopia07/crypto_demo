// ignore_for_file: prefer_interpolation_to_compose_strings, prefer_const_constructors, must_be_immutable, use_key_in_widget_constructors, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../View/select_coin.dart';

class ItemCoin extends StatelessWidget {
  var item;
  ItemCoin({this.item});

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: sizeWidth * 0.02, vertical: sizeHeight * 0.005),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (contest) => SelectCoin(
                        selectItem: item,
                      )));
        },
        child: Container(
          padding: EdgeInsets.only(
            left: sizeWidth * 0.03,
            right: sizeWidth * 0.06,
            top: sizeHeight * 0.02,
            bottom: sizeHeight * 0.02,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.grey)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: sizeHeight * 0.035,
                child: Image.network(
                  item.image,
                  width: sizeWidth * 0.08,
                  height: sizeHeight * 0.08,
                ),
              ),
              SizedBox(
                height: sizeHeight * 0.004,
              ),
              Text(
                item.id,
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: sizeHeight * 0.006,
              ),
              Row(
                children: [
                  Text(
                    item.priceChange24H.toString().contains('-')
                        ? "-\$" +
                            item.priceChange24H
                                .toStringAsFixed(2)
                                .toString()
                                .replaceAll('-', '')
                        : "\$" + item.priceChange24H.toStringAsFixed(2),
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey),
                  ),
                  SizedBox(
                    width: sizeWidth * 0.02,
                  ),
                  Text(
                    item.marketCapChangePercentage24H.toStringAsFixed(2) + '%',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.normal,
                        color: item.marketCapChangePercentage24H >= 0
                            ? Colors.green
                            : Colors.red),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
