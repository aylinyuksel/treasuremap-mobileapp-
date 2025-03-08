import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favoriler_provider.dart';
import '../TarihiMekanDetay.dart'; 

class FavorilerSayfasi extends StatelessWidget {
  const FavorilerSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    final favorilerProvider = Provider.of<FavorilerProvider>(context);
    final favoriMekanlar = favorilerProvider.favoriMekanlar;

    return Scaffold(
      appBar: AppBar(title: Text("Favoriler")),
      body: favoriMekanlar.isEmpty
          ? Center(child: Text("Henüz favori eklenmedi!"))
          : ListView.builder(
              itemCount: favoriMekanlar.length,
              itemBuilder: (context, index) {
                String mekanAdi = favoriMekanlar[index];

                return Card(
                  elevation: 5.0,
                  child: ListTile(
                    leading: Icon(
                      Icons.favorite, // 📌 Favori mekanlar her zaman kırmızı kalacak
                      color: Colors.red,
                    ),
                    title: Text(mekanAdi),
                    trailing: IconButton(
                      icon: Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        favorilerProvider.favoriEkleCikar(mekanAdi);
                      },
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => TarihiMekanDetay(mekanAdi: mekanAdi),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
