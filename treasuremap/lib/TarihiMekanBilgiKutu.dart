import 'package:flutter/material.dart';

class TarihiMekanBilgiKutu extends StatelessWidget {
  final String mekanAdi;

  const TarihiMekanBilgiKutu({required this.mekanAdi, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // 📌 Mekan açıklamaları için bir harita tanımlıyoruz.
    Map<String, String> mekanBilgileri = {
      "Büyükada Rum Yetimhanesi":
          "Büyükada Rum Yetimhanesi, İstanbul’un Prens Adaları’nda yer alan ve 19. yüzyılın sonlarında inşa edilmiş tarihi bir yapı. Özgün ahşap işçiliği ve geniş verandalarıyla ziyaretçilerini büyüler.",
      
      "Aya Yorgi Kilisesi":
          "Aya Yorgi Kilisesi, Büyükada’nın en yüksek tepelerinden birinde bulunan ve 1751 yılında inşa edilen tarihi bir Rum Ortodoks kilisesidir. Ziyaretçiler buraya dua etmek ve muhteşem manzaranın tadını çıkarmak için gelirler.",

      "Heybeliada Ruhban Okulu":
          "Heybeliada Ruhban Okulu, Osmanlı döneminde 1844 yılında kurulan ve Ortodoks dünyası için önemli bir eğitim kurumu olan tarihi bir yapıdır. Ada'nın doğası ile iç içe olan bu okul, etkileyici bir tarihi mirasa sahiptir.",

      "Kınalıada Camii":
          "Kınalıada Camii, 1964 yılında inşa edilmiş ve ada halkının ibadet ihtiyacını karşılayan modern bir camidir. Mimari tasarımıyla dikkat çeken cami, Kınalıada’nın tarihi ve kültürel yapısına farklı bir boyut katmaktadır."
    };

    // 📌 Sadece Büyükada Rum Yetimhanesi için resim var
    Map<String, String> mekanResimleri = {
      "Büyükada Rum Yetimhanesi": "assets/images/buyukada_rum_yetimhanesi.jpg",
      "Aya Yorgi Kilisesi": "assets/images/aya_yorgi_kilisesi.jpg",
      "Heybeliada Ruhban Okulu": "assets/images/heybeliada_ruhban_okulu.jpg",
      "Kınalıada Camii": "assets/images/kinaliada_camii.jpg",
    };

    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 📌 Mekan ismi
          Text(
            mekanAdi,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          SizedBox(height: 8),

          // 📌 Açıklama
          Text(
            mekanBilgileri[mekanAdi] ?? "Bu mekan hakkında bilgi bulunmamaktadır.",
            style: TextStyle(fontSize: 16, color: Colors.blueGrey),
          ),
          SizedBox(height: 16),

          // 📌 Eğer resim varsa göster, yoksa hiç ekleme
          if (mekanResimleri.containsKey(mekanAdi))
            Image.asset(
              mekanResimleri[mekanAdi]!,
              fit: BoxFit.cover,
              width: double.infinity,
              height: 200,
            ),
        ],
      ),
    );
  }
}
