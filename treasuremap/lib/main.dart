import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favoriler_provider.dart';
import 'anasayfa.dart';
import 'hakkimizda.dart';
import 'sayfalar/favoriler.dart';
import 'ayarlar.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FavorilerProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => Anasayfa(),
          "/favoriler": (context) => FavorilerSayfasi(),
          "/hakkimizda": (context) => Favoriler(),  
          "/ayarlar": (context) => Ayarlar(), 
        },
      ),
    ),
  );
}
