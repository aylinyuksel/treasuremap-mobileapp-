import 'package:flutter/material.dart';

class FavorilerProvider with ChangeNotifier {
  List<String> _favoriMekanlar = [];

  List<String> get favoriMekanlar => _favoriMekanlar;

  void favoriEkleCikar(String mekanAdi) {
    if (_favoriMekanlar.contains(mekanAdi)) {
      _favoriMekanlar.remove(mekanAdi);
    } else {
      _favoriMekanlar.add(mekanAdi);
    }
    notifyListeners(); // Değişiklikleri bildir
  }
}
