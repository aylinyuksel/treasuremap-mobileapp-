import 'package:flutter/material.dart';
import 'anasayfa.dart';
import 'hakkimizda.dart';
import 'nedir.dart';
import 'ayarlar.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Anasayfa(), // Güncellendi
        "/hakkimizda": (context) => Favoriler(),
        "/nedir": (context) => Nedir(),
        "/ayarlar": (context) => Ayarlar(),
      },
    ),
  );
}
