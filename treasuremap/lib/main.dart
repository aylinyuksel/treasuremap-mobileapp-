import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'anasayfa.dart';
import 'hakkimizda.dart';
import 'nedir.dart';
import 'ayarlar.dart';

void main() async {
  await dotenv.load(); // .env dosyasını yükle

  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
        "/": (context) => Anasayfa(),
        "/hakkimizda": (context) => Favoriler(),
        "/nedir": (context) => Nedir(),
        "/ayarlar": (context) => Ayarlar(),
      },
    ),
  );
}
