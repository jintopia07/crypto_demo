// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, sized_box_for_whitespace

import 'package:chart_sparkline/chart_sparkline.dart';
import 'package:flutter/material.dart';

class Item extends StatelessWidget {
  var item;
  Item({this.item});

  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: sizeWidth * 0.04, vertical: sizeHeight * 0.02),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              height: sizeHeight * 0.05,
              child: Image.network(item.image),
            ),
          ),
          SizedBox(width: sizeWidth * 0.02),

          // ชื่อและสัญลักษณ์
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.id,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis, // ป้องกันข้อความยาวเกิน
                ),
                Text(
                  '0.5 ${item.symbol}',
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          SizedBox(width: sizeWidth * 0.01),

          Expanded(
            flex: 2,
            child: Container(
              height: sizeHeight * 0.05,
              child: Sparkline(
                data: item.sparklineIn7D.price,
                lineWidth: 2.0,
                lineColor: item.marketCapChangePercentage24H >= 0
                    ? Colors.green
                    : Colors.red,
                fillMode: FillMode.below,
                fillGradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.0, 0.7],
                  colors: item.marketCapChangePercentage24H >= 0
                      ? [Colors.green, Colors.green.shade100]
                      : [Colors.red, Colors.red.shade100],
                ),
              ),
            ),
          ),
          SizedBox(width: sizeWidth * 0.02),

          // ราคาปัจจุบัน และการเปลี่ยนแปลงราคา
          Expanded(
            flex: 3,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '\$ ${item.currentPrice}',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        item.priceChange24H < 0
                            ? "-\$${(item.priceChange24H * -1).toStringAsFixed(2)}"
                            : "\$${item.priceChange24H.toStringAsFixed(2)}",
                        style: TextStyle(fontSize: 12, color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    SizedBox(width: sizeWidth * 0.01),
                    Expanded(
                      child: Text(
                        '${item.marketCapChangePercentage24H.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 12,
                          color: item.marketCapChangePercentage24H >= 0
                              ? Colors.green
                              : Colors.red,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
