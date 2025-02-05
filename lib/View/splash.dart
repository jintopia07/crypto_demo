// ignore_for_file: unused_local_variable

import 'package:crypto_demo/View/navBar.dart';
import 'package:flutter/material.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  Widget build(BuildContext context) {
    double sizeHeight = MediaQuery.of(context).size.height;
    double sizeWidth = MediaQuery.of(context).size.width;
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(233, 247, 251, 1.0),
        body: SingleChildScrollView(
          child: ConstrainedBox(
            constraints:
                BoxConstraints(minHeight: MediaQuery.of(context).size.height),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/image/bitcoin.gif'),
                const Text(
                  'The Future',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.0),
                  child: const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Learn more about cryptocurrency, '),
                        TextSpan(
                          text: 'look to the future ',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        TextSpan(text: 'in IO Crypto'),
                      ],
                    ),
                    textAlign: TextAlign.center, // 🔹 จัดให้อยู่ตรงกลาง
                    style: TextStyle(fontSize: 20, color: Colors.grey),
                  ),
                ),
                SizedBox(height: sizeHeight * 0.07),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: sizeWidth * 0.14),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NavBar()));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: const Color(0xffFBC700),
                          borderRadius: BorderRadius.circular(50)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: sizeWidth * 0.05,
                            vertical: sizeHeight * 0.013),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              // 🔹 ใช้ Expanded เพื่อให้ Text ปรับขนาดตามพื้นที่ที่เหลือ
                              child: Text(
                                'CREATE PORTFOLITO',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.normal,
                                ),
                                overflow: TextOverflow
                                    .ellipsis, // 🔹 ป้องกันข้อความล้น
                                maxLines: 1,
                              ),
                            ),
                            RotationTransition(
                              turns: AlwaysStoppedAnimation(310 / 360),
                              child: Icon(Icons.arrow_forward_rounded),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
