import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/favoriler_provider.dart';
import 'anasayfa.dart';
import 'hakkimizda.dart';
import 'sayfalar/favoriler.dart';
import 'istanbulcard.dart';
import 'girisLogin.dart';

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
          "/istanbulcard": (context) => IstanbulCardScreen(),
          "/girisLogin": (context) => LoginScreen(), // Giriş ekranı
        },
      ),
    ),
  );
}
