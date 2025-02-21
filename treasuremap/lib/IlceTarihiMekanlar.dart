import 'package:flutter/material.dart';

class IlceTarihiMekanlar extends StatelessWidget {
  final String ilceAdi; // İlçe adı
  final List<String> mekanlar; // Tarihi mekanlar listesi

  IlceTarihiMekanlar({required this.ilceAdi, required this.mekanlar});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("$ilceAdi'deki Tarihi Mekanlar sdfsdfdsfsdf"),
      ),
      body: GridView.count(
        crossAxisCount: 2, // Her satırda 2 kutucukf
        padding: EdgeInsets.all(16.0),
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        children: mekanlar
            .map((mekan) => Card(
                  elevation: 5.0,
                  child: Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        mekan,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ))
            .toList(),
      ),
    );
  }
}
